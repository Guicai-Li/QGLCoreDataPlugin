//
//  NSFetchRequest+helper.h
//  QGLCoreDataPlugin
//
//  Created by Guicai.Li on 14-10-17.
//  Copyright (c) 2014年 Guicai Li. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface NSFetchRequest (helper)

//TODO:

+ (NSFetchRequest *)fetchRequestWithManagedObjectContext:(NSManagedObjectContext *)contect EntityName:(NSString *)entityName;

+ (NSFetchRequest *)fetchRequestWithManagedObjectContext:(NSManagedObjectContext *)contect EntityName:(NSString *)entityName SortDescriptorName:(NSString *)sortDescriptorName;


//TODO:Using NSPredicate

+ (NSFetchRequest *)fetchRequestWithManagedObjectContext:(NSManagedObjectContext *)contect EntityName:(NSString *)entityName Predicate:(NSPredicate *)predicate;

+ (NSFetchRequest *)fetchRequestWithManagedObjectContext:(NSManagedObjectContext *)contect EntityName:(NSString *)entityName Predicate:(NSPredicate *)predicate Offset:(NSInteger)offset;

+ (NSFetchRequest *)fetchRequestWithManagedObjectContext:(NSManagedObjectContext *)contect EntityName:(NSString *)entityName Predicate:(NSPredicate *)predicate Limit:(NSInteger)limit;

+ (NSFetchRequest *)fetchRequestWithManagedObjectContext:(NSManagedObjectContext *)contect EntityName:(NSString *)entityName Predicate:(NSPredicate *)predicate Offset:(NSInteger)offset Limit:(NSInteger)limit;

//TODO:Using NSPredicate and SortDescriptorName

+ (NSFetchRequest *)fetchRequestWithManagedObjectContext:(NSManagedObjectContext *)contect EntityName:(NSString *)entityName SortByAttributeName:(NSString *)sortDescriptorName Predicate:(NSPredicate *)predicate;

+ (NSFetchRequest *)fetchRequestWithManagedObjectContext:(NSManagedObjectContext *)contect EntityName:(NSString *)entityName SortByAttributeName:(NSString *)sortDescriptorName Predicate:(NSPredicate *)predicate Offset:(NSInteger)offset;

+ (NSFetchRequest *)fetchRequestWithManagedObjectContext:(NSManagedObjectContext *)contect EntityName:(NSString *)entityName SortByAttributeName:(NSString *)sortDescriptorName Predicate:(NSPredicate *)predicate Limit:(NSInteger)limit;

+ (NSFetchRequest *)fetchRequestWithManagedObjectContext:(NSManagedObjectContext *)contect EntityName:(NSString *)entityName SortByAttributeName:(NSString *)sortDescriptorName Predicate:(NSPredicate *)predicate Offset:(NSInteger)offset Limit:(NSInteger)limit;
@end

