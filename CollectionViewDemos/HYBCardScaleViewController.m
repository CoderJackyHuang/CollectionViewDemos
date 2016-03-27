//
//  HYBCardScaleViewController.m
//  CollectionViewDemos
//
//  Created by huangyibiao on 16/3/27.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBCardScaleViewController.h"
#import "HYBCardScaleFlowLayout.h"
#import "HYBCardCollectionViewCell.h"


static NSString *cellIdentifier = @"CellIdentifier";

@interface HYBCardScaleViewController () <UICollectionViewDataSource>

@end

@implementation HYBCardScaleViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  HYBCardScaleFlowLayout *layout = [[HYBCardScaleFlowLayout alloc] init];
  
  UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
  [self.view addSubview:collectionView];
  [collectionView registerClass:[HYBCardCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
  collectionView.dataSource = self;
  self.view.backgroundColor = [UIColor whiteColor];
  collectionView.backgroundColor = [UIColor purpleColor];
//  collectionView.pagingEnabled = YES;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return 5;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return  1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  HYBCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier
                                                                              forIndexPath:indexPath];
  [cell configWithImage:[NSString stringWithFormat:@"img%ld.jpg", indexPath.item + 1]];
  
  return cell;
}

@end
