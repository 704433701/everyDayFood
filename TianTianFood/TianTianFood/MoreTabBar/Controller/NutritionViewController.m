//
//  NutritionViewController.m
//  TianTianFood
//
//  Created by dlios on 15/3/27.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "NutritionViewController.h"
#import "ListXiaoViewController.h"

@interface NutritionViewController () <UITableViewDataSource, UITableViewDelegate>
{
    // 定义 成员变量存储 点击 的哪个区
    NSInteger firstSection;
    // 记录点击同一个区的次数
    BOOL click;
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, retain) NSMutableArray *arrName;
@property (nonatomic, retain) NSMutableArray *colorArr;


@end

@implementation NutritionViewController


- (void)requestData
{

    NSString *str = @"http://ibaby.ipadown.com/api/food/food.tips.category.php";
    [NetHandler getDataWithUrl:str completion:^(NSData *data) {
        id dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        // 分组名数组
        self.arrName = [dict objectForKey:@"indexs"];
        for (NSDictionary *dic in [dict objectForKey:@"items"]) {
            NSArray *arr = [dic objectForKey:@"items"];
            // 分组下面的小数组
            [self.arr addObject:arr];
            [self.colorArr addObject:[UIColor randomColor]];
        }
        
        [self.tableView reloadData];

    }];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"营养小知识";
    self.arr = [NSMutableArray array];
    self.arrName = [NSMutableArray array];
    self.colorArr = [NSMutableArray array];
    [self requestData];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [_tableView release];
    firstSection = 1;
    click = YES;

    
}

// 显示分区数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrName.count;
}

// 显示区域的名称
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"你真棒";
}


// 分区栏头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}


// 返回section视图样式(自定义分区)
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *fenzuView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 49)] autorelease];
    fenzuView.backgroundColor = [self.colorArr objectAtIndex:section];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, self.view.frame.size.width, 49);
    [button setTitle:[self.arrName objectAtIndex:section] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor lightTextColor];
    button.tag = section;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [fenzuView addSubview:button];
    return fenzuView;
}


- (void)buttonAction:(UIButton *)button
{
    NSLog(@"%ld", button.tag);
    if (firstSection == button.tag) {
        click = !click;
    } else {
        firstSection = button.tag;
        click = NO;
    }
    [UIView animateWithDuration:1 animations:^{
        [self.tableView reloadData];
    }];

}

// 该页面每个区域cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (click == NO) {
        if (firstSection == section) {
            return [[self.arr objectAtIndex:section] count];
        } else {
            
            return 0;
        }
        } else {
            return 0;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"ding";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (self) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str] autorelease];
    }
    cell.textLabel.text = [[self.arr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ListXiaoViewController *listVC = [[ListXiaoViewController alloc] init];
    listVC.title = [[self.arr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:listVC animated:YES];
    listVC.name = [[self.arr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [listVC release];
    
    
}

- (void)dealloc
{
    [_tableView release];
    [_arrName release];
    [_arr release];
    [_colorArr release];
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
