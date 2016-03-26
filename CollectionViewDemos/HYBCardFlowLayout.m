//
//  HYBCardFlowLayout.m
//  CollectionViewDemos
//
//  Created by huangyibiao on 16/3/26.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBCardFlowLayout.h"

@interface HYBCardFlowLayout ()

@property (nonatomic, strong) NSIndexPath *mainIndexPath;
@property (nonatomic, strong) NSIndexPath *willMoveToMainIndexPath;

@end

@implementation HYBCardFlowLayout

- (void)prepareLayout {
  CGFloat inset = 32;
  self.itemSize = CGSizeMake(self.collectionView.frame.size.width - 2 * inset,
                             self.collectionView.frame.size.height * 3 / 4);
  self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
  self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  
  [super prepareLayout];
}

#pragma mark - Override
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
  return YES;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewLayoutAttributes *attribute = [super layoutAttributesForItemAtIndexPath:indexPath];
  
  [self setTransformForLayoutAttributes:attribute];
  
  return attribute;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
  NSArray *attributesSuper = [super layoutAttributesForElementsInRect:rect];
  // 一定要深复制一份，不能修改父类的属性，不然会有很多error打印出来
  NSArray *attributes = [[NSArray alloc] initWithArray:attributesSuper copyItems:YES];
  
  NSArray *visibleIndexPaths = [self.collectionView indexPathsForVisibleItems];
  
  if (visibleIndexPaths.count <= 0) {
    return attributes;
  } else if (visibleIndexPaths.count == 1) {
    self.mainIndexPath = [visibleIndexPaths firstObject];
    self.willMoveToMainIndexPath = nil;
  } else if (visibleIndexPaths.count == 2) {
    NSIndexPath *indexPath = [visibleIndexPaths firstObject];
    
    // 说明是往左滚动
    if (indexPath == self.mainIndexPath) {
      // 记录将要移进来的位置
      self.willMoveToMainIndexPath = visibleIndexPaths[1];
    } else {// 往右滚动
      self.willMoveToMainIndexPath = visibleIndexPaths[0];
      
      // 更新下一个成为main
      self.mainIndexPath = visibleIndexPaths[1];
    }
  }
  
  for (UICollectionViewLayoutAttributes *attribute in attributes) {
    [self setTransformForLayoutAttributes:attribute];
  }
  
  return attributes;
}

- (void)setTransformForLayoutAttributes:(UICollectionViewLayoutAttributes *)attribute {
  UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:attribute.indexPath];
  
  if (self.mainIndexPath && attribute.indexPath.section == self.mainIndexPath.section) {
    attribute.transform3D = [self tranformForView:cell];
  } else if (self.willMoveToMainIndexPath && attribute.indexPath.section == self.willMoveToMainIndexPath.section) {
    attribute.transform3D = [self tranformForView:cell];
  }
}

- (CATransform3D)tranformForView:(UICollectionViewCell *)view {
  // cell的起始偏移
  CGFloat w = self.collectionView.frame.size.width;
  CGFloat offset = [self.collectionView indexPathForCell:view].section * w;
  
  // 当前偏移
  CGFloat currentOffset = self.collectionView.contentOffset.x;
  
  // 计算偏移angle
  CGFloat angle = (currentOffset - offset) / w;
  
  CATransform3D t = CATransform3DIdentity;
  t.m34 = 1.0 / -500;
  
  if (currentOffset - offset >= 0) {
    t = CATransform3DRotate(t, angle, 1, 1, 0);
  } else {
    t = CATransform3DRotate(t, angle, -1, 1, 0);
  }
  
  return t;
}

@end
