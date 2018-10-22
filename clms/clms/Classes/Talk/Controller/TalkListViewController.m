//
//  TalkListViewController.m
//  clms
//
//  Created by ljkj on 2018/10/15.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "TalkListViewController.h"
#import "TableViewController.h"
#import "PresentViewController.h"

@interface TalkListViewController ()

@end

@implementation TalkListViewController

- (NSArray *)titlesArr {
    
    return @[@"测试1",
             @"测试2",
             @"测试3",
             @"测试4",
             @"测试5",
             @"测试6",
             @"测试7",
             @"测试8哈哈哈哈"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildConrollers];
}

- (void)setupChildConrollers {
    
    [self.titlesArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        TableViewController *vc = [[TableViewController alloc]init];
        vc.title = obj;
        [self addChildViewController:vc];
    }];
}

- (void)rightBtnAction {
    
    NSLog(@"弹框");
    [self.navigationController presentViewController:[PresentViewController new] animated:true completion:nil];
}

@end
