//
//  CoreDataActivity.h
//  QGLCoreDataPlugin
//
//  Created by Guicai.Li on 14-10-16.
//  Copyright (c) 2014年 Guicai Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DEBUG.h"
#import "NSFetchRequest+helper.h"
#import "NSManagedObject+helper.h"
#import "NSManagedObjectModel+helper.h"
#import "NSPersistentStoreCoordinator+helper.h"


@import CoreData;

@interface CoreDataActivity : NSObject
// Parent Context
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
// Child Context
@property (strong, nonatomic) NSManagedObjectContext *childManagedObjectContext;

@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (CoreDataActivity *)shareInstance;

- (NSManagedObjectContext *)createChildManagedObjectContext;

- (void)saveContext;

- (void)deleteWithEntity:(NSString *)entityName attributeName:(NSString *)attributeName value:(id)value;

- (void)updateWithEntity:(NSString *)entityName attributeName:(NSString *)attributeName oldValue:(id)oldValue newValue:(id)newValue;

- (NSArray *)attributeForEntity:(NSString *)entityName;
- (NSArray *)attributeForEntity:(NSString *)entityName sortByAttributeName:(NSString *)sortDescriptorName;



@end
