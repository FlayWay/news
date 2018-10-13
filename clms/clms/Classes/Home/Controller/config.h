//
//  config.h
//  clms
//
//  Created by ljkj on 2018/9/27.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#ifndef config_h
#define config_h


// 判断是否是iPhone X
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
// 导航栏高度
#define NavBarHeight (iPhoneX ? 88.f : 64.f)
// tabBar高度
#define TabBarHeight (iPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)

#define YZTitleScrollViewH  44
// 默认标题间距
static CGFloat const margin = 20;
// 下划线默认高度
static CGFloat const YZUnderLineH = 4;
// 标题缩放比例
static CGFloat const YZTitleTransformScale = 1.3;

#import "UIView+Extension.h"

#endif /* config_h */
