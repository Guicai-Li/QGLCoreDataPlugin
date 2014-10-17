//
//  NSManagedObjectModel+helper.m
//  QGLCoreDataPlugin
//
//  Created by Guicai.Li on 14-10-16.
//  Copyright (c) 2014年 Guicai Li. All rights reserved.
//

#import "NSManagedObjectModel+helper.h"

@implementation NSManagedObjectModel (helper)

+ (NSURL *)URLForManagedObjectModelName:(NSString *)modelName {
    NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    return modelUrl;
}


//+ (NSManagedObjectModel *)URLForMananagedObjectModel:(NSString *)urlStr {
//    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:[NSManagedObjectModel URLForManagedObjectModelName:urlStr]];
//    return model;
//}

@end
