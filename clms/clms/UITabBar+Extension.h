//
//  UITabBar+Extension.h
//  clms
//
//  Created by ljkj on 2018/9/26.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Extension)

- (void)showBadgeOnItemIndex:(int)index;
- (void)hideBadgeOnItemIndex:(int)index;
- (void)showBageOnItemWithIndex:(int)index value:(NSString *)valueStr;
@end
