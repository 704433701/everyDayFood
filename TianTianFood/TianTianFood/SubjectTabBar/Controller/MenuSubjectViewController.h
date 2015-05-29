//
//  MenuSubjectViewController.h
//  TianTianFood
//
//  Created by dlios on 15-3-25.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PreviousSubject.h"
#import "Subject.h"
@interface MenuSubjectViewController : UIViewController
@property(nonatomic, retain) UIScrollView *scrollView;
@property(nonatomic, retain) UILabel *titleLabel;
@property(nonatomic, retain) UIImageView *bigImageView;
@property(nonatomic, retain) UILabel *feedLabel;
@property(nonatomic, retain) UILabel *flavLabel;
@property(nonatomic, retain) UILabel *workLabel;
@property(nonatomic, retain) UILabel *superWordLabel;
//@property(nonatomic, retain) UIView *exampleView;
@property(nonatomic, retain) NSMutableArray *arr;
@property(nonatomic, retain) PreviousSubject *previous;
@property(nonatomic, retain) UIImageView *imageView1;
@property(nonatomic, retain) UIImageView *imageView2;
@property(nonatomic, retain) UIImageView *imageView3;
@property(nonatomic, retain) UIImageView *imageView4;
@property(nonatomic, retain) NSMutableArray *imageArr;
@property(nonatomic, retain) Subject *subject;
@property(nonatomic, assign) CGFloat offY;

@end
