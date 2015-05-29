//
//  InfoSubjectViewController.h
//  TianTianFood
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Subject.h"

@interface InfoSubjectViewController : UIViewController
@property(nonatomic, retain) Subject *subject;
@property(nonatomic, retain) UIImageView *imageView;
@property(nonatomic, retain) UIImageView *headImageView;
@property(nonatomic, retain) UILabel *nameLabel;
@property(nonatomic, retain) UILabel *timeLabel;

@end
