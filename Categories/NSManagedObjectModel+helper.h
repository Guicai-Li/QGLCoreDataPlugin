//
//  NSManagedObjectModel+helper.h
//  QGLCoreDataPlugin
//
//  Created by Guicai.Li on 14-10-16.
//  Copyright (c) 2014年 Guicai Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreData;

@interface NSManagedObjectModel (helper)

+ (NSURL *)URLForManagedObjectModelName:(NSString *)modelName;

//+ (NSManagedObjectModel *)URLForMananagedObjectModel:(NSString *)urlStr;

@end
