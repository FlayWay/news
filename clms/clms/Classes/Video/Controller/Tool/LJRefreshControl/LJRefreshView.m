//
//  LJRefreshView.m
//  clms
//
//  Created by ljkj on 2018/10/8.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "LJRefreshView.h"

@interface LJRefreshView()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UILabel *tipLab;
@property (weak, nonatomic) IBOutlet UIImageView *tipIcon;


@end


@implementation LJRefreshView


- (void)setRefreshState:(LJRefreshState)refreshState {
    
    _refreshState = refreshState;
    switch (refreshState) {
        case LJRefreshNormal:
        {
            _tipLab.text = @"下拉可以刷新";
            _tipIcon.hidden = false;
            [_indicator stopAnimating];
            [UIView animateWithDuration:0.25 animations:^{
               self.tipIcon.transform = CGAffineTransformIdentity;
            }];
        }
            break;
        case LJRefreshPulling:
        {
            _tipLab.text = @"松开立即刷新";
            _tipIcon.hidden = false;
            [_indicator stopAnimating];
            [UIView animateWithDuration:0.25 animations:^{
               
                self.tipIcon.transform = CGAffineTransformMakeRotation(M_PI-0.001);
            }];
        }
            break;
        case LJRefreshWillRefresh:
        {
            _tipLab.text = @"正在刷新数据";
            _tipIcon.hidden = true;
            [_indicator startAnimating];
            
        }
            break;
        }
    
}


+(LJRefreshView *)refreshView {
    
//    LJHumanRefreshView
//    LJRefreshView
//    LJMeiRefreshView
    UINib *nib = [UINib nibWithNibName:@"LJMeiRefreshView" bundle:nil];
    return [nib instantiateWithOwner:nil options:nil][0];
}

@end
