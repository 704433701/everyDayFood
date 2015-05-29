//
//  HotSubjectTableViewCell.h
//  TianTianFood
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TongueSubject.h"
@interface HotSubjectTableViewCell : UITableViewCell
@property(nonatomic, retain) UIImageView *bigImageView;
@property(nonatomic, retain) UILabel *label1;
@property(nonatomic, retain) UILabel *label2;
@property(nonatomic, retain) UILabel *label3;
@property(nonatomic, retain) UILabel *label4;
@property(nonatomic, retain) TongueSubject *tongue;

@end
