//
//  NSFetchRequest+helper.m
//  QGLCoreDataPlugin
//
//  Created by Guicai.Li on 14-10-17.
//  Copyright (c) 2014年 Guicai Li. All rights reserved.
//

#import "NSFetchRequest+helper.h"

@implementation NSFetchRequest (helper)


+ (NSFetchRequest *)fetchRequestWithManagedObjectContext:(NSManagedObjectContext *)contect EntityName:(NSString *)entityName {
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:contect];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
    return fetchRequest;
}

+ (NSFetchRequest *)fetchRequestWithManagedObjectContext:(NSManagedObjectContext *)contect EntityName:(NSString *)entityName SortDescriptorName:(NSString *)sortDescriptorName {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithManagedObjectContext:contect EntityName:entityName];
    if (sortDescriptorName && ![sortDescriptorName isEqualToString:@""]) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortDescriptorName ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [fetchRequest setSortDescriptors:sortDescriptors];
    }
    return fetchRequest;
}

+ (NSFetchRequest *)fetchRequestWithManagedObjectContext:(NSManagedObjectContext *)contect EntityName:(NSString *)entityName Predicate:(NSPredicate *)predicate {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithManagedObjectContext:contect EntityName:entityName];
    [fetchRequest setPredicate:predicate];
    return fetchRequest;
}

+ (NSFetchRequest *)fetchRequestWithManagedObjectContext:(NSManagedObjectContext *)contect EntityName:(NSString *)entityName Predicate:(NSPredicate *)predicate Offset:(NSInteger)offset {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithManagedObjectContext:contect EntityName:entityName Predicate:predicate];
    if (offset > 0) {
        [fetchRequest setFetchOffset:offset];
    }
    return fetchRequest;
}

+ (NSFetchRequest *)fetchRequestWithManagedObjectContext:(NSManagedObjectContext *)contect EntityName:(NSString *)entityName Predicate:(NSPredicate *)predicate Limit:(NSInteger)limit {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithManagedObjectContext:contect EntityName:entityName Predicate:predicate];
    if (limit > 0) {
        [fetchRequest setFetchLimit:limit];
    }
    return fetchRequest;
}

+ (NSFetchRequest *)fetchRequestWithManagedObjectContext:(NSManagedObjectContext *)contect EntityName:(NSString *)entityName Predicate:(NSPredicate *)predicate Offset:(NSInteger)offset Limit:(NSInteger)limit {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithManagedObjectContext:contect EntityName:entityName Predicate:predicate];
    if (offset > 0) {
        [fetchRequest setFetchOffset:offset];
    }
    if (limit > 0) {
        [fetchRequest setFetchLimit:limit];
    }
    return fetchRequest;
}

//TODO:Using NSPredicate and SortDescriptorName

+ (NSFetchRequest *)fetchRequestWithManagedObjectContext:(NSManagedObjectContext *)contect EntityName:(NSString *)entityName SortByAttributeName:(NSString *)sortDescriptorName Predicate:(NSPredicate *)predicate {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithManagedObjectContext:contect EntityName:entityName Predicate:predicate];
    if (sortDescriptorName && ![sortDescriptorName isEqualToString:@""]) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortDescriptorName ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [fetchRequest setSortDescriptors:sortDescriptors];
    }
    return fetchRequest;
}

+ (NSFetchRequest *)fetchRequestWithManagedObjectContext:(NSManagedObjectContext *)contect EntityName:(NSString *)entityName SortByAttributeName:(NSString *)sortDescriptorName Predicate:(NSPredicate *)predicate Offset:(NSInteger)offset {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithManagedObjectContext:contect EntityName:entityName SortByAttributeName:sortDescriptorName Predicate:predicate];
    if (offset > 0) {
        [fetchRequest setFetchOffset:offset];
    }
    return fetchRequest;
}

+ (NSFetchRequest *)fetchRequestWithManagedObjectContext:(NSManagedObjectContext *)contect EntityName:(NSString *)entityName SortByAttributeName:(NSString *)sortDescriptorName Predicate:(NSPredicate *)predicate Limit:(NSInteger)limit {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithManagedObjectContext:contect EntityName:entityName SortByAttributeName:sortDescriptorName Predicate:predicate];
    if (limit > 0) {
        [fetchRequest setFetchLimit:limit];
    }
    return fetchRequest;
}

+ (NSFetchRequest *)fetchRequestWithManagedObjectContext:(NSManagedObjectContext *)contect EntityName:(NSString *)entityName SortByAttributeName:(NSString *)sortDescriptorName Predicate:(NSPredicate *)predicate Offset:(NSInteger)offset Limit:(NSInteger)limit {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithManagedObjectContext:contect EntityName:entityName SortByAttributeName:sortDescriptorName Predicate:predicate];
    if (offset > 0) {
        [fetchRequest setFetchOffset:offset];
    }
    if (limit > 0) {
        [fetchRequest setFetchLimit:limit];
    }
    return fetchRequest;
}
@end
