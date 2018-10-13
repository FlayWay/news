//
//  LJRefreshControl.h
//  clms
//
//  Created by ljkj on 2018/10/8.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 
 - Normal: 普通状态，什么都不做
 - Pulling: 超过临界点，如果松手，开始刷新
 - WillRefresh: 超过临界点，并且放手
 */

typedef NS_ENUM(NSUInteger,LJRefreshState) {
    LJRefreshNormal,
    LJRefreshPulling,
    LJRefreshWillRefresh
};

@interface LJRefreshControl : UIControl


/**
 开始刷新
 */
- (void)beginRefreshing;

/**
 结束刷新
 */
- (void)endRefreshing;

@end
