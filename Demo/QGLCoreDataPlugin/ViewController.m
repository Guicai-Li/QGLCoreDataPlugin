//
//  ViewController.m
//  QGLCoreDataPlugin
//
//  Created by Guicai.Li on 14-10-16.
//  Copyright (c) 2014年 Guicai Li. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataActivity.h"

@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *array;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);

    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    dispatch_async(globalQueue, ^{
        
        NSManagedObjectContext *context = [[CoreDataActivity shareInstance] createChildManagedObjectContext];
//TODO: Must using performBlockAndWait to manage childContext
        [context performBlockAndWait:^{
            self.array = [[CoreDataActivity shareInstance] attributeForEntity:@"Entity"];
        }];

        dispatch_async(mainQueue, ^{
            NSLog(@"%@", self.array);
        });
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
