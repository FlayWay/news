//
//  LJFlowLayout.m
//  clms
//
//  Created by ljkj on 2018/9/28.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "LJFlowLayout.h"

@implementation LJFlowLayout

- (void)prepareLayout {
    
    [super prepareLayout];
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    if (self.collectionView.bounds.size.height) {
        self.itemSize = self.collectionView.bounds.size;
    }
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

@end
