//
//  ListViewController.m
//  TianTianFood
//
//  Created by dlios on 15/3/24.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "ListViewController.h"
#import "cookCell.h"
#import "Sort.h"
#import "DetailsViewController.h"

@interface ListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, assign) NSInteger page;


@end

@implementation ListViewController


// 在创建ListViewController进行网络请求
- (void)requestData:(NSString *)keyword page:(NSInteger)page
{
    self.title = keyword;
    
    NSString *str = [NSString stringWithFormat:@"http://ibaby.ipadown.com/api/food/food.show.list.php?keywords=%@&p=%ld&pagesize=20",keyword, page];
    [NetHandler getDataWithUrl:str completion:^(NSData *data) {
        id dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in [dict objectForKey:@"results"]) {
            Sort *foodList = [[Sort alloc] initWithDictionary:dic];
            [self.arr addObject:foodList];
            [foodList release];
        }
        // 上拉加载结束
        [_tableView.footer endRefreshing];
        if ([[dict objectForKey:@"results"] count] == 0) {
            // 当数据为空得时候让tableView不显示线条 疾病条例
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            _tableView.footer.state = MJRefreshFooterStateNoMoreData;
            
            UIView *iView = [[UIView alloc] initWithFrame:self.view.bounds];
            [self.view addSubview:iView];
            [iView release];
            UILabel *iLabel = [[UILabel alloc] init];
            iLabel.frame = CGRectMake(0, 0, 150, 80);
            iLabel.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2 - 50);
            iLabel.text = @"亲 没有这个分类😍";
            iLabel.numberOfLines = 2;
            [iView addSubview:iLabel];
            [iLabel release];
        }
        // 在这里得到数据后更新数据
        [self.tableView reloadData];
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 在这里初始化
    self.arr = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.rowHeight = 100;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [_tableView release];
    self.page = 1;
    
    // 上拉刷新加载 (MJ第三方里面写网络请求)
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [self requestData:self.keyWord page:self.page++];
    }];
    
    // 进入界面自动开始刷新 (MJ第三方)
    [self.tableView.footer beginRefreshing];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"ding";
    cookCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[[cookCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str] autorelease];
    }
    cell.foodList = [self.arr objectAtIndex:indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsViewController *detailsView = [[DetailsViewController alloc] init];
    // 公用一个数据 (写了一个初始化方法)
    detailsView.menu = [[[Home alloc] initWithFind:[self.arr objectAtIndex:indexPath.row]] autorelease];
    [self.navigationController pushViewController:detailsView animated:YES];
    [detailsView release];
}




- (void)dealloc
{
    [_keyWord release];
    [_arr release];
    [_tableView release];
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
