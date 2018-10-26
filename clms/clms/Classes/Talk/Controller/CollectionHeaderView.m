//
//  CollectionHeaderView.m
//  clms
//
//  Created by ljkj on 2018/10/24.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "CollectionHeaderView.h"

@interface CollectionHeaderView ()

@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *nameDetailLab;


@end

@implementation CollectionHeaderView


- (UIButton *)editBtn {
    if (_editBtn == nil) {
        
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _editBtn.backgroundColor = [UIColor redColor];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        _editBtn.layer.cornerRadius = 15;
        _editBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _editBtn.layer.masksToBounds = YES;
    }
    return _editBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor darkGrayColor];

        self.nameLab = [[UILabel alloc]init];
        self.nameLab.text = @"我的栏目";
//        self.nameLab.backgroundColor = [UIColor redColor];
        [self addSubview:self.nameLab];
        
        self.nameDetailLab = [[UILabel alloc]init];
//        self.nameDetailLab.backgroundColor = [UIColor brownColor];
        self.nameDetailLab.text = @"点击进入栏目";
        self.nameDetailLab.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.nameDetailLab];
        
        [self addSubview:self.editBtn];

        
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.nameLab.frame = CGRectMake(10, 10, 100, self.bounds.size.height-20);
    
    self.nameDetailLab.frame = CGRectMake(CGRectGetMaxX(self.nameLab.frame), 10, 100, self.bounds.size.height -20);
    
    CGFloat editBtnW = 60;
    CGFloat editBtnH = 30;
    self.editBtn.frame = CGRectMake(self.bounds.size.width - editBtnW - 20, 15, editBtnW, editBtnH);
    
}

@end
