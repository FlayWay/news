//
//  LeftCell.m
//  clms
//
//  Created by ljkj on 2018/11/1.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "LeftCell.h"

@interface LeftCell ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *seperatLineView;

@end

@implementation LeftCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.lineView = [[UIView alloc]init];
        self.lineView.backgroundColor = [UIColor redColor];
        [self.contentView insertSubview:self.lineView atIndex:0];
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.seperatLineView = [[UIView alloc]init];
        self.seperatLineView.backgroundColor = [UIColor darkGrayColor];
        [self.contentView addSubview:self.seperatLineView];
    }
    return self;
}

- (void)setModel:(LJLeftModel *)model {
    
    _model = model;
    self.textLabel.text = model.name;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
    
    CGFloat lineViewY = 3;
    CGFloat lineViewW = 3;
    CGFloat lineViewH = self.contentView.height - 2 * lineViewY;
    CGFloat lineViewX = 0;
    self.lineView.frame = CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH);
    
    CGFloat seperatLineViewX = 5;
    CGFloat seperatLineVieH = 1;
    CGFloat seperatLineViewY = self.contentView.height - seperatLineVieH;
    CGFloat seperatLineViewW = self.contentView.width - 2 * seperatLineViewX;
    self.seperatLineView.frame = CGRectMake(seperatLineViewX, seperatLineViewY, seperatLineViewW, seperatLineVieH);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        self.lineView.hidden = NO;
        self.textLabel.textColor = [UIColor redColor];
    }else {
        self.lineView.hidden = YES;
        self.textLabel.textColor = [UIColor darkGrayColor];
    }
    
}

@end
