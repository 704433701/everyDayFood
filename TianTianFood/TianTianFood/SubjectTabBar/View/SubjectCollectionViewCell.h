//
//  SubjectCollectionViewCell.h
//  TianTianFood
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Subject.h"

@interface SubjectCollectionViewCell : UICollectionViewCell
@property(nonatomic, retain) UIView *picView;
@property(nonatomic, retain) UIImageView *imageView;
@property(nonatomic, retain) UIImageView *headView;
@property(nonatomic, retain) UILabel *label;
@property(nonatomic, retain) Subject *subject;

@end
