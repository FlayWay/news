//
//  AddNormalCell.m
//  clms
//
//  Created by ljkj on 2018/10/26.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "AddNormalCell.h"


@interface AddNormalCell ()

@property (nonatomic, strong) UILabel *editLab;
@property (nonatomic, strong) UILabel *titleLab;

@end


@implementation AddNormalCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor blueColor].CGColor;
        
        _editLab = [[UILabel alloc]init];
        _editLab.text = @"+";
        _editLab.textColor = [UIColor darkGrayColor];
        _editLab.textAlignment = NSTextAlignmentCenter;
        _editLab.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.editLab];
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = [UIColor darkGrayColor];
        _titleLab.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_titleLab];
        
        
    }
    return self;
}


- (void)setModel:(LJPtModel *)model {
    
    _model = model;
    _titleLab.text = model.str;
    [self layoutSubviews];
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.editLab.frame = CGRectMake(10, 0,10, self.titleLab.bounds.size.height);
    CGFloat x = CGRectGetMaxX(self.editLab.frame);
    CGFloat w = self.bounds.size.width - self.editLab.bounds.size.width - x;
    self.titleLab.frame = CGRectMake(x, 0, w,self.bounds.size.height);
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.editLab.hidden = NO;
}


@end
