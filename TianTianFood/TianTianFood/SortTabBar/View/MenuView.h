//
//  MenuView.h
//  TianTianFood
//
//  Created by dlios on 15/3/23.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuView : UIView <UICollectionViewDataSource, UISearchBarDelegate>

@property (nonatomic, retain) UICollectionView *menuCollectionView;
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) NSArray *array;

@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;

@end
