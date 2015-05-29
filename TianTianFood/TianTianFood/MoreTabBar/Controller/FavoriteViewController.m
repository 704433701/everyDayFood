//
//  FavoriteViewController.m
//  TianTianFood
//
//  Created by 张健华 on 15-3-25.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "FavoriteViewController.h"
#import "HomeTableViewCell.h"
#import "DetailsViewController.h"
#import "CustomFavoriteTableViewCell.h"

@interface FavoriteViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UIAlertViewDelegate>

@property (nonatomic, retain) UITableView *allFavoriteView;
@property (nonatomic, retain) NSMutableArray *allArr;
@property(nonatomic, retain) UIScrollView *scrollView;
@property(nonatomic, assign) NSInteger cellTag;
@end

@implementation FavoriteViewController

- (void)dealloc
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
    
    [_scrollView release];
    [_allFavoriteView release];
    [_allArr release];
    [super dealloc];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height )];
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
    [_scrollView release];
    self.allFavoriteView.showsVerticalScrollIndicator = NO;
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteAll)] autorelease];
    self.title = @"我的收藏";
   
    [self allFavoriteViewDidLoad];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(viewWillAppear:) name:@"刷新页面" object:nil];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 每一行是否可以被编辑
    return YES;
}



- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}



- (void)deleteAll
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认清空所有收藏?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert show];
    [alert release];
}



// tableView的另一个协议方法, 点击Delete走的方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 当点击删除按钮时
        // 对视图做操作之前, 要先对数据源做处理
        DataBaseHandler *db = [DataBaseHandler shareInstance];
        [db delete:@"menu" Menu:[self.allArr objectAtIndex:indexPath.row]];
        [self.allArr removeObjectAtIndex:indexPath.row];
        // 删除一个cell
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
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
        
        [db delete:@"menu" Menu:nil];
        [self viewWillAppear:YES];
    }
}


- (void)allFavoriteViewDidLoad
{
    self.allFavoriteView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    _allFavoriteView.dataSource = self;
    _allFavoriteView.delegate = self;
    _allFavoriteView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:_allFavoriteView];
    [_allFavoriteView release];
    [_allFavoriteView registerClass:[CustomFavoriteTableViewCell class] forCellReuseIdentifier:@"cellFavorite"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        CustomFavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellFavorite"];
        cell.caipu = [self.allArr objectAtIndex:indexPath.row];
    cell.target = self;
        return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.allFavoriteView) {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailsViewController *detailsVC = [[DetailsViewController alloc] init];
    detailsVC.menu = [self.allArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailsVC animated:YES];
    [detailsVC release];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    DataBaseHandler *db = [DataBaseHandler shareInstance];
    self.allArr = [db selectAllMenu:@"menu"];
    [self.allFavoriteView reloadData];
    UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shoucang.png"]];
    if (self.allArr.count == 0) {
        imageview.frame = CGRectMake(0, self.view.frame.size.height / 5, self.view.frame.size.width, self.view.frame.size.height * 2 / 5);
        [self.allFavoriteView addSubview:imageview];
    } else {
        [imageview removeFromSuperview];
    }
    [imageview release];
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
