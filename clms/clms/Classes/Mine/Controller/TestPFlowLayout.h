//
//  TestPFlowLayout.h
//  clms
//
//  Created by ljkj on 2018/10/17.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TestPFlowLayout;

@protocol TestPFlowLayoutDelegate <NSObject>

@required
- (CGFloat)waterflowLayout:(TestPFlowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional

- (CGFloat)columnCountInWaterflowLayout:(TestPFlowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(TestPFlowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(TestPFlowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(TestPFlowLayout *)waterflowLayout;

@end


@interface TestPFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) NSArray *shops;
@property (nonatomic, weak) id<TestPFlowLayoutDelegate> delegate;

@end
