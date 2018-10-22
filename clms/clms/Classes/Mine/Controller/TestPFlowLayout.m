//
//  TestPFlowLayout.m
//  clms
//
//  Created by ljkj on 2018/10/17.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "TestPFlowLayout.h"
#import "LJShopModel.h"

static const CGFloat LJDefaultColCount = 3;
static const CGFloat LJDefaultColMargin = 10;
static const CGFloat LJDefaultRowMargin = 10;
static const UIEdgeInsets LJDefaultEdgeMargin = {10, 10, 10, 10};

@interface TestPFlowLayout ()

// 存放所有cell的布局属性
@property (nonatomic, strong) NSMutableArray *attrsArr;
// 存放所有列的最大Y值
@property (nonatomic, strong) NSMutableArray *columnHeights;

@end

@implementation TestPFlowLayout

//完成布局前的初始工作
//-(void)prepareLayout;
//collectionView的内容尺寸
//-(CGSize)collectionViewContentSize;
//为每个item设置属性
//-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath;
//获取制定范围的所有item的属性
//-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect;
//-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds;

- (NSMutableArray *)attrsArr {
    if (!_attrsArr) {
        
        _attrsArr = [NSMutableArray array];
    }
    return _attrsArr;
}

- (NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

/**
 初始化
 */
- (void)prepareLayout {
    
    [super prepareLayout];
    
    // 清除以前计算的所有高度
    [self.columnHeights removeAllObjects];
    for (NSInteger i=0; i<LJDefaultColCount; i++) {
        
        [self.columnHeights addObject:@(LJDefaultEdgeMargin.top)];
    }
    // 清除之前所有的布局属性
    [self.attrsArr removeAllObjects];
    // 开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView  numberOfItemsInSection:0];
    
    for (NSInteger i=0; i<count; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        // 获取cell布局属性
        UICollectionViewLayoutAttributes *layoutAttr = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArr addObject:layoutAttr];
    }
}

/**
 决定cell的布局
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return self.attrsArr;
}

/**
 返回index位置 cell 对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 获取cell布局属性
    UICollectionViewLayoutAttributes *layoutAttr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    // 设置cell布局属性的frame
    CGFloat collectionW = self.collectionView.bounds.size.width;
   
    CGFloat w = (collectionW - LJDefaultEdgeMargin.left - LJDefaultEdgeMargin.right - (LJDefaultColCount - 1) * LJDefaultColMargin) / LJDefaultColCount;
    CGFloat h = 50 + arc4random_uniform(100);
    
    // 找出高度最短的呢一列
     NSInteger destColumn = 0;
     CGFloat minColumnHeight = [self.columnHeights[0] floatValue] ;
    
    for (NSInteger i=0; i<self.columnHeights.count; i++) {
        // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] floatValue];
        if ( minColumnHeight > columnHeight) {
                minColumnHeight = columnHeight;
                destColumn = i;
            }
    }
    
    CGFloat x = LJDefaultEdgeMargin.left + destColumn * (w + LJDefaultColMargin);
    CGFloat y = minColumnHeight;
    if (y != LJDefaultEdgeMargin.top) {
        
        y += LJDefaultRowMargin;
    }
    layoutAttr.frame = CGRectMake(x, y,w, h);
    // 更新最短那列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(layoutAttr.frame));
    return layoutAttr;
}

/**
 返回collectionView内容大小
 */
- (CGSize)collectionViewContentSize {
    
    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < LJDefaultColCount; i++) {
        // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (maxColumnHeight < columnHeight) {
            maxColumnHeight = columnHeight;
        }
    }
    return CGSizeMake(0, maxColumnHeight + LJDefaultEdgeMargin.bottom);
}

@end
