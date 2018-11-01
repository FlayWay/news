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

// 标题被点击或者内容滚动完成，会发出这个通知，监听这个通知，可以做自己想要做的事情，比如加载数据
static NSString * const LJDisplayViewClickOrScrollDidFinshNote = @"YZDisplayViewClickOrScrollDidFinshNote";

// 重复点击通知
static NSString * const LJDisplayViewRepeatClickTitleNote = @"YZDisplayViewRepeatClickTitleNote";


#endif /* config_h */
