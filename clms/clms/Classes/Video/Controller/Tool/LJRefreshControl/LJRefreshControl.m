//
//  LJRefreshControl.m
//  clms
//
//  Created by ljkj on 2018/10/8.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "LJRefreshControl.h"
#import "LJRefreshView.h"

static CGFloat LJRefreshOffset = 60;

@interface LJRefreshControl ()


/**
 刷新控件的父视图,下拉控件适用于 uitableview、uicollectionView
 */
@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, strong) LJRefreshView *refreshView;

@end

@implementation LJRefreshControl

- (LJRefreshView *)refreshView {
    
    if (!_refreshView) {
        
        _refreshView = [LJRefreshView refreshView];
    }
    return _refreshView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

- (void)removeFromSuperview {
    
    [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    [super removeFromSuperview];
    
}

/**
   willMoveToSuperview addSubView时会调用
   - 当添加到父视图的时候，newSuperview是父视图
   - 当父视图被移除的时候，newSuperview是nil
 */
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    NSLog(@"newSuperview===%@",newSuperview);
    
    
    if (![newSuperview isKindOfClass:[UIScrollView class]]) {
        
        return;
    }
    
    self.scrollView = (UIScrollView *)newSuperview;
    // 监听父视图的contentOffset
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

// kvo 监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"self.scrollView===%lf",self.scrollView.contentOffset.y);
    
    if (self.scrollView == nil) {
        
        return;
    }
    
    CGFloat height = -(self.scrollView.contentOffset.y + self.scrollView.contentInset.top);
    NSLog(@"height=====%lf",height);
    
    if (height < 0) {
        
        return;
    }
    
//    // 传递父视图高度
//    if (self.refreshView.refreshState != LJRefreshWillRefresh) {
//
//        self.refreshView.parentViewHeight = height;
//    }
    
    // 可以根据高度设置控件的frame
    self.frame = CGRectMake(0,
                            -height,
                            UIScreen.mainScreen.bounds.size.width,
                            height);
    
    // 判断临界点
    if (self.scrollView.isDragging) {
        
        NSLog(@"refreshState===%ld",self.refreshView.refreshState);
        if (height > LJRefreshOffset && (self.refreshView.refreshState == LJRefreshNormal)) {
            NSLog(@"松开刷新");
            self.refreshView.refreshState = LJRefreshPulling;
        NSLog(@"refreshStat1111===%ld",self.refreshView.refreshState);

        }else if (height <= LJRefreshOffset && (self.refreshView.refreshState == LJRefreshPulling)){
            NSLog(@"在使劲...");
            self.refreshView.refreshState = LJRefreshNormal;
        }
    }else {
        // 放手
        if (self.refreshView.refreshState == LJRefreshPulling) {
            
            NSLog(@"开始刷新");
            // 显示刷新状态视图
//            UIEdgeInsets insets = self.scrollView.contentInset;
//            insets.top += LJRefreshOffset;
//            self.scrollView.contentInset = insets;
            [self beginRefreshing];
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
    
}

/**
 界面设置
 */
- (void)setupUI {
    
    self.refreshView.refreshState = LJRefreshNormal;
    [self addSubview:self.refreshView];
    // 自动布局
    self.refreshView.translatesAutoresizingMaskIntoConstraints = false;
    
    [self addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.refreshView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self addConstraint: [NSLayoutConstraint
                                      constraintWithItem:self.refreshView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
    [self addConstraint: [NSLayoutConstraint
                                      constraintWithItem:self.refreshView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.refreshView.bounds.size.width]];
    
    [self addConstraint: [NSLayoutConstraint
                                      constraintWithItem:self.refreshView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.refreshView.bounds.size.height]];
    
}

/**
 开始刷新
 */
- (void)beginRefreshing {
    
    NSLog(@"开始刷新");
    if (self.scrollView == nil) {
        return;
    }

    if (self.refreshView.refreshState == LJRefreshWillRefresh) {

        return;
    }
    self.refreshView.refreshState = LJRefreshWillRefresh;
     UIEdgeInsets inset = self.scrollView.contentInset;
    inset.top += LJRefreshOffset;
    self.scrollView.contentInset = inset;
//    self.refreshView.parentViewHeight = LJRefreshOffset;
    
}

/**
 结束刷新
 */
- (void)endRefreshing {
    
    NSLog(@"结束刷新");
    // 恢复视图状态
    if (self.scrollView == nil) {
        
        return;
    }
    
    if (self.refreshView.refreshState != LJRefreshWillRefresh) {
        
        return;
    }
    
    self.refreshView.refreshState = LJRefreshNormal;
    UIEdgeInsets inset = self.scrollView.contentInset;
    inset.top -= LJRefreshOffset;
    self.scrollView.contentInset = inset;
}

@end
