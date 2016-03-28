//
//  HYBBaseViewController.m
//  CollectionViewDemos
//
//  Created by huangyibiao on 16/3/2.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBBaseViewController.h"

@interface HYBBaseViewController () 

@end

@implementation HYBBaseViewController

- (instancetype)initWithTitle:(NSString *)title {
  if (self = [super init]) {
    self.title = title;
  }
  
  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
   self.edgesForExtendedLayout = UIRectEdgeNone; 
}

@end
