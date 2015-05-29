//
//  SubjectViewController.m
//  TianTianFood
//
//  Created by 张健华 on 15-3-21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "SubjectViewController.h"
#import "SubjectCollectionViewCell.h"
#import "MySubjectTableViewCell.h"
#import "InfoSubjectViewController.h"
#import "Subject.h"
#import "SubjectHot.h"
#import "HotSubjectViewController.h"
#import "MJRefreshHeader.h"




@interface SubjectViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property(nonatomic, retain) NSMutableArray *arr;
@property(nonatomic, retain) UITableView *tableView;
@property(nonatomic, retain) UIView *hotView;
@property(nonatomic, retain) UIView *netView;
@property(nonatomic, retain) Subject *subject;
@property(nonatomic, retain) UICollectionView *collectionView;
@property(nonatomic, retain) NSMutableArray *array;
@property(nonatomic, retain) SubjectHot *subjectHot;
@property(nonatomic, retain) NSMutableArray *imagesArr;
@property(nonatomic, retain) NSMutableArray *imagesArr2;
@property(nonatomic, retain) UIImageView *aliImageView;
@property(nonatomic, assign) NSInteger j;
@property(nonatomic, assign) NSInteger k;
@property(nonatomic, retain) UIScrollView *scrollView;
@property(nonatomic, assign) CGFloat offY;
@property(nonatomic, assign) CGFloat offTY;

@end

@implementation SubjectViewController
- (void)dealloc
{
    [_scrollView release];
    [_aliImageView release];
    [_imagesArr release];
    [_imagesArr2 release];
    [_array release];
    [_subjectHot release];
    [_collectionView release];
    [_subject release];
    [_netView release];
    [_hotView release];
    [_tableView release];
    [_arr release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:naviView];

    ///////////////////////////////// 热门分享view //////////////////////////////////////////////////
    
    self.offY = 0;
    self.offTY = 0;
    self.hotView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    [self.view addSubview:self.hotView];
    self.hotView.backgroundColor = [UIColor clearColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49 + 49) style:UITableViewStylePlain];
    self.tableView.contentInset = UIEdgeInsetsMake(naviView.frame.size.height + 20, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.hotView addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.k = 1;
    self.array = [NSMutableArray array];
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [self loadData];
    }];
    [self.tableView.footer beginRefreshing];
    [_hotView release];
    [_tableView release];
    // segment设置
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"网友作品", @"热门分享"]];
    segment.selectedSegmentIndex = 0;
    segment.tag = 100;
    segment.frame = CGRectMake(naviView.frame.size.width / 2 - naviView.frame.size.width / 4, naviView.frame.size.height / 2 - 15, naviView.frame.size.width / 2, 30);
//    [naviView addSubview:segment];
    self.navigationItem.titleView  = segment;
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [segment release];
    
    //////////////////////////////// 网友作品view //////////////////////////////////////////
    self.netView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.netView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:self.netView];
    
    // collectionView设置
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width / 2.5, self.view.frame.size.height / 3.335);
    flowLayout.minimumLineSpacing = 15;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(naviView.frame.size.height + 18, 18, 0, 18);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - naviView.frame.size.height - 44 - 20 + naviView.frame.size.height + 20 + 44) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.netView addSubview:self.collectionView];
    [self.collectionView registerClass:[SubjectCollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
    [_collectionView release];
    [naviView release];
    ////////////////////////////////////////
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.2];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.scrollView addSubview:self.hotView];
    [self.scrollView addSubview:self.netView];
    [_scrollView release];

    self.collectionView.delegate = self;
    self.aliImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 32, 0, 64, 64)];
    [self.collectionView addSubview:self.aliImageView];
    self.collectionView.showsVerticalScrollIndicator = NO;
    [_aliImageView release];
    self.imagesArr = [NSMutableArray array];
    self.imagesArr2 = [NSMutableArray array];
    for (NSInteger i = 0; i < 6; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.tiff", i + 1]];
        [self.imagesArr addObject:image];
    }
    self.imagesArr2 = [NSMutableArray array];
    for (NSInteger i = 6; i < 47; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.tiff", i + 1]];
        [self.imagesArr2 addObject:image];
    }

    
    //////////////////////////// 数据 ////////////////////////////////////
    self.arr = [NSMutableArray array];
    self.j = 1;
    
    
    [self.collectionView addGifHeaderWithRefreshingBlock:^{
        [self loadData:@"http://wenyijcc.com/services/wenyiapp/submithandler.ashx?action=kitt&op=1&sort=date&pi=1&psize=40"];
        
    }];
    
    [self.collectionView addLegendFooterWithRefreshingBlock:^{
        [self loadData:[NSString stringWithFormat:@"http://wenyijcc.com/services/wenyiapp/submithandler.ashx?action=kitt&op=1&sort=date&pi=%ld&psize=40", self.j++]];
    }];

    [self.collectionView.footer beginRefreshing];
}

// scrollView代理方法, 监测偏移量
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    UISegmentedControl *sege = (UISegmentedControl *)self.navigationItem.titleView;
    if (scrollView.contentOffset.y < -80) {
         _aliImageView.image = [UIImage animatedImageWithImages:self.imagesArr duration:0.5];
    }
    if (scrollView.contentOffset.y >= - 80) {
        _aliImageView.image = [UIImage animatedImageWithImages:self.imagesArr2 duration:1];
    }
    if (scrollView.contentOffset.y == 0) {
        _aliImageView.image = [UIImage animatedImageWithImages:nil duration:10];
    }
    if (self.scrollView.contentOffset.x >= self.view.frame.size.width - 100) {
        sege.selectedSegmentIndex = 1;
    }
    if (self.scrollView.contentOffset.x == 0) {
        sege.selectedSegmentIndex = 0;
    }
    
    if (scrollView == self.collectionView) {
        
    

    if (self.collectionView.contentOffset.y > 0 && self.tabBarController.tabBar.frame.origin.y <= self.view.frame.size.height)  {
        [UIView animateWithDuration:1 animations:^{
            for (NSInteger i = 1; i < 6; i++) {
                self.tabBarController.tabBar.frame = CGRectMake(0, self.view.frame.size.height - 49 + 9.8 * i , self.view.frame.size.width, 49);
            }
        }];
    }
    if (self.offY > self.collectionView.contentOffset.y ) {
        [UIView animateWithDuration:1 animations:^{
            for (NSInteger i = 1; i < 6; i++) {
                self.tabBarController.tabBar.frame = CGRectMake(0, self.view.frame.size.height - 9.8 * i , self.view.frame.size.width, 49);
            }
        }];
    }
    if ((self.collectionView.contentOffset.y - (self.collectionView.contentSize.height - self.view.frame.size.height) < 10) && (self.collectionView.contentOffset.y - (self.collectionView.contentSize.height - self.view.frame.size.height) > -10) && self.tabBarController.tabBar.frame.origin.y <= self.view.frame.size.height) {
        [UIView animateWithDuration:1 animations:^{
            //            self.tabBarController.tabBar.hidden = YES;
            for (NSInteger i = 1; i < 6; i++) {
                self.tabBarController.tabBar.frame = CGRectMake(0, self.view.frame.size.height - 49 + 9.8 * i , self.view.frame.size.width, 49);
            }
        }];
        //        self.offY = self.scrollView.contentOffset.y;
    }
    self.offY = self.collectionView.contentOffset.y;
    }
    
    if (scrollView == self.tableView) {
        
        
        
        if (self.tableView.contentOffset.y > 0 && self.tabBarController.tabBar.frame.origin.y <= self.view.frame.size.height)  {
            [UIView animateWithDuration:1 animations:^{
                for (NSInteger i = 1; i < 6; i++) {
                    self.tabBarController.tabBar.frame = CGRectMake(0, self.view.frame.size.height - 49 + 9.8 * i , self.view.frame.size.width, 49);
                }
            }];
        }
        if (self.offTY > self.tableView.contentOffset.y ) {
            [UIView animateWithDuration:1 animations:^{
                for (NSInteger i = 1; i < 6; i++) {
                    self.tabBarController.tabBar.frame = CGRectMake(0, self.view.frame.size.height - 9.8 * i , self.view.frame.size.width, 49);
                }
            }];
        }
        if ((self.tableView.contentOffset.y - (self.tableView.contentSize.height - self.view.frame.size.height) < 10) && (self.tableView.contentOffset.y - (self.tableView.contentSize.height - self.view.frame.size.height) > -10) && self.tabBarController.tabBar.frame.origin.y <= self.view.frame.size.height) {
            [UIView animateWithDuration:1 animations:^{
                //            self.tabBarController.tabBar.hidden = YES;
                for (NSInteger i = 1; i < 6; i++) {
                    self.tabBarController.tabBar.frame = CGRectMake(0, self.view.frame.size.height - 49 + 9.8 * i , self.view.frame.size.width, 49);
                }
            }];
            //        self.offY = self.scrollView.contentOffset.y;
        }
        self.offTY = self.tableView.contentOffset.y;
    }
    
    
    
    
    
    
}


// collectionView代理方法
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%ld", indexPath.item);
    InfoSubjectViewController *infoVC = [[InfoSubjectViewController alloc] init];
    infoVC.subject = self.arr[indexPath.item];
//    NSLog(@"%@", infoVC.subject.UserImageUrl);
    [self.navigationController pushViewController:infoVC animated:YES];
    [infoVC release];
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Subject *subject = self.arr[indexPath.item];
    SubjectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    cell.subject = subject;
    cell.label.text = subject.NickName;
    cell.backgroundColor = [UIColor clearColor];

    return cell;
}




- (void) segmentAction:(UISegmentedControl *)segment
{
    [UIView animateWithDuration:0.5 animations:^{
        if(segment.selectedSegmentIndex == 1){
//            [self.view bringSubviewToFront:self.hotView];
            self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
        }else{
            self.scrollView.contentOffset = CGPointMake(0, 0);
        }
    }  ];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

// tableVidew方法
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"adwfaee";
    MySubjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[[MySubjectTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr] autorelease];
    }
    SubjectHot *subjectHot = self.array[indexPath.row];
    cell.subjectHot = subjectHot;
    cell.wordLabel.text = subjectHot.title;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HotSubjectViewController *hotVC = [[HotSubjectViewController alloc] init];
    hotVC.subject = self.array[indexPath.row];
    NSLog(@"第%ld个cell==============================", indexPath.row);
    [self.navigationController pushViewController:hotVC animated:YES];
    [hotVC release];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height / 3;
}
// 加载数据
- (void) loadData:(NSString *)str
{
    [NetHandler getDataWithUrl:str completion:^(NSData *data) {
        id dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in [dict objectForKey:@"datas"]) {
            Subject *subject = [[Subject alloc] initWithDictionary:dic];
            [self.arr addObject:subject];
            [subject release];
        }
        [self.collectionView reloadData];
        [self.collectionView.gifHeader endRefreshing];
      //  [self.collectionView.header endRefreshing];
        [self.collectionView.footer endRefreshing];
    }];
}

- (void) loadData
{
    NSString *str = [NSString stringWithFormat:@"http://ibaby.ipadown.com/api/food/food.topic.list.php?p=%ld&pagesize=20&order=addtime", self.k++];
    [NetHandler getDataWithUrl:str completion:^(NSData *data) {
        id dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in [dict objectForKey:@"results"]) {
            SubjectHot *subjectHot = [[SubjectHot alloc] initWithDictionary:dic];
            [self.array addObject:subjectHot];
            [subjectHot release];
        }
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
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
