//
//  HYBCardViewController.m
//  CollectionViewDemos
//
//  Created by huangyibiao on 16/3/26.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBCardViewController.h"
#import "HYBCardCollectionViewCell.h"
#import "HYBCardFlowLayout.h"

static NSString *cellIdentifier = @"CellIdentifier";

@interface HYBCardViewController () <UICollectionViewDataSource>

@end

@implementation HYBCardViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  HYBCardFlowLayout *layout = [[HYBCardFlowLayout alloc] init];
  UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
  [self.view addSubview:collectionView];
  [collectionView registerClass:[HYBCardCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
  collectionView.dataSource = self;
  self.view.backgroundColor = [UIColor whiteColor];
  collectionView.backgroundColor = [UIColor purpleColor];
  collectionView.pagingEnabled = YES;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return  5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  HYBCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier
                                                                              forIndexPath:indexPath];
  [cell configWithImage:[NSString stringWithFormat:@"img%ld.jpg", indexPath.section + 1]];
  
  return cell;
}

@end
