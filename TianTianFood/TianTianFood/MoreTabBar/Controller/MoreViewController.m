//
//  MoreViewController.m
//  TianTianFood
//
//  Created by 张健华 on 15-3-21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "MoreViewController.h"
#import "FavoriteViewController.h"
#import "GUAAlertView.h"
#import "NutritionViewController.h"
#import "BrowsedViewController.h"
#import "SDImageCache.h"
#import "WelcomePage.h"


@interface MoreViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
@property (nonatomic, retain) UITableView *tableView;

@end

@implementation MoreViewController

- (void)dealloc
{
    [_tableView release];
    [super dealloc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *arr = @[@"小知识", @"更多功能", @"关于我们"];
    return [arr objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *moreArr = @[@"我的收藏", @"浏览记录", @"清除缓存"];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.section == 0) {
        cell.textLabel.text = @"营养小知识";
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = [moreArr objectAtIndex:indexPath.row];
    }
    if (indexPath.section == 2) {
        cell.textLabel.text = @"关于我们";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        NutritionViewController *nutriVC = [[NutritionViewController alloc] init];
        [self.navigationController pushViewController:nutriVC animated:YES];
        [nutriVC release];
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            FavoriteViewController *favoVC = [[FavoriteViewController alloc] init];
            [self.navigationController pushViewController:favoVC animated:YES];
            [favoVC release];
        } else if (indexPath.row == 1) {
            BrowsedViewController *browVC = [[BrowsedViewController alloc] init];
            [self.navigationController pushViewController:browVC animated:YES];
            [browVC release];
        } else if (indexPath.row == 2) {
            // 单例(一个应用程序只有一个对象)
            SDImageCache *sdImageCache = [SDImageCache sharedImageCache];
            
            NSString *str = [NSString stringWithFormat:@"缓存大小%.2fM.是否清除缓存?", [sdImageCache checkTmpSize]];
            NSString *cancelStr = @"取消";
            if ([sdImageCache checkTmpSize] == 0) {
                str = @"您还没有缓存, 不需要清理哦!";
                cancelStr = nil;
            }
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:cancelStr otherButtonTitles:@"确定", nil];
            
            // 这里执行协议方法的对象是这个视图控制器对象(协议方法是给别人用的)
            alertView.delegate = self;
            [alertView show];
            [alertView release];
        }
    }

    if (indexPath.section == 2) {
            NSDictionary *alert = @{@"title": @"关于",
                                    @"message": @"应用名称:天天美食\n版本:1.0.0\n开发者: 张健华 丁吉风 李云鹏",
                                    @"buttonTitle": @"OK"};
            GUAAlertView *v = [GUAAlertView alertViewWithTitle:alert[@"title"]message:alert[@"message"] buttonTitle:alert[@"buttonTitle"]buttonTouchedAction:^{
            } dismissAction:^{
            }];
            [v show];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView release];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

// 因为写在这个视图里面只能 这个类的对象可以
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex == 1) {
        [[SDImageCache sharedImageCache] clearDisk];

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
