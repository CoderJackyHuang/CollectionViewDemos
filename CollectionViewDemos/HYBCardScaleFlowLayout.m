//
//  HYBCardScaleFlowLayout.m
//  CollectionViewDemos
//
//  Created by huangyibiao on 16/3/27.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBCardScaleFlowLayout.h"

@interface HYBCardScaleFlowLayout ()

@property (nonatomic, assign) CGFloat previousOffsetX;

@end

@implementation HYBCardScaleFlowLayout

#pragma mark - Override
- (void)prepareLayout {
  self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  self.minimumLineSpacing = 20;
  //  self.minimumInteritemSpacing = 20;
  self.sectionInset = UIEdgeInsetsMake(0, 30, 0, 30);
  self.itemSize = CGSizeMake(self.collectionView.frame.size.width - 60,
                             self.collectionView.frame.size.height - 180);
  [super prepareLayout];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
  return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
  NSArray *superAttributes = [super layoutAttributesForElementsInRect:rect];
  NSArray *attributes = [[NSArray alloc] initWithArray:superAttributes copyItems:YES];
  
  CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x,
                                  self.collectionView.contentOffset.y,
                                  self.collectionView.frame.size.width,
                                  self.collectionView.frame.size.height);
  CGFloat offset = CGRectGetMidX(visibleRect);
  
  [attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL * _Nonnull stop) {
    CGFloat distance = offset - attribute.center.x;
    // 越往中心移动，值越小，那么缩放就越小，从而显示就越大
    // 同样，超过中心后，越往左、右走，缩放就越大，显示就越小
    CGFloat scaleForDistance = distance / self.itemSize.height;
    // 0.2可调整，值越大，显示就越大
    CGFloat scaleForCell = 1 + 0.2 * (1 - fabs(scaleForDistance));
    
    // only scale y-axis
    attribute.transform3D = CATransform3DMakeScale(1, scaleForCell, 1);
    attribute.zIndex = 1;
  }];
  
  return attributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
  // 分页以1/3处
  if (proposedContentOffset.x > self.previousOffsetX + self.itemSize.width / 3.0) {
    self.previousOffsetX += self.collectionView.frame.size.width - self.minimumLineSpacing * 2;
  } else if (proposedContentOffset.x < self.previousOffsetX  - self.itemSize.width / 3.0) {
    self.previousOffsetX -= self.collectionView.frame.size.width - self.minimumLineSpacing * 2;
  }
  
  proposedContentOffset.x = self.previousOffsetX;
  
  return proposedContentOffset;
}

@end
