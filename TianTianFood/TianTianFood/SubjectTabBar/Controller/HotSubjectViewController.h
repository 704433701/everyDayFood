//
//  HotSubjectViewController.h
//  TianTianFood
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TongueSubject.h"
#import "Subject.h"
@interface HotSubjectViewController : UIViewController
@property(nonatomic, retain) UIImageView *imageView;
@property(nonatomic, retain) NSMutableArray *arr;
@property(nonatomic, retain) UITableView *tableView;
@property(nonatomic, retain) UILabel *wordLabel;
@property(nonatomic, retain) UILabel *introduceLabel;
@property(nonatomic, retain) UIScrollView *scrollView;
@property(nonatomic, retain) UILabel *titleLabel;
@property(nonatomic, retain) TongueSubject *tongue;
@property(nonatomic, retain) Subject *subject;
@property(nonatomic, assign) CGFloat offY;

@end
