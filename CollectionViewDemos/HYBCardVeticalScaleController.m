//
//  HYBCardVeticalScaleController.m
//  CollectionViewDemos
//
//  Created by huangyibiao on 16/3/27.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBCardVeticalScaleController.h"
#import "HYBCardCollectionViewCell.h"
#import "HYBCardVerticalScaleLayout.h"

static NSString *cellIdentifier = @"CellIdentifier";

@interface HYBCardVeticalScaleController () <UICollectionViewDataSource>

@end

@implementation HYBCardVeticalScaleController

- (void)viewDidLoad {
  [super viewDidLoad];
  

  HYBCardVerticalScaleLayout *layout = [[HYBCardVerticalScaleLayout alloc] init];
  
  UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
  [self.view addSubview:collectionView];
  [collectionView registerClass:[HYBCardCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
  collectionView.dataSource = self;
  self.view.backgroundColor = [UIColor whiteColor];
  collectionView.backgroundColor = [UIColor purpleColor];
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