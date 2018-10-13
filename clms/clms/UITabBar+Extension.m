//
//  UITabBar+Extension.m
//  clms
//
//  Created by ljkj on 2018/9/26.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "UITabBar+Extension.h"

#define TabbarItemNums 4.0

@implementation UITabBar (Extension)

- (void)showBadgeOnItemIndex:(int)index {
    
    // 移除小红点
    [self removeBadgeOnItemIndex:index];
    
    // 新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 5;
    CGRect tabFrame = self.frame;
    badgeView.backgroundColor = [UIColor redColor];
    
    // 确定小红点位置
    float percentX = (index+0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 10, 10);
    [self addSubview:badgeView];
}

- (void)hideBadgeOnItemIndex:(int)index {
    
    [self removeBadgeOnItemIndex:index];
}

/**
 移除小红点
 */
- (void)removeBadgeOnItemIndex:(int)index {
    
    for (UIView *subView in self.subviews) {
        
        if (subView.tag == 888 + index || subView.tag == 100 + index) {
            
            [subView removeFromSuperview];
        }
    }
}

- (void)showBageOnItemWithIndex:(int)index value:(NSString *)valueStr {
    
    [self removeBadgeOnItemIndex:index];
    
    UILabel *badgeLabel = [[UILabel alloc]init];
    badgeLabel.backgroundColor = [UIColor redColor];
    badgeLabel.tag = 100 + index;
    CGRect tabFrame = self.frame;
    // 确定小红点位置
    float percentX = (index + 0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    
    badgeLabel.frame = CGRectMake(x, y, 12, 12);
    badgeLabel.layer.cornerRadius = 6;
    badgeLabel.layer.masksToBounds = YES;
    [self addSubview:badgeLabel];
    badgeLabel.text = valueStr;
    badgeLabel.textColor = [UIColor whiteColor];
    badgeLabel.textAlignment = NSTextAlignmentCenter;
    badgeLabel.font = [UIFont systemFontOfSize:10];
    
}

@end
