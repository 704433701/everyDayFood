//
//  ListXiaoViewController.m
//  TianTianFood
//
//  Created by dlios on 15/3/27.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "ListXiaoViewController.h"
#import "TipViewController.h"


@interface ListXiaoViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, assign) NSInteger page;


@end

@implementation ListXiaoViewController


- (void)requestData:(NSString *)keyword page:(NSInteger)page
{
    
    NSString *str = [NSString stringWithFormat:@"http://ibaby.ipadown.com/api/food/food.tips.list.php?p=%ld&pagesize=20&tags=%@", page, keyword];
    [NetHandler getDataWithUrl:str completion:^(NSData *data) {
        id dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [self.arr addObjectsFromArray:[dict objectForKey:@"results"]];
        
        // 在这里得到数据后更新数据
        [self.tableView reloadData];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        // 上拉加载结束
        [_tableView.footer endRefreshing];
        
        // 小于20 全部显示全部
        if ([[dict objectForKey:@"resultCount"] integerValue] < 20) {
            [self.tableView.footer noticeNoMoreData];
        }

    }];    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.page = 1;
    self.arr = [NSMutableArray array];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [_tableView release];
    
    // 上拉刷新加载
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [self requestData:self.name page:self.page++];
    }];
    [self.tableView.footer beginRefreshing];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"ding";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (self) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str]autorelease];
    }
    cell.textLabel.text = [[self.arr objectAtIndex:indexPath.row] objectForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TipViewController *tipVC = [[TipViewController alloc] init];
    [self.navigationController pushViewController:tipVC animated:YES];
    tipVC.title = [[self.arr objectAtIndex:indexPath.row] objectForKey:@"title"];
    tipVC.ID = [[self.arr objectAtIndex:indexPath.row] objectForKey:@"ID"];
    [tipVC release];
}



- (void)dealloc
{
    [_tableView release];
    [_arr release];
    [super dealloc];
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
