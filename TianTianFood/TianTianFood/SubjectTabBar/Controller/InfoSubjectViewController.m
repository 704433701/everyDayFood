//
//  InfoSubjectViewController.m
//  TianTianFood
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "InfoSubjectViewController.h"
#import "MenuSubjectViewController.h"
@interface InfoSubjectViewController ()

@end

@implementation InfoSubjectViewController

- (void)dealloc
{
    [_timeLabel release];
    [_nameLabel release];
    [_subject release];
    [_imageView release];
    [_headImageView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 导航栏定制
    self.view.backgroundColor = [UIColor whiteColor];
    [UIView animateWithDuration:1 animations:^{
        for (NSInteger i = 1; i < 6; i++) {
            self.tabBarController.tabBar.frame = CGRectMake(0, self.view.frame.size.height - 9.8 * i , self.view.frame.size.width, 49);
        }
    }];
//    self.navigationController.navigationBarHidden = YES;
    UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 64)];
    [self.view addSubview:naviView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(naviView.frame.size.width / 2 - naviView.frame.size.width / 4, 0, naviView.frame.size.width / 2, naviView.frame.size.height)];
    [naviView addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = @"网友菜单列表";
    titleLabel.font = [UIFont systemFontOfSize:30];
    titleLabel.textColor = [UIColor yellowColor];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button1 setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    button1.frame = CGRectMake(10, 10, naviView.frame.size.height - 20 + 10, naviView.frame.size.height - 20);
    [naviView addSubview:button1];
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [naviView release];
    [titleLabel release];
    
    // 阴影图片
    UIView *yinYingView = [[UIView alloc] initWithFrame:CGRectMake(15, naviView.frame.origin.y + naviView.frame.size.height - 5, self.view.frame.size.width - 40 + 10, self.view.frame.size.height / 2 + 10)];
    yinYingView.backgroundColor = [UIColor blackColor];
    yinYingView.alpha = 0.1;
    [self.view addSubview:yinYingView];
    [yinYingView release];
    
    
    // 大图
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, naviView.frame.origin.y + naviView.frame.size.height, self.view.frame.size.width - 40, self.view.frame.size.height / 2)];
    [self.view addSubview:self.imageView];
    [_imageView release];
    
    
    // 评论
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, self.imageView.frame.origin.y + self.imageView.frame.size.height + 15, 50, 50)];
    [self.view addSubview:self.headImageView];
    self.headImageView.layer.cornerRadius = 20;
    self.headImageView.clipsToBounds = YES;
    self.headImageView.backgroundColor = [UIColor grayColor];
    [_headImageView release];
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, self.headImageView.frame.origin.y, self.view.frame.size.width - self.headImageView.frame.size.width - 200, self.headImageView.frame.size.height)];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.nameLabel];
//    self.nameLabel.backgroundColor = [UIColor orangeColor];
    [_nameLabel release];
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, self.imageView.frame.origin.y + self.imageView.frame.size.height + 15, self.view.frame.size.width - self.headImageView.frame.size.width - 40, self.headImageView.frame.size.height)];
    [self.view addSubview:self.timeLabel];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.textColor = [UIColor redColor];
    self.timeLabel.alpha = 0.5;
    self.timeLabel.textAlignment = NSTextAlignmentRight;
//    self.timeLabel.backgroundColor = [UIColor redColor];
    [_timeLabel release];
    
    // 详情按钮
    NSString *infoStr = [NSString stringWithFormat:@"%@原菜谱详情", self.subject.RecipeName];
    if (infoStr.length >= 10) {
        infoStr = [NSString stringWithFormat:@"%@详情", self.subject.RecipeName];
    }
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    button2.layer.cornerRadius = 10;
    button2.frame = CGRectMake(20, self.headImageView.frame.origin.y + self.headImageView.frame.size.height + (self.view.frame.size.height - 49 - self.headImageView.frame.origin.y - self.headImageView.frame.size.height) / 4, self.view.frame.size.width - 40, (self.view.frame.size.height - 49 - self.headImageView.frame.origin.y - self.headImageView.frame.size.height) / 2);
    // 4S
    if (self.view.frame.size.height <= 480) {
        
        if (self.tabBarController.tabBar.frame.origin.y <= self.view.frame.size.height)  {
            [UIView animateWithDuration:1 animations:^{
                for (NSInteger i = 1; i < 6; i++) {
                    self.tabBarController.tabBar.frame = CGRectMake(0, self.view.frame.size.height - 49 + 9.8 * i , self.view.frame.size.width, 49);
                }
            }];
        }
        button2.frame = CGRectMake(20, self.headImageView.frame.origin.y + self.headImageView.frame.size.height + (self.view.frame.size.height - 49 - self.headImageView.frame.origin.y - self.headImageView.frame.size.height) / 4, self.view.frame.size.width - 40, self.view.frame.size.height - 49 - self.headImageView.frame.origin.y - self.headImageView.frame.size.height);
    }
        
    [button2 setTitle:infoStr forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.2];
    [self.view addSubview:button2];
    button2.titleLabel.font = [UIFont systemFontOfSize:button2.frame.size.height / 3];
    [button2 addTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchUpInside];
    // 返回手势
    UIScreenEdgePanGestureRecognizer *screenGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(buttonAction:)];
    screenGesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:screenGesture];
    self.title = self.subject.RecipeName;
    [self.imageView sd_setImageWithURL:self.subject.ImageUrl placeholderImage:[UIImage imageNamed:@"location.png"]];
    [self.headImageView sd_setImageWithURL:self.subject.UserImageUrl placeholderImage:[UIImage imageNamed:@"headicon.png"]];
    self.nameLabel.text = self.subject.NickName;
    NSString *timeStr = [self smallStr:self.subject.DateCreated];
    
    
    self.timeLabel.text = timeStr;
 
}

- (void) buttonAction:(UIButton *)button
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) buttonAction2:(UIButton *)button
{
    MenuSubjectViewController *menuVC = [[MenuSubjectViewController alloc] init];
    menuVC.subject = self.subject;
    [self.navigationController pushViewController:menuVC animated:YES];
    [menuVC release];
}


- (NSString *) smallStr:(NSString *)str
{
    NSString *str2 = @"发布";
    if (str.length >= 22) {
        NSString *str3 = [str substringWithRange:NSMakeRange(5, 5)];
        NSString *str4 = [str substringWithRange:NSMakeRange(11, 5)];
        NSString *str5 = [NSMutableString stringWithFormat:(@"%@ %@%@"), str3, str4, str2];
        return str5;
    } return str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
