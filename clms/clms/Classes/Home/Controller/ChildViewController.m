//
//  ChildViewController.m
//  clms
//
//  Created by ljkj on 2018/9/27.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "ChildViewController.h"
#import "TableViewController.h"


@interface ChildViewController ()

@end

@implementation ChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setupChildConrollers];
}


- (NSArray *)titlesArr {
    
    return @[@"测试1",
             @"测试2",
             @"测试3"];
}

- (void)setupChildConrollers {
    
    [self.titlesArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        TableViewController *vc = [[TableViewController alloc]init];
        vc.title = obj;
        [self addChildViewController:vc];
    }];
}


@end
