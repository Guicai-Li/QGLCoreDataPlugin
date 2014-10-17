//
//  Entity.h
//  QGLCoreDataPlugin
//
//  Created by Guicai.Li on 14-10-17.
//  Copyright (c) 2014年 Guicai Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * number;

@end
