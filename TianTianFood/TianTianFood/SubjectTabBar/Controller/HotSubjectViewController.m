//
//  HotSubjectViewController.m
//  TianTianFood
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "HotSubjectViewController.h"
#import "HotSubjectTableViewCell.h"
#import "DetailsViewController.h"

@interface HotSubjectViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>


@end

@implementation HotSubjectViewController
- (void)dealloc
{
    [_subject release];
    [_tongue release];
    [_titleLabel release];
    [_scrollView release];
    [_introduceLabel release];
    [_wordLabel release];
    [_arr release];
    [_tableView release];
    [_imageView release];
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    /////////////////////////////// 导航栏定制 ////////////////////////////////////////////////////////
    self.offY = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:naviView];
//    naviView.backgroundColor = [UIColor redColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(naviView.frame.size.width / 2 - naviView.frame.size.width / 4, 0, naviView.frame.size.width / 2, naviView.frame.size.height)];
    [naviView addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:30];
    titleLabel.textColor = [UIColor yellowColor];
    [titleLabel release];
    [naviView release];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.contentSize = CGSizeMake(0, 1000);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    [_scrollView release];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, naviView.frame.size.height, self.view.frame.size.width, self.view.frame.size.width / 1.8)];
    [self.scrollView addSubview:self.imageView];
    [_imageView release];
    
    self.wordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imageView.frame.size.height * 3 / 4, self.imageView.frame.size.width, self.imageView.frame.size.height / 4)];
    self.wordLabel.text = @"玩命加载中😞...";
    self.wordLabel.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.3];
    self.wordLabel.textColor = [UIColor whiteColor];
    [self.imageView addSubview:self.wordLabel];
    [_wordLabel release];
    
    self.introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.imageView.frame.origin.y + self.imageView.frame.size.height + 5, self.view.frame.size.width - 10, self.view.frame.size.height / 3)];
    [self.scrollView addSubview:self.introduceLabel];
    [_introduceLabel release];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.introduceLabel.frame.size.height + self.introduceLabel.frame.origin.y + 5, self.view.frame.size.width, 0)];
    self.titleLabel.tag = 1000;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.scrollView addSubview:self.titleLabel];
    [_titleLabel release];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.titleLabel.frame.size.height + self.titleLabel.frame.origin.y - 10, self.view.frame.size.width - 10, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.bounces = NO;
    [self.scrollView addSubview:self.tableView];
    [_tableView release];
    [self loadData:[NSString stringWithFormat:@"http://ibaby.ipadown.com/api/food/food.topic.detail.php?id=%@", self.subject.ID]];

    self.tabBarController.tabBar.frame = CGRectMake(0, self.view.frame.size.height - 49, self.view.frame.size.width, 49);
    
}

// scrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 上划时标签栏下潜
    if (self.scrollView.contentOffset.y > 0 && self.tabBarController.tabBar.frame.origin.y <= self.view.frame.size.height)  {
        [UIView animateWithDuration:1 animations:^{
            for (NSInteger i = 1; i < 6; i++) {
                self.tabBarController.tabBar.frame = CGRectMake(0, self.view.frame.size.height - 49 + 9.8 * i , self.view.frame.size.width, 49);
            }
        }];
    }
    if (self.scrollView.contentOffset.y < 0) {
        self.imageView.frame = CGRectMake(0 + self.scrollView.contentOffset.y / 2, 64 + self.scrollView.contentOffset.y, self.view.frame.size.width - self.scrollView.contentOffset.y, self.view.frame.size.width / 1.8 - self.scrollView.contentOffset.y);
        self.wordLabel.frame = CGRectMake(-self.scrollView.contentOffset.y / 2, self.view.frame.size.width / 1.8 - self.scrollView.contentOffset.y - self.view.frame.size.width / 7.2, self.imageView.frame.size.width, self.view.frame.size.width / 7.2);
    }
    // 下滑时标签栏出现
    if (self.offY > self.scrollView.contentOffset.y ) {
        [UIView animateWithDuration:1 animations:^{
            for (NSInteger i = 1; i < 6; i++) {
                self.tabBarController.tabBar.frame = CGRectMake(0, self.view.frame.size.height - 9.8 * i , self.view.frame.size.width, 49);
            }
        }];
    }
    // 滑到底时标签栏消失
    if ((self.scrollView.contentOffset.y - (self.scrollView.contentSize.height - self.view.frame.size.height) < 10) && (self.scrollView.contentOffset.y - (self.scrollView.contentSize.height - self.view.frame.size.height) > -10) && self.tabBarController.tabBar.frame.origin.y <= self.view.frame.size.height) {
        [UIView animateWithDuration:1 animations:^{
            //            self.tabBarController.tabBar.hidden = YES;
            for (NSInteger i = 1; i < 6; i++) {
                self.tabBarController.tabBar.frame = CGRectMake(0, self.view.frame.size.height - 49 + 9.8 * i , self.view.frame.size.width, 49);
            }
        }];
        //        self.offY = self.scrollView.contentOffset.y;
    }
    self.offY = self.scrollView.contentOffset.y;
}





// tableView方法
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strHot = @"ieazhfobra";
    HotSubjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strHot];
    if (cell == nil) {
        cell = [[[HotSubjectTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strHot] autorelease];
    }
    cell.tongue = self.arr[indexPath.row];
    return cell;

}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailsViewController *detaVC = [[DetailsViewController alloc] init];
    detaVC.menu = [[Home alloc] initWithFind:self.arr[indexPath.row]];
    [self.navigationController pushViewController:detaVC animated:YES];
    [detaVC release];
}

// 加载数据
- (void) loadData:(NSString *)str
{
    self.arr = [NSMutableArray array];
    [NetHandler getDataWithUrl:str completion:^(NSData *data) {
        
    
        id dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //////////////////////////////////// 危险 ///////////////////////////////////
        [self.imageView sd_setImageWithURL:[dict objectForKey:@"thumb"] placeholderImage:[UIImage imageNamed:@"location.png"]];
        self.introduceLabel.text = [[[dict objectForKey:@"tlist"] firstObject] objectForKey:@"jianjie"];
        self.introduceLabel.numberOfLines = 0;
        [self.introduceLabel sizeToFit];
        self.navigationItem.title = [dict objectForKey:@"title"];
        self.wordLabel.text = [dict objectForKey:@"title"];
//        self.titleLabel.text = [dict objectForKey:@"title"];
        self.titleLabel.frame = CGRectMake(0, self.introduceLabel.frame.origin.y + self.introduceLabel.frame.size.height, self.view.frame.size.width, 20);
        self.tableView.frame = CGRectMake(5, self.titleLabel.frame.size.height + self.titleLabel.frame.origin.y, self.view.frame.size.width - 10, 1000);
        if ([dict objectForKey:@"tlist"] != nil) {
            NSMutableArray *arr = [[[dict objectForKey:@"tlist"] firstObject] objectForKey:@"list"];
            for (NSDictionary *dic in arr) {
                TongueSubject *tongue = [[TongueSubject alloc] init];
                tongue.ID = [dic objectForKey:@"ID"];
                tongue.thumb_2 = [dic objectForKey:@"thumb_2"];
                tongue.category = [dic objectForKey:@"category"];
                tongue.age = [dic objectForKey:@"age"];
                tongue.effect = [dic objectForKey:@"effect"];
                tongue.title = [dic objectForKey:@"title"];
                [self.arr addObject:tongue];
                [tongue release];
            }
            
        }
        self.titleLabel.backgroundColor = [UIColor redColor];
        self.titleLabel.alpha = 0.2;
        self.tableView.frame = CGRectMake(5, self.titleLabel.frame.size.height + self.titleLabel.frame.origin.y, self.view.frame.size.width - 10, 100 * self.arr.count + 44 + 15);
        self.scrollView.contentSize = CGSizeMake(0, self.imageView.frame.size.height + self.introduceLabel.frame.size.height + self.titleLabel.frame.size.height + self.tableView.frame.size.height + 10);
        
        
        [self.tableView reloadData];
        }];
    
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
