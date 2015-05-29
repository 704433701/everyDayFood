//
//  MySubjectTableViewCell.h
//  TianTianFood
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubjectHot.h"
#import "Subject.h"

@interface MySubjectTableViewCell : UITableViewCell
@property(nonatomic, retain) UIImageView *bigImageView;
@property(nonatomic, retain) UILabel *wordLabel;
@property(nonatomic, retain) SubjectHot *subjectHot;
@property(nonatomic, retain) Subject *subject;

@end
