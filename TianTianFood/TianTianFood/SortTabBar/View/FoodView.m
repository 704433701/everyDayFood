//
//  FoodView.m
//  TianTianFood
//
//  Created by dlios on 15/3/23.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "FoodView.h"
#import "FoodCollectionViewCell.h"
#import "Food2CollectionViewCell.h"

@implementation FoodView

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
        
        // 蔬菜的collectionView
        UICollectionViewFlowLayout *vegetableFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        vegetableFlowLayout.itemSize = CGSizeMake((frame.size.width - 25) / 4, (frame.size.height - 70) / 4);
        // 列间距
        vegetableFlowLayout.minimumInteritemSpacing = 5;
        // 行间距
        vegetableFlowLayout.minimumLineSpacing = 5;
        vegetableFlowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
       
        // 蔬菜类
        self.vegetableCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height / 2 - 20) collectionViewLayout:vegetableFlowLayout];
        
        self.vegetableCollectionView.dataSource = self;
        self.vegetableCollectionView.scrollEnabled = NO;
        
        self.vegetableCollectionView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self addSubview:self.vegetableCollectionView];
        [_vegetableCollectionView release];
        [vegetableFlowLayout release];

        [self.vegetableCollectionView registerClass:[FoodCollectionViewCell class] forCellWithReuseIdentifier:@"ding"];
        
        
        // 肉类的collectionView
        UICollectionViewFlowLayout *meatFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        meatFlowLayout.itemSize = CGSizeMake((frame.size.width - 25) / 4, (frame.size.height - 70) / 4);
        // 列间距
        meatFlowLayout.minimumInteritemSpacing = 5;
        // 行间距
        meatFlowLayout.minimumLineSpacing = 5;
        meatFlowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
        // 肉海鲜类
        self.meatCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, frame.size.height / 2 + 20, frame.size.width, frame.size.height / 2 - 20) collectionViewLayout:meatFlowLayout];
        
        self.meatCollectionView.dataSource = self;
        self.meatCollectionView.scrollEnabled = NO;
        
        self.meatCollectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.meatCollectionView];
        [_meatCollectionView release];
        [meatFlowLayout release];
        
        [self.meatCollectionView registerClass:[Food2CollectionViewCell class] forCellWithReuseIdentifier:@"ding1"];
        
        // 中间的标题label
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height / 2 - 20, frame.size.width, 40)];
        self.label.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.label];
        [_label release];
        self.label.text = @"  生鲜 .  肉类";
        self.label.font = [UIFont systemFontOfSize:25];
    
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.vegetableCollectionView) {
   
        
    FoodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ding" forIndexPath:indexPath];

        self.vegetableArr = @[@"山药", @"莲藕", @"春笋", @"香椿", @"菠菜", @"韭菜", @"莴笋", @"茼蒿"];
        cell.label.text = self.vegetableArr[indexPath.row];
        cell.label.textAlignment = NSTextAlignmentCenter;
        NSString *image = [NSString stringWithFormat:@"%ld.png", indexPath.row + 10];
        cell.imageView.image = [UIImage imageNamed:image];
        cell.imageView.clipsToBounds = YES;
        return cell;
        
    } else {
        
        Food2CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ding1" forIndexPath:indexPath];
        self.meatArr = @[@"鱼", @"虾", @"蟹", @"肉类", @"家禽", @"野味", @"贝类", @"其它"];
        cell.label.text = self.meatArr[indexPath.row];
        cell.label.textAlignment = NSTextAlignmentCenter;
        NSString *image = [NSString stringWithFormat:@"%ld", indexPath.row + 18];
        cell.imageView.image = [UIImage imageNamed:image];
        cell.imageView.clipsToBounds = YES;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        return cell;
    }
    

}

- (void)dealloc
{
    [_vegetableArr release];
    [_meatArr release];
    [_label release];
    [_vegetableCollectionView release];
    [_meatCollectionView release];
    [super dealloc];
}




@end
