//
//  NSManagedObject+helper.m
//  QGLCoreDataPlugin
//
//  Created by Guicai.Li on 14-10-16.
//  Copyright (c) 2014年 Guicai Li. All rights reserved.
//


#import "NSManagedObject+helper.h"
#import "CoreDataActivity.h"

@implementation NSManagedObject (helper)

+ (id)createNSManagedObjectForName:(NSString *)name {
//TODO:To judge whether the Main Thread. This is importmeng!
    CoreDataActivity *coreDateActivity = [CoreDataActivity shareInstance];
    NSManagedObjectContext *context = [NSThread mainThread] ? coreDateActivity.managedObjectContext : coreDateActivity.childManagedObjectContext;
    
    return [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:context];
}

+ (void)deleteNSManagedObject:(id)object {
    [[CoreDataActivity shareInstance].managedObjectContext deleteObject:object];
}

@end
