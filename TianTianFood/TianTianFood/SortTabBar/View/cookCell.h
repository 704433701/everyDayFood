//
//  cookCell.h
//  TianTianFood
//
//  Created by dlios on 15/3/24.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sort.h"

@interface cookCell : UITableViewCell


@property (nonatomic, retain) UIImageView *imageView1;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *typeLabel;
@property (nonatomic, retain) UILabel *tasteLabel;
@property (nonatomic, retain) Sort *foodList;

@end
