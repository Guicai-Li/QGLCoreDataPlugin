//
//  NSPersistentStoreCoordinator+helper.m
//  QGLCoreDataPlugin
//
//  Created by Guicai.Li on 14-10-16.
//  Copyright (c) 2014年 Guicai Li. All rights reserved.
//

#import "NSPersistentStoreCoordinator+helper.h"

@implementation NSPersistentStoreCoordinator (helper)

+ (NSURL *)URLForNSPersistentStoreCoordinatorName:(NSString *)fileName {
    NSString *dbFileName = [NSString stringWithFormat:@"%@.sqlite", fileName];
    return [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:dbFileName];
}

@end
