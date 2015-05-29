//
//  HomeViewController.m
//  TianTianFood
//
//  Created by 张健华 on 15-3-21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "BaseView.h"
#define BaseViewNumber 4

@interface HomeViewController () <UIScrollViewDelegate>

@property (nonatomic, retain) UIView *titleView; // 标题指示
@property (nonatomic, retain) UICollectionView *collectionView; // 菜单列表
//@property(nonatomic, assign) CGFloat offY;

@end

@implementation HomeViewController

- (void)dealloc
{
    [_titleView release];
    [_collectionView release];
    [_caiPu release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _offY = 0;
    DataBaseHandler *db = [DataBaseHandler shareInstance];
    
    // 打开数据库
    [db opernDB];
    // 创建Menu表
    [db createTable:@"menu"];
    [db createTable:@"browsed"];

    [self subview];

}

- (void)subview
{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 5, width, height - 49)];
    scrollView.contentSize = CGSizeMake(width * BaseViewNumber, 5);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    [scrollView release];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    NSLog(@"%@", date);
    NSInteger time = [date integerValue];
    if (time >= 20 || time < 9) {
        scrollView.contentOffset = CGPointMake(0, 5);
    } else if (time >= 9 && time < 12) {
        scrollView.contentOffset = CGPointMake(width, 5);
    } else if (time >= 12 && time < 14) {
        scrollView.contentOffset = CGPointMake(width * 2, 5);
    } else if (time >= 14 && time < 20) {
        scrollView.contentOffset = CGPointMake(width * 3, 5);
    }
    
    for (NSInteger i = 0; i < BaseViewNumber; i++) {
        BaseView *view = [[BaseView alloc] initWithFrame:CGRectMake(width * i, 5, width, height - 113) keyword:i];
        view.target = self.navigationController;
        [scrollView addSubview:view];
        [view release];
    }
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, width / BaseViewNumber, 5)];
    _titleView.backgroundColor = BarColor;
    [self.view addSubview:_titleView];
    [_titleView release];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.titleView.frame = CGRectMake(scrollView.contentOffset.x / self.view.frame.size.width  * self.view.frame.size.width / BaseViewNumber, 64, self.view.frame.size.width / BaseViewNumber, 5);
    if (scrollView.contentOffset.x == self.view.frame.size.width) {
        self.titleView.backgroundColor = [UIColor redColor];
    } else if (scrollView.contentOffset.x == self.view.frame.size.width * 2) {
        self.titleView.backgroundColor = BarColor;
    } else if (scrollView.contentOffset.x == self.view.frame.size.width * 3) {
        self.titleView.backgroundColor = [UIColor colorWithRed:45.0 / 256.0 green:109.0 / 256.0 blue:175.0 / 256.0 alpha:1];
    } else if (scrollView.contentOffset.x == 0) {
        self.titleView.backgroundColor = [UIColor orangeColor];
    }
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
