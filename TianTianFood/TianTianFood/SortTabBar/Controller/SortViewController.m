//
//  SortViewController.m
//  TianTianFood
//
//  Created by 张健华 on 15-3-21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "SortViewController.h"
#import "MenuView.h"
#import "FoodView.h"
#import "ListViewController.h"

@interface SortViewController () <UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UISegmentedControl *seg;
@property (nonatomic, retain) MenuView *menuView;
@property (nonatomic, retain) FoodView *foodView;
@property (nonatomic, assign) CGPoint startCenter;


@end

@implementation SortViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 关闭导航栏高度
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.seg = [[UISegmentedControl alloc] initWithItems:@[@"菜谱分类", @"食材分类"]];
    self.navigationItem.titleView = _seg;
    // 默认显示第一个
    _seg.selectedSegmentIndex = 0;
    
    [self.seg addTarget:self action:@selector(changeFood:) forControlEvents: UIControlEventValueChanged];
    [_seg release];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2, 100);
    self.scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    [self.view addSubview:_scrollView];
    [_scrollView release];
    
    // 菜谱分类界面
    self.menuView = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 113)];
    self.menuView.backgroundColor = [UIColor clearColor];
    
    // 解耦 (用于搜索推出下一页使用)
    self.menuView.target = self.navigationController;
    // 在SortViewcontroller中签订点击cell的协议
    self.menuView.menuCollectionView.delegate = self;
    
    [self.scrollView addSubview:self.menuView];
    [_menuView release];
    
    // 食材分类界面
    self.foodView = [[FoodView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height - 113)];
    
    self.foodView.vegetableCollectionView.delegate = self;
    self.foodView.meatCollectionView.delegate = self;
    
    [self.scrollView addSubview:self.foodView];
    [_foodView release];
    

    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    self.seg.selectedSegmentIndex = scrollView.contentOffset.x / self.view.frame.size.width;
    if (self.scrollView.contentOffset.x >= self.view.frame.size.width - 100) {
        self.seg.selectedSegmentIndex = 1;
    }
    if (self.scrollView.contentOffset.x == 0) {
        self.seg.selectedSegmentIndex = 0;
    }
    [self cancelKeyboard];
}

- (void)cancelKeyboard
{
    self.menuView.searchBar.showsCancelButton = NO;
    self.menuView.searchBar.text = @"";
    // 结束编辑 (回收键盘)
    [self.view endEditing:YES];
}

// 变为用食材搜寻的方法
- (void)changeFood:(UISegmentedControl *)seg
{
    [UIView animateWithDuration:0.5 animations:^{
        if (seg.selectedSegmentIndex == 1) {
            self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
        }
        else {
            self.scrollView.contentOffset = CGPointMake(0, 0);
        }
    }];

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 跳转列表3个判断
    if (collectionView == self.foodView.vegetableCollectionView) {

        ListViewController *listView = [[ListViewController alloc] init];
        listView.keyWord = [self.foodView.vegetableArr objectAtIndex:indexPath.row];
        listView.title = [self.foodView.vegetableArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:listView animated:YES];
        [listView release];
        
    } else if (collectionView == self.foodView.meatCollectionView) {
        
    ListViewController *listView = [[ListViewController alloc] init];
        if ([[self.foodView.meatArr objectAtIndex:indexPath.row] isEqual:@"其它"]) {
            listView.keyWord = @"其它海鲜";
        } else {
            listView.keyWord = [self.foodView.meatArr objectAtIndex:indexPath.row];
        }
        listView.title = [self.foodView.meatArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:listView animated:YES];
        [listView release];
        
    } else {
        [self cancelKeyboard];
        ListViewController *listVC = [[ListViewController alloc] init];
        listVC.keyWord = [self.menuView.array objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:listVC animated:YES];
        [listVC release];
    }
}

- (void)dealloc
{
    [_scrollView release];
    [_seg release];
    [_menuView release];
    [_foodView release];
    [super dealloc];
}



- (void)didReceiveMemoryWarnin
 {
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
