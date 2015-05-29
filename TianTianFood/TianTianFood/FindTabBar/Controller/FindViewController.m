//
//  FindViewController.m
//  TianTianFood
//
//  Created by 张健华 on 15-3-21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "FindViewController.h"
#import "FindView.h"
#import "Find.h"
#import "UIButton+WebCache.h"
#import "DetailsViewController.h"


@interface FindViewController () <FindViewDelegate>

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, retain) NSMutableArray *arr1;
@property (nonatomic, retain) NSMutableArray *arr2;

// 晚餐
@property (nonatomic, retain) FindView *wanView1;
@property (nonatomic, retain) FindView *wanView2;
@property (nonatomic, retain) FindView *wanView3;
@property (nonatomic, retain) FindView *wanView4;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *xiangLabel;
@property (nonatomic, retain) UIImageView *xiangImage;

// 午餐
@property (nonatomic, retain) FindView *wuView1;
@property (nonatomic, retain) FindView *wuView2;
@property (nonatomic, retain) FindView *wuView3;
@property (nonatomic, retain) FindView *wuView4;
@property (nonatomic, retain) UILabel *titleLabel1;
@property (nonatomic, retain) UILabel *xiangLabel1;
@property (nonatomic, retain) UIImageView *xiangImage1;

//早餐
@property (nonatomic, retain) UIImageView *imageView1;
@property (nonatomic, retain) UILabel *moningLabel;

@property (nonatomic, retain) PQFBouncingBalls *bouncingBalls;

@property (nonatomic, assign) BOOL flag;

@property (nonatomic, retain) UIImageView *tishiView;

@property (nonatomic, retain) UIImageView *imageView;

- (void)Fuzhi;

@end

@implementation FindViewController


- (void)Fuzhi
{
    
    for (NSInteger i = 0; i < self.arr.count; i++) {
        FindView *wancan = (FindView *) [self.view viewWithTag:105 + i];
        // 重写setter方法传值
        wancan.find = [self.arr objectAtIndex:i];
        if (i == 0) {
            self.titleLabel.text = [self.arr[0] title];
            self.xiangLabel.text = [self.arr[0] yingyang];
            self.xiangLabel.numberOfLines = 5;
        }
    }
    
    for (NSInteger i = 0; i < self.arr1.count; i++) {
        FindView *wucan = (FindView *) [self.view viewWithTag:101 + i];
        wucan.find = [self.arr1 objectAtIndex:i];
        if (i == 0) {
            self.titleLabel1.text = [self.arr1[0] title];
            self.xiangLabel1.text = [self.arr1[0] yingyang];
            self.xiangLabel1.numberOfLines = 5;
        }
    }
    
    if (self.arr2.count != 0) {
        // 图片网络请求 加占位符
        [self.imageView1 sd_setImageWithURL:[self.arr2[0] thumb_2] placeholderImage:[UIImage imageNamed:@"location.png"]];
        self.moningLabel.text = [self.arr2[0] yingyang];
        self.moningLabel.numberOfLines = 5;
    }
    
}


- (void)requestData
{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    // 早 中 晚 的数组 (数组数据不定)
    self.arr = [NSMutableArray array];
    self.arr1 = [NSMutableArray array];
    self.arr2 = [NSMutableArray array];
    
    // 状态栏网络的状态
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *str = @"http://ibaby.ipadown.com/api/food/food.plan.detail.php?random=1";
    
    [NetHandler getDataWithUrl:str completion:^(NSData *data) {
        if (data == nil) {
            [self requestData];
        } else
        {
            id dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSMutableArray *array = [[dict objectForKey:@"wancan"] objectForKey:@"chi"];
            NSMutableArray *array1 = [[dict objectForKey:@"wucan"] objectForKey:@"chi"];
            NSMutableArray *array2 = [[dict objectForKey:@"zaocan"] objectForKey:@"chi"];
            
            // 晚餐数据解析
            if (array.count == 3) {
                [array addObject:@{@"title": @"其他", @"yingyang": @"不好意思没有这个图片介绍", @"thumb_2": @"http://picapi.ooopic.com/10/60/78/86b1OOOPIC65.jpg"}];
            } else if (array.count == 2) {
                [array addObject:@{@"title": @"其他", @"yingyang": @"不好意思没有这个图片介绍", @"thumb_2": @"http://picapi.ooopic.com/10/60/78/86b1OOOPIC65.jpg"}];
                [array addObject:@{@"title": @"其他", @"yingyang": @"不好意思没有这个图片介绍", @"thumb_2": @"http://img2.3lian.com/2014/f3/92/d/33.jpg"}];
            }
            
            for (NSDictionary *dic in array) {
                Find *findFood = [[Find alloc] initWithDictionary:dic];
                [self.arr addObject:findFood];
                [findFood release];
            }

            
            // 午餐数据解析
            if (array1.count == 3) {
                [array1 addObject:@{@"title": @"其他", @"yingyang": @"不好意思没有这个图片介绍", @"thumb_2": @"http://picapi.ooopic.com/10/60/78/86b1OOOPIC65.jpg"}];
            } else if (array.count == 2) {
                [array1 addObject:@{@"title": @"其他", @"yingyang": @"不好意思没有这个图片介绍", @"thumb_2": @"http://picapi.ooopic.com/10/60/78/86b1OOOPIC65.jpg"}];
                [array1 addObject:@{@"title": @"其他", @"yingyang": @"不好意思没有这个图片介绍", @"thumb_2": @"http://img2.3lian.com/2014/f3/92/d/33.jpg"}];
            }
         
            for (NSDictionary *dic in array1) {
                Find *findFood = [[Find alloc] initWithDictionary:dic];
                [self.arr1 addObject:findFood];
                [findFood release];
            }

            
            // 早餐数据解析
            for (NSDictionary *dic in array2) {
                Find *findFood = [[Find alloc] initWithDictionary:dic];
                if ([[[dict objectForKey:@"zaocan"] objectForKey:@"thumb"] isEqual:@""]) {
                    [self requestData];
                }
                findFood.thumb_2 = [[dict objectForKey:@"zaocan"] objectForKey:@"thumb"];
                [self.arr2 addObject:findFood];
                [findFood release];
            }
            
            [self Fuzhi];
            
            // 网络请求结束后撤销跳点点
            [self.bouncingBalls hide];
            
            // 四个圈移动的动画效果 (改变frame)
            [UIScrollView animateWithDuration:1 animations:^{
                self.wuView1.frame = CGRectMake(width / 3 + width, 10, width / 3, width / 3 + 30);
                self.wuView2.frame = CGRectMake(width * 40 / 375 + width, height / 3 + 10 - 64, width / 5, width / 5 + 30);
                self.wuView3.frame = CGRectMake(width * 170 / 375 + width, height * 2 / 5 + 20 - 64, width / 4, width / 4 + 30);
                self.wuView4.frame = CGRectMake(width * 270 / 375 + width, height / 4 - 64, width / 4, width / 4 + 30);
                self.wanView1.frame = CGRectMake(width / 3 + width * 2, 10, width / 3, width / 3 + 30);
                self.wanView2.frame = CGRectMake(width * 30 / 375 + width * 2, height / 3 - 64, width / 4, width / 4 + 30);
                self.wanView3.frame = CGRectMake(width * 180 / 375 + width * 2, height * 2 / 5 + 20 - 64, width / 4, width / 4 + 30);
                self.wanView4.frame = CGRectMake(width * 270 / 375 + width * 2, height / 4 - 64, width / 5, width / 5 + 30);
                
            } completion:^(BOOL finished) {
                self.flag = YES;
                
                // 动画结束
                [_imageView stopAnimating];
                self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shaizi0.png"] style:UIBarButtonItemStylePlain target:self action:@selector(shaizi:)];
            }];
            
        }
    }];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 转动股子的动画
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; i++) {
        NSString *name = [NSString stringWithFormat:@"shaizi%ld.png", i];
        UIImage *image = [UIImage imageNamed:name];
        [arr addObject:image];
    }
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    _imageView.animationRepeatCount = 0;
    _imageView.animationImages = arr;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shaizi0.png"] style:UIBarButtonItemStylePlain target:self action:@selector(shaizi:)];
    
    // 更新数据 (异步)
    [self requestData];
    // View需要重新再铺一遍视图 更新界面

    [self subView];
    
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit: YES];
    [self becomeFirstResponder];
    
    NSUserDefaults *userDe = [NSUserDefaults standardUserDefaults];
    if ([userDe boolForKey:@"userFind"] == NO) {
        self.tishiView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
        _tishiView.backgroundColor = [UIColor blackColor];
        _tishiView.alpha = 0.7;
        _tishiView.image = [UIImage imageNamed:@"tishi.png"];
        [self.view addSubview:_tishiView];
        [_tishiView release];
        _tishiView.contentMode = UIViewContentModeTopRight;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(self.view.frame.size.width * 3 / 5 , self.view.frame.size.width * 2 / 5 - 35, self.view.frame.size.width * 2 / 5, 30);
        [button setImage:[UIImage imageNamed:@"quxiao.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tishiButton:) forControlEvents:UIControlEventTouchUpInside];
        [_tishiView addSubview:button];
        _tishiView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *top = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tishiButton:)];
        [_tishiView addGestureRecognizer:top];
        [top release];
    }
}

- (void)tishiButton:(UIButton *)button
{
    NSUserDefaults *userDe = [NSUserDefaults standardUserDefaults];
    if ([button isKindOfClass:[UIButton class]]) {
        [userDe setBool:YES forKey:@"userFind"];
        [userDe synchronize];
    }
    [_tishiView removeFromSuperview];
}

- (void)subView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, width, height - 113)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(width * 3, 0);
    // scrollView偏移量
    self.scrollView.contentOffset = CGPointMake(width, 0);
    [self.view addSubview:self.scrollView];
    [_scrollView release];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg3.png"]];
    imageView.frame = CGRectMake(0, 0, _scrollView.contentSize.width, self.view.frame.size.height);
    [_scrollView addSubview:imageView];
    [imageView release];
    
    // 早 中 晚 title标签
    UILabel *zaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    zaoLabel.center = CGPointMake(width / 2, 35);
    zaoLabel.text = @"早餐";
    zaoLabel.textColor = [UIColor orangeColor];
    zaoLabel.textAlignment = NSTextAlignmentCenter;
    zaoLabel.font = [UIFont systemFontOfSize:30];
    [self.scrollView addSubview:zaoLabel];
    [zaoLabel release];
    
    UILabel *wucanLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + width, 10, 60, 50)];
    wucanLabel.text = @"午餐";
    wucanLabel.textColor = [UIColor redColor];
    // Label 文字透明度
    wucanLabel.font = [UIFont systemFontOfSize:30];
    wucanLabel.shadowColor = [UIColor grayColor];
    wucanLabel.shadowOffset = CGSizeMake(1, 1);
    [self.scrollView addSubview:wucanLabel];
    [wucanLabel release];
    
    UILabel *wancanLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + width * 2, 10, 100, 50)];
    wancanLabel.text = @"晚餐";
    wancanLabel.textColor = [UIColor colorWithRed:45.0 / 256.0 green:109.0 / 256.0 blue:175.0 / 256.0 alpha:1];
    wancanLabel.font = [UIFont systemFontOfSize:30];
    wancanLabel.shadowColor = [UIColor grayColor];
    wancanLabel.shadowOffset = CGSizeMake(1, 1);
    [self.scrollView addSubview:wancanLabel];
    [wancanLabel release];
    
    // 早餐界面
    UIView *yinYing = [[UIView alloc] initWithFrame:CGRectMake(8, 68, width - 16, (height - 113) / 2 + 4)];
    yinYing.backgroundColor = [UIColor randomColorWithAlpha:0.5];
    yinYing.layer.cornerRadius = 10;
    [self.scrollView addSubview:yinYing];
    [yinYing release];
    
    self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 70, width - 20, (height - 113) / 2)];
    self.imageView1.layer.cornerRadius = 10;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    self.imageView1.userInteractionEnabled = YES;
    [self.imageView1 addGestureRecognizer:tap];
    [tap release];
    
    self.imageView1.clipsToBounds = YES;
    [self.scrollView addSubview:self.imageView1];
    [_imageView1 release];
    
    self.moningLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, height / 2 - 64 + 80, width - 20, (height - 113) / 2 - 80)];
    self.moningLabel.font = [UIFont systemFontOfSize:18];
    self.moningLabel.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.moningLabel];
    [self.moningLabel release];
    
    
    // 午餐界面
    self.wuView2 = [[FindView alloc] initWithFrame: CGRectMake(width * 40 / 375 + width, height / 3 + 10 - 64, width / 5, width / 5 + 30)];
    self.wuView2.imageView1.layer.cornerRadius = width / 10;
    // 封装点击手势后要签订代理来实现推下一个界面
    self.wuView2.delegate = self;
    [self.scrollView addSubview:self.wuView2];
    [_wuView2 release];
    
    self.wuView3 = [[FindView alloc] initWithFrame:CGRectMake(width * 170 / 375 + width, height * 2 / 5 + 20 - 64, width / 4, width / 4 + 30)];
    self.wuView3.imageView1.layer.cornerRadius = width / 8;
    self.wuView3.delegate = self;
    [self.scrollView addSubview:self.wuView3];
    [_wuView3 release];
    
    self.wuView4 = [[FindView alloc] initWithFrame:CGRectMake(width * 270 / 375 + width, height / 4 - 64, width / 4, width / 4 + 30)];
    self.wuView4.imageView1.layer.cornerRadius = width / 8;
    self.wuView4.delegate = self;
    [self.scrollView addSubview:self.wuView4];
    [_wuView4 release];
    
    self.wuView1 = [[FindView alloc] initWithFrame:CGRectMake(width / 3 + width, 10, width / 3, width / 3 + 30)];
    self.wuView1.imageView1.layer.cornerRadius = width / 6;
    self.wuView1.delegate = self;
    [self.scrollView addSubview:self.wuView1];
    [_wuView1 release];
    
    
    self.titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(width + 10, height * 346.55 / 667.0, width - 100, 30)];
    self.titleLabel1.font = [UIFont systemFontOfSize:25];
//    self.titleLabel1.backgroundColor = [UIColor blackColor];
    [self.scrollView addSubview:self.titleLabel1];
    [_titleLabel1 release];
    
    self.xiangLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(width + 5, self.titleLabel1.frame.origin.y + 30, width - 10, height - (self.titleLabel1.frame.origin.y + 30) - 113 - 5)];
    self.xiangLabel1.backgroundColor = [UIColor clearColor];
    self.xiangLabel1.font = [UIFont systemFontOfSize:18];
    // 设置label的边框
    [self.scrollView addSubview:self.xiangLabel1];
    [_xiangLabel1 release];
    
    // 晚餐界面
    self.wanView2 = [[FindView alloc] initWithFrame:CGRectMake(width * 30 / 375 + width * 2, height / 3 - 64, width / 4, width / 4 + 30)];
    self.wanView2.imageView1.layer.cornerRadius = width / 8;
    self.wanView2.delegate = self;
    [self.scrollView addSubview:self.wanView2];
    [_wanView2 release];
    
    self.wanView3 = [[FindView alloc] initWithFrame:CGRectMake(width * 180 / 375 + width * 2, height * 2 / 5 + 20 - 64, width / 4, width / 4 + 30)];
    self.wanView3.imageView1.layer.cornerRadius = width / 8;
    self.wanView3.delegate = self;
    [self.scrollView addSubview:self.wanView3];
    [_wanView3 release];
    
    self.wanView4 = [[FindView alloc] initWithFrame:CGRectMake(width * 270 / 375 + width * 2, height / 4 - 64, width / 5, width / 5 + 30)];
    self.wanView4.imageView1.layer.cornerRadius = width / 10;
    self.wanView4.delegate = self;
    [self.scrollView addSubview:self.wanView4];
    [_wanView4 release];
    
    self.wanView1 = [[FindView alloc] initWithFrame:CGRectMake(width / 3 + width * 2, 10, width / 3, width / 3 + 30)];
    self.wanView1.imageView1.layer.cornerRadius = width / 6;
    
    // 签订协议命令对象为自己
    self.wanView1.delegate = self;
    [self.scrollView addSubview:self.wanView1];
    [_wanView1 release];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width * 2 + 10, height * 346.5 / 667.0, width - 100, 30)];
    self.titleLabel.font = [UIFont systemFontOfSize:25];
//    self.titleLabel.backgroundColor = [UIColor blackColor];
    [self.scrollView addSubview:self.titleLabel];
    [_titleLabel release];
    
    self.xiangLabel = [[UILabel alloc] initWithFrame:CGRectMake(width * 2 + 5, self.titleLabel.frame.origin.y + 30, width - 10, height - (self.titleLabel.frame.origin.y + 30) - 113 - 5)];
    self.xiangLabel.backgroundColor = [UIColor clearColor];
    self.xiangLabel.font = [UIFont systemFontOfSize:18];
    [self.scrollView addSubview:self.xiangLabel];
    [_xiangLabel release];
    
    
    // 载入标记 (铺完试图后创建  只要有网络请求就会跳点点)
    self.bouncingBalls = [[PQFBouncingBalls alloc] initLoaderOnView:self.view];
    _bouncingBalls.loaderColor = [UIColor redColor];
    [self.bouncingBalls show];
    [_bouncingBalls release];
    
    
    self.imageView1.tag = 100;
    self.wuView1.tag = 101;
    self.wuView2.tag = 102;
    self.wuView3.tag = 103;
    self.wuView4.tag = 104;
    self.wanView1.tag = 105;
    self.wanView2.tag = 106;
    self.wanView3.tag = 107;
    self.wanView4.tag = 108;
    
}



// 协议的方法
- (void)push:(Find *)find
{
    if (find != nil) {
        DetailsViewController *detailsView = [[DetailsViewController alloc] init];
        detailsView.menu = [[[Home alloc] initWithFind:find] autorelease];
        [self.navigationController pushViewController:detailsView animated:YES];
        [detailsView release];
    }
}

- (void)shaizi:(UIBarButtonItem *)bar
{
    if (self.flag) {
        // 判断在动画过程中过多的点击无效
        self.flag = NO;
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_imageView];
        // 开始动画
        [_imageView startAnimating];
        // 动画效果
        [UIScrollView animateWithDuration:1 animations:^{
            
            self.wuView1.center = CGPointMake(self.wuView1.center.x, self.wuView1.center.y - 1);
            self.wuView2.center = CGPointMake(self.wuView1.center.x, self.wuView1.center.y - 12);
            self.wuView3.center = CGPointMake(self.wuView1.center.x, self.wuView1.center.y - 12);
            self.wuView4.center = CGPointMake(self.wuView1.center.x, self.wuView1.center.y - 12);
            self.wanView1.center = CGPointMake(self.wanView1.center.x, self.wanView1.center.y - 1);
            self.wanView2.center = CGPointMake(self.wanView1.center.x, self.wanView1.center.y - 12);
            self.wanView3.center = CGPointMake(self.wanView1.center.x, self.wanView1.center.y - 12);
            self.wanView4.center = CGPointMake(self.wanView1.center.x, self.wanView1.center.y - 12);
            
        } completion:^(BOOL finished) {
            
            
            [self requestData];
            [self.bouncingBalls show];
            
        }];
    }
}


// 早餐点击方法 (加点击手势)
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    NSLog(@"%ld", self.arr2.count);
    if (self.arr2.count > 0) {
        DetailsViewController *detailsView = [[DetailsViewController alloc] init];
        detailsView.menu = [[[Home alloc] initWithFind:self.arr2[0]] autorelease];
        [self.navigationController pushViewController:detailsView animated:YES];
        [detailsView release];
    }
}



- (void)dealloc
{
    [_bouncingBalls release];
    [_arr release];
    [_arr1 release];
    [_arr2 release];
    [_scrollView release];
    [_wanView1 release];
    [_wanView2 release];
    [_wanView3 release];
    [_wanView4 release];
    [_wuView1 release];
    [_wuView2 release];
    [_wuView3 release];
    [_wuView4 release];
    [_titleLabel release];
    [_xiangLabel release];
    [_titleLabel1 release];
    [_xiangLabel1 release];
    [_tishiView release];
    [_imageView release];
    [super dealloc];
}

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{

    //检测到摇动
    // 开始震动
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
    if(event.subtype == UIEventSubtypeMotionShake) {
        // 动画开始
        [self shaizi:nil];
    }
   
}

- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //摇动取消
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    

    //摇动结束
  
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
