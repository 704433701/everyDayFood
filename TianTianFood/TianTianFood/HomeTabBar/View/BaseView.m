//
//  BaseView.m
//  TianTianFood
//
//  Created by 张健华 on 15-3-24.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "BaseView.h"
#import "HomeTableViewCell.h"
#import "DetailsViewController.h"

@implementation BaseView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)dealloc
{
    [_bouncingBalls release];
    [_imageView release];
    [_tableView release];
    [_arr release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame keyword:(NSInteger)keyword
{
    self = [super initWithFrame:frame];
    if (self) {
        self.keyword = keyword;
        self.page = 1;
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        NSArray *imageArr = @[@"zaocan.png", @"wucan.png", @"xiawuca.png", @"wancan.png"];
        NSArray *requestArr = @[@"早餐", @"午餐", @"下午茶", @"晚餐"];
        
        self.arr = [NSMutableArray array];
        
        self.imageView = [[UIImageView alloc] init];
        self.imageView.image = [UIImage imageNamed:imageArr[keyword]];
        self.imageView.clipsToBounds = YES;
        [self addSubview:_imageView];
        [_imageView release];
        
        self.tableView = [[UITableView alloc] init];
        [_tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"tableView"];
        self.tableView.backgroundColor = [UIColor clearColor];
        
        UIView *backgroundImage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, width / 5 + 5)];
        //设置TableView的顶部高度和样式
        [_tableView setTableHeaderView:backgroundImage];
        [backgroundImage release];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
        [_tableView release];
        
        // MJ第三方上拉加载
        [self.tableView addLegendFooterWithRefreshingBlock:^{
            [self requestData:requestArr[keyword] page:_page++];
        }];
    
        self.imageView.layer.cornerRadius = width / 10;
        self.imageView.frame = CGRectMake(width * 2 / 5, 5, width / 5, width / 5);
        self.imageView.center = CGPointMake(width / 2, width / 10);
        
        self.tableView.frame = CGRectMake(0, 0, width, height);
        
        // 载入标记 (跳点点)
        self.bouncingBalls = [[PQFBouncingBalls alloc] initLoaderOnView:self];
        _bouncingBalls.loaderColor = [UIColor orangeColor];
        [self.bouncingBalls show];
        [_bouncingBalls release];
        [self.tableView.footer beginRefreshing];
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = self.frame.size.width;
    self.imageView.frame = CGRectMake(width * 2 / 5, 5, width / 5 - scrollView.contentOffset.y, width / 5 - scrollView.contentOffset.y);
    self.imageView.center = CGPointMake(width / 2, width / 10 - scrollView.contentOffset.y / 2);
    if (self.imageView.frame.size.height < width / 5) {
        self.imageView.frame = CGRectMake(width * 2 / 5, 5, width / 5, width / 5);
    }
    if (self.imageView.frame.size.height > width / 2) {
        self.imageView.frame = CGRectMake(width * 2 / 5, 5, width / 2, width / 2);
        self.imageView.center = CGPointMake(width / 2, width / 10 - scrollView.contentOffset.y / 2);
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *arr = @[@"早餐·早餐饱饱, 孩子课间不会饿哦",@"午餐·清爽吃肉, 开胃不油腻", @"下午茶·无烤箱, 甜品轻松做", @"晚餐·肉肉走开, 瘦身模式已开启"];
    UIView* myView = [[[UIView alloc] init] autorelease];
    myView.backgroundColor = HomeColor;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 25)];
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text=[arr objectAtIndex:self.keyword];
    if ([titleLabel.text isEqualToString:@"早餐·早餐饱饱, 孩子课间不会饿哦"]) {
        titleLabel.textColor = [UIColor orangeColor];
    } else if ([titleLabel.text isEqualToString:@"午餐·清爽吃肉, 开胃不油腻"]) {
        titleLabel.textColor = [UIColor redColor];
    } else if ([titleLabel.text isEqualToString:@"下午茶·无烤箱, 甜品轻松做"]) {
        titleLabel.textColor = BarColor;
    } else if ([titleLabel.text isEqualToString:@"晚餐·肉肉走开, 瘦身模式已开启"]) {
        titleLabel.textColor = [UIColor colorWithRed:45.0 / 256.0 green:109.0 / 256.0 blue:175.0 / 256.0 alpha:1];
    }

    [myView addSubview:titleLabel];
    [titleLabel release];
    return myView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"aa";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableView"];
    cell.caipu = [self.arr objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.frame.size.width  *0.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailsViewController *detailsVC = [[DetailsViewController alloc] init];
    detailsVC.menu = [self.arr objectAtIndex:indexPath.row];
    [self.target pushViewController:detailsVC animated:YES];
    [detailsVC release];
}

- (void)requestData:(NSString *)keyword page:(NSInteger)page
{
    NSString *str = [NSString stringWithFormat:@"http://ibaby.ipadown.com/api/food/food.show.list.php?keywords=%@&p=%ld&pagesize=20", keyword, page];
    [NetHandler getDataWithUrl:str completion:^(NSData *data) {
        id dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in [dict objectForKey:@"results"]) {
            Home *caipu = [[Home alloc] initWithDictionary:dic];
            [self.arr addObject:caipu];
            [caipu release];
        }
        [_tableView reloadData];
        // 上拉加载结束
        [_tableView.footer endRefreshing];
        // 移除跳点点
        [self.bouncingBalls remove];

    }];
}

@end
