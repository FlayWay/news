//
//  NavigationBar.m
//  clms
//
//  Created by ljkj on 2018/9/26.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "NavigationBar.h"

@implementation NavigationBar

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, NavBarHeight);
    for (UIView *subView in self.subviews) {
        
        NSString *stringFromClass = NSStringFromClass([subView class]);
        
        NSLog(@"stringFromClass====%@",stringFromClass);
        if ([stringFromClass containsString:@"UIBarBackground"]) {
            
            subView.frame = self.bounds;
            
        }else if ([stringFromClass containsString:@"UINavigationBarContentView"]) {
            
            subView.frame = CGRectMake(0, STATUS_BAR_HEIGHT, UIScreen.mainScreen.bounds.size.width, 44);
        }
        
    }
    
}

@end
