//
//  CoreDataActivity.m
//  QGLCoreDataPlugin
//
//  Created by Guicai.Li on 14-10-16.
//  Copyright (c) 2014年 Guicai Li. All rights reserved.
//

// References:
// http://cutecoder.org/featured/asynchronous-core-data-document/
// http://www.touchwonders.com/fast-and-non-blocking-core-data-back-end-programming/
// http://benedictcohen.co.uk/blog/archives/308

#import "CoreDataActivity.h"


#warning mark - Change your CoreDataFileName
#define CoreDataFileName @"QGLCoreDataPlugin"


static CoreDataActivity *coreDataActivity = nil;

@implementation CoreDataActivity

#pragma mark - SingleInstance
+ (CoreDataActivity *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coreDataActivity = [[CoreDataActivity alloc] init];
        [coreDataActivity initCoreData];
    });
    return coreDataActivity;
}

#pragma mark - Init for CoreData
- (void)initCoreData {
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
        
        _childManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_childManagedObjectContext setParentContext:_managedObjectContext];
    }
}

#pragma mark - Creating the parent context
// Just create your
// NSManagedObjectModel
// and
// NSPersistentStoreCoordinator
// as before

// Initialize the parent
// NSManagedObjectContext
// by setting its concurrency type to
// NSMainQueueConcurrencyType

//Set the persistentStoreCoordinator of the newly created context
- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:[NSManagedObjectModel URLForManagedObjectModelName:CoreDataFileName]];
    return model;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [NSPersistentStoreCoordinator URLForNSPersistentStoreCoordinatorName:CoreDataFileName];
    NSError *error = nil;
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        DLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return persistentStoreCoordinator;
}

#pragma mark - Creating the child context

// Create a new
// NSManagedObjectContext
// with concurrency type
// NSPrivateQueueConcurrencyType

// Set its parentContext (setParentContext:) to the above created
// NSManagedObjectContext

- (NSManagedObjectContext *)childManagedObjectContext {
    if (_childManagedObjectContext) {
        return _childManagedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator) {
        _childManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_childManagedObjectContext setPersistentStoreCoordinator:coordinator];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(childMergeChangesFromContextDidSaveNotification:) name:NSManagedObjectContextDidSaveNotification object:_childManagedObjectContext];
    }
    return _childManagedObjectContext;
}

- (void)childMergeChangesFromContextDidSaveNotification:(NSNotification *)notification
{
    DLog(@"ChildContext did save.");
    [self performSelectorOnMainThread:@selector(mainMergeChangesFromContextDidSaveNotification:)
                           withObject:notification
                        waitUntilDone:YES];
}

- (void)mainMergeChangesFromContextDidSaveNotification:(NSNotification *)notification {
    [[self managedObjectContext] mergeChangesFromContextDidSaveNotification:notification];
}


- (NSManagedObjectContext *)createChildManagedObjectContext {
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [context setParentContext:_managedObjectContext];
    return context;
}

#pragma mark -SaveContext
//MARK:Consider about synchronous or asynchronous
/*
 When you cannot guarantee to conform to thread confinement (or you just want to be sure). One can pass a block which does some heavy work using the desired managedObjectContext and Core Data will automatically schedule the block for execution and uses the correct thread. Depending on which function is called the operation will be synchronous (
 performBlockAndWait:
 ) or asynchronous (
 performBlock:
 ).
 */

- (void)saveContext {
//TODO:First sava childManagedObjectContext and then save the main Quene's managedObjectContext.

//    NSError *error = nil;
//    if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
//        ELog(error);
//        abort();
//    }
    
//BETTER:It's better using performBlock rather than performBlockAndWait.Or you will wait for the block to be performed.
    [self.childManagedObjectContext performBlock:^{
        NSError *error = nil;
        [self.childManagedObjectContext save:&error];
        
        [self.managedObjectContext performBlock:^{
            NSError *parentError = nil;
            [self.managedObjectContext save:&parentError];
        }];
    }];
}

/*
 ========================================================================================================================
Things to remember:

After creating or modifying a
NSManagedObject
save to its managedObjectContext to keep everything in sync!
Objects created in one managedObjectContext cannot be used in another managedObjectContext without triggering an exception. Always convert them to the managedObjectContext you want to use them in. Check out the github link down below for some sample code.
 ========================================================================================================================
*/

// Normal Operation

- (void)deleteWithEntity:(NSString *)entityName attributeName:(NSString *)attributeName value:(id)value {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", attributeName, value];
    NSFetchRequest *fetchRequst = [NSFetchRequest fetchRequestWithManagedObjectContext:self.managedObjectContext EntityName:entityName SortByAttributeName:attributeName Predicate:predicate];
    NSError *error = nil;
    NSArray *resultArray = [self.managedObjectContext executeFetchRequest:fetchRequst error:&error];
    if (error) {
        ELog(error);
    }
    if ([resultArray count]) {
        for (id obj in resultArray) {
            [self.managedObjectContext deleteObject:obj];
        }
    }
    [self saveContext];
}

- (void)updateWithEntity:(NSString *)entityName attributeName:(NSString *)attributeName oldValue:(id)oldValue newValue:(id)newValue {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", attributeName, oldValue];
    NSFetchRequest *fetchRequst = [NSFetchRequest fetchRequestWithManagedObjectContext:self.managedObjectContext EntityName:entityName SortByAttributeName:attributeName Predicate:predicate];
    NSError *error = nil;
    NSArray *resultArray = [self.managedObjectContext executeFetchRequest:fetchRequst error:&error];
    if (error) {
        ELog(error);
    }
    if ([resultArray count]) {
        for (int i = 0; i < [resultArray count]; i ++) {
            [[resultArray objectAtIndex:i] setValue:newValue forKey:attributeName];
        }
    }
    [self saveContext];
}

- (NSArray *)attributeForEntity:(NSString *)entityName {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    return [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
}

- (NSArray *)attributeForEntity:(NSString *)entityName sortByAttributeName:(NSString *)sortDescriptorName {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithManagedObjectContext:self.managedObjectContext EntityName:entityName SortDescriptorName:sortDescriptorName];
    return [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
}



@end
