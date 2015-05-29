//
//  CustomSubjectTableViewCell.h
//  TianTianFood
//
//  Created by dlios on 15-3-31.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Home.h"

@interface CustomSubjectTableViewCell : UITableViewCell
@property(nonatomic, retain) UIImageView *bigImageView;
@property(nonatomic, retain) UILabel *label1;
@property(nonatomic, retain) UILabel *label2;
@property(nonatomic, retain) UIButton *timeButton;
@property(nonatomic, retain) Home *home;

@end
