//
//  config.h
//  clms
//
//  Created by ljkj on 2018/9/27.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#ifndef config_h
#define config_h


#define YZTitleScrollViewH  44
// 默认标题间距
static CGFloat const margin = 20;
// 下划线默认高度
static CGFloat const YZUnderLineH = 4;

// 添加标题按钮
static CGFloat const addButtonW = 40;

// 标题缩放比例
static CGFloat const YZTitleTransformScale = 1.3;

#import "UIView+Extension.h"


// 是否是留海屏 系列手机（X XS XSMax XR）
static inline BOOL isIPhoneXSeries(){
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow * mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    return iPhoneXSeries;
}

static inline CGFloat STATUSH() {
    if (isIPhoneXSeries()) {
        return 44.0; // iPhoneX
    } else {
        return 20.0;
    }
}


#endif /* config_h */
