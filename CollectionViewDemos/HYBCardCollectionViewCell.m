//
//  HYBCardCollectionViewCell.m
//  CollectionViewDemos
//
//  Created by huangyibiao on 16/3/26.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBCardCollectionViewCell.h"

@interface HYBCardCollectionViewCell ()

@property (nonatomic, strong) UIView *imageView;

@end

@implementation HYBCardCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.imageView = [[UIView alloc] initWithFrame:self.bounds];
    self.imageView.layer.cornerRadius = 12;
    self.imageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.imageView];
  }
  
  return self;
}

- (void)configWithImage:(id)image {
  self.imageView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:image].CGImage);
}

@end