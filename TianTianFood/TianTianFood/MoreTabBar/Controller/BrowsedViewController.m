//
//  BrowsedViewController.m
//  TianTianFood
//
//  Created by 张健华 on 15-3-26.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "BrowsedViewController.h"
#import "DetailsViewController.h"

@interface BrowsedViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *browsedView;
@property (nonatomic, retain) NSMutableArray *allArr;
@end

@implementation BrowsedViewController

- (void)dealloc
{
    [_browsedView release];
    [_allArr release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"浏览记录";
    self.view.backgroundColor = [UIColor whiteColor];
    
    DataBaseHandler *db = [DataBaseHandler shareInstance];
    self.allArr = [db selectAllMenu:@"browsed"];
    Home *menu = [[Home alloc] init];
    if (self.allArr.count == 0) {
        menu.title = @"***您还没有浏览任何菜谱哦***";
    } else {
        menu.title = @"***只保留最近10条记录***";
    }
    [_allArr addObject:menu];
    [menu release];
    
    [self allBrowsedViewDidLoad];
    
}

- (void)allBrowsedViewDidLoad
{
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteAll)] autorelease];
    
    
    self.browsedView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _browsedView.dataSource = self;
    _browsedView.delegate = self;
    [self.view addSubview:_browsedView];
    [_browsedView release];
    [_browsedView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellFavorite"];
}

//
- (void)deleteAll
{
    DataBaseHandler *db = [DataBaseHandler shareInstance];
    MBProgressHUD *mb = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:mb];
    mb.mode = MBProgressHUDModeCustomView;
    mb.labelText = @"清空成功";
    mb.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hubyes.png"]] autorelease];
    [mb showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [mb removeFromSuperview];
    }];
    
    [db delete:@"browsed" Menu:nil];
    self.allArr = nil;
    [self.browsedView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellFavorite"];
    cell.textLabel.text = [[self.allArr objectAtIndex:indexPath.row] title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row + 1 < self.allArr.count) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        DetailsViewController *detailsVC = [[DetailsViewController alloc] init];
        detailsVC.menu = [self.allArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detailsVC animated:YES];
        [detailsVC release];
    }
}


@end
