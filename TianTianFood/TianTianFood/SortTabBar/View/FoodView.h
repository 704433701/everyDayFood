//
//  FoodView.h
//  TianTianFood
//
//  Created by dlios on 15/3/23.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodView : UIView <UICollectionViewDataSource>

@property (nonatomic, retain) UICollectionView *vegetableCollectionView;
@property (nonatomic, retain) UICollectionView *meatCollectionView;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) NSArray *vegetableArr;
@property (nonatomic, retain) NSArray *meatArr;

@end
