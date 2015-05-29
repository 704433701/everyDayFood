//
//  HomeTableViewCell.h
//  TianTianFood
//
//  Created by 张健华 on 15-3-23.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Home.h"

@interface HomeTableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *image;
@property (nonatomic, retain) UIImageView *bgView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *yongliaoLabel;
@property (nonatomic, retain) Home *caipu;
@end
