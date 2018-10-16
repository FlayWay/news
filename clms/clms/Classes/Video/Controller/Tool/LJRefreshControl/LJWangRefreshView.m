//
//  LJWangRefreshView.m
//  clms
//
//  Created by ljkj on 2018/10/15.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "LJWangRefreshView.h"


@interface LJWangRefreshView ()

@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *whiteView;

@end

@implementation LJWangRefreshView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.redView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        self.redView.center = CGPointMake(self.center.x, self.center.y - 20);
        self.redView.backgroundColor = [UIColor redColor];
        self.redView.layer.cornerRadius = 10;
        self.redView.layer.masksToBounds = true;
        [self addSubview:self.redView];
        self.redView.transform = CGAffineTransformMakeScale(0, 0);
        self.redView.alpha = 0;
        
        
        self.whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        self.whiteView.backgroundColor = [UIColor whiteColor];
        self.whiteView.center = CGPointMake(self.center.x, self.center.y - 20);
        self.whiteView.layer.cornerRadius = 5;
        self.whiteView.layer.masksToBounds = true;
        [self addSubview:self.whiteView];
         self.whiteView.transform = CGAffineTransformMakeScale(0, 0);
        
    }
    return self;
}

- (void)setParentViewHeight:(CGFloat)parentViewHeight {
    
    if (parentViewHeight < 30) {
        
        self.redView.alpha = 0;
        return;
    }
    CGFloat scale;
    
    if (parentViewHeight > 60) {
        scale = 1;
    }else {
        scale = 1 - (60 - parentViewHeight) / (60 -30);
    }
    self.redView.alpha = scale;
    self.redView.transform = CGAffineTransformMakeScale(scale, scale);
    self.whiteView.transform = CGAffineTransformMakeScale(scale, scale);
    
    if (self.refreshState == LJRefreshWillRefresh) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.redView.transform = CGAffineTransformMakeScale(0.8, 0.8);
            self.whiteView.transform = CGAffineTransformMakeScale(0.8, 0.8);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self.redView.transform = CGAffineTransformMakeScale(scale, scale);
                self.whiteView.transform = CGAffineTransformMakeScale(scale, scale);
            }];
            
        }];
        
    }
    
}


@end
