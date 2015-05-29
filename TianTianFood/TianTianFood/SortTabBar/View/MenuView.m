//
//  MenuView.m
//  TianTianFood
//
//  Created by dlios on 15/3/23.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "MenuView.h"
#import "MenuCollectionViewCell.h"
#import "ListViewController.h"

@implementation MenuView 

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UICollectionViewFlowLayout *menuFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        // 这里的cell的frame是根据下面collectionView的frame决定.
        menuFlowLayout.itemSize = CGSizeMake((frame.size.width - 20) / 3, (frame.size.height - 50) / 3);
        // 列间距
        menuFlowLayout.minimumInteritemSpacing = 5;
        // 行间距
        menuFlowLayout.minimumLineSpacing = 5;
        menuFlowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        
        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
        self.searchBar.barTintColor = HomeColor;
        
//        UIImageView *imageView = [[UIImageView alloc] init];
//        [self.searchBar insertSubview:imageView atIndex:1];
//        [imageView release];
        
        
        // 搜索栏半透明
        self.searchBar.translucent = YES;
        // 代理
        self.searchBar.delegate = self;
        _searchBar.placeholder = @"自定义分类搜索";
        //    有一个按键
        //    self.searchBar.showsCancelButton = YES;
        
        //    取消调用的键盘
        //    [self.searchBar resignFirstResponder];
        
        //    把tableView添加到搜索栏
        //    self.tableView.tableHeaderView = self.searchBar;
        _searchBar.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
        _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        
        [self addSubview:self.searchBar];
        [_searchBar release];
        
        
        
        self.menuCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 30, frame.size.width, frame.size.height - 30) collectionViewLayout:menuFlowLayout];
        self.menuCollectionView.backgroundColor = [UIColor clearColor];
        
        // 签订必须实现的 (显示有关的协议)
        self.menuCollectionView.dataSource = self;
        
        // 关闭menuCollectionView滑动
        self.menuCollectionView.scrollEnabled = NO;
        [self addSubview:self.menuCollectionView];
        [_menuCollectionView release];
        [menuFlowLayout release];
        
        
        [self.menuCollectionView registerClass:[MenuCollectionViewCell class] forCellWithReuseIdentifier:@"ding"];
        
    }
    return self;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ding" forIndexPath:indexPath];
    NSString *image = [NSString stringWithFormat:@"%ld.png", indexPath.row + 1];
    cell.imageView.image = [UIImage imageNamed:image];
    // 图片边缘和imageView一致
    cell.imageView.clipsToBounds = YES;
    
    self.array = @[@"疾病调理", @"实用菜谱", @"一日三餐", @"工艺", @"主食", @"家常", @"小吃", @"西餐", @"烘焙"];
    cell.label.text = self.array[indexPath.row];
    cell.label.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}



//点击搜索框上的 取消按钮时调用
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    // 收回取消按钮
    self.searchBar.showsCancelButton = NO;
    self.searchBar.text = @"";
    // 结束编辑 (回收键盘)
    [self endEditing:YES];
}

//点击搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    ListViewController *listVC = [[ListViewController alloc] init];
    listVC.keyWord = searchBar.text;
    
    // 收回取消按钮
    self.searchBar.showsCancelButton = NO;
    self.searchBar.text = @"";
    // 结束编辑 (回收键盘)
    [self endEditing:YES];
    [self.target pushViewController:listVC animated:YES];
    [listVC release];
}


// 搜索栏已经开始编辑 (修改searchBar的隐藏按钮的title)
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    // 先遍历searchBar 搜索到View
        for(id cc in [searchBar subviews])
        {
            // 再遍历View搜索到button
            for (id a in [cc subviews])
            {
                // 判断
                if([a isKindOfClass:[UIButton class]])
                {
                    UIButton *btn = a;
                    [btn setTitle:@"取消"  forState:UIControlStateNormal];
                }
            }
        }
}


//搜索内容改变
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    self.searchBar.showsCancelButton = NO;
//    self.searchBar.text = @"";
//    // 结束编辑 (回收键盘)
//    [self endEditing:YES];
//}

- (void)dealloc
{
    [_array release];
    [_searchBar release];
    [_menuCollectionView release];
    [super dealloc];
}

@end
