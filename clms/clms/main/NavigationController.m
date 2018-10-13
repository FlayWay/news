//
//  NavigationController.m
//  clms
//
//  Created by ljkj on 2018/9/26.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "NavigationController.h"
#import "BaseViewController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setHidden:YES];
    
}

- (void)pushViewController:(BaseViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        NSString *title = @"返回";
        if (self.childViewControllers.count == 1) {
            
            title = self.childViewControllers.firstObject.title ? self.childViewControllers.firstObject.title : @"返回";
        }
        viewController.navItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(popToParent)];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)popToParent {
    
    [self popViewControllerAnimated:YES];
    
}

@end
