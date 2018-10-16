//
//  LJRefreshView.h
//  clms
//
//  Created by ljkj on 2018/10/8.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJRefreshControl.h"

@interface LJRefreshView : UIView

@property (nonatomic, assign) LJRefreshState refreshState;
@property (nonatomic, assign) CGFloat parentViewHeight;


+(LJRefreshView *)refreshView;

@end
