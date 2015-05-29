//
//  MenuSubjectViewController.m
//  TianTianFood
//
//  Created by dlios on 15-3-25.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "MenuSubjectViewController.h"
#import "ImageSubject.h"

@interface MenuSubjectViewController ()<UIScrollViewDelegate>

@end

@implementation MenuSubjectViewController
- (void)dealloc
{
    [_subject release];
    [_imageArr release];
    [_imageView1 release];
    [_imageView2 release];
    [_imageView3 release];
    [_imageView4 release];
    [_previous release];
    [_arr release];
    [_scrollView release];
    [_titleLabel release];
    [_bigImageView release];
    [_feedLabel release];
    [_flavLabel release];
    [_workLabel release];
    [_superWordLabel release];
//    [_exampleView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
      self.offY = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.view addSubview:headView];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, headView.frame.size.height)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:self.titleLabel];
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    [_titleLabel release];
    /////////////////////////////////////////////////////////////////////////
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, headView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - headView.frame.size.height)];
    [self.view addSubview:self.scrollView];
    // 4s
    if (self.view.frame.size.height <= 480) {
        if (self.tabBarController.tabBar.frame.origin.y <= self.view.frame.size.height)  {
            [UIView animateWithDuration:1 animations:^{
                for (NSInteger i = 1; i < 6; i++) {
                    self.tabBarController.tabBar.frame = CGRectMake(0, self.view.frame.size.height - 49 + 9.8 * i , self.view.frame.size.width, 49);
                }
            }];
        }
    }
    if (self.view.frame.size.height > 480) {
        self.scrollView.delegate = self;
    }
    self.scrollView.showsVerticalScrollIndicator = NO;

    self.bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2.5 - 15)];
    [self.scrollView addSubview:self.bigImageView];
    [_bigImageView release];
    
    self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bigImageView.frame.origin.y + self.bigImageView.frame.size.height + 5, 30, 30)];
    [self.scrollView addSubview:self.imageView1];
    self.imageView1.image = [UIImage imageNamed:@"1subject.png"];
    [_imageView1 release];
    
    self.feedLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - self.view.frame.size.width / 2.2, self.bigImageView.frame.origin.y + self.bigImageView.frame.size.height + self.imageView1.frame.size.height + 10, self.view.frame.size.width / 1.1, self.view.frame.size.height / 3)];
    self.feedLabel.font = [UIFont systemFontOfSize:13];
    [self.scrollView addSubview:self.feedLabel];
    [_feedLabel release];
    
    self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.feedLabel.frame.size.height + self.feedLabel.frame.origin.y + 5, 30, 30)];
    self.imageView2.image = [UIImage imageNamed:@"2subject.png"];
    [self.scrollView addSubview:self.imageView2];
    [_imageView2 release];
    
    self.flavLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - self.view.frame.size.width / 2.2, self.imageView2.frame.origin.y + self.imageView2.frame.size.height, self.view.frame.size.width / 1.1, self.view.frame.size.height / 3)];
    [self.scrollView addSubview:self.flavLabel];
    self.flavLabel.font = [UIFont systemFontOfSize:13];
    [_flavLabel release];
    
    self.imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.flavLabel.frame.size.height + self.flavLabel.frame.origin.y + 5, 30, 30)];
    self.imageView3.image = [UIImage imageNamed:@"3subject.png"];
    [self.scrollView addSubview:self.imageView3];
    [_imageView3 release];
    
    self.workLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - self.view.frame.size.width / 2.2, self.imageView3.frame.origin.y + self.imageView3.frame.size.height, self.view.frame.size.width / 1.1, self.view.frame.size.height / 3)];
    [self.scrollView addSubview:self.workLabel];
    self.workLabel.font = [UIFont systemFontOfSize:13];
    [_workLabel release];
    
    self.imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.workLabel.frame.size.height + self.workLabel.frame.origin.y + 5, 30, 30)];
    self.imageView4.image = [UIImage imageNamed:@"4subject.png"];
    [self.scrollView addSubview:self.imageView4];
    [_imageView4 release];
    
    self.superWordLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - self.view.frame.size.width / 2.2, self.imageView4.frame.origin.y + self.imageView4.frame.size.height, self.view.frame.size.width / 1.1, self.view.frame.size.height / 3)];
    [self.scrollView addSubview:self.superWordLabel];
    self.superWordLabel.font = [UIFont systemFontOfSize:13];
    [_superWordLabel release];
    self.feedLabel.numberOfLines = 0;
    self.flavLabel.numberOfLines = 0;
    self.workLabel.numberOfLines = 0;
    self.superWordLabel.numberOfLines = 0;
    [self loadData];
//    [_exampleView release];
    [_scrollView release];
    [headView release];
    
    
}
- (void) loadData
{
    self.arr = [NSMutableArray array];
    self.imageArr = [NSMutableArray array];

    NSString *str = [NSString stringWithFormat:@"http://wenyijcc.com/services/wenyiapp/recipehandler.ashx?action=detail&recipeguid=%@", self.subject.RecipeGuid];
    NSLog(@"99999999%@", str);

    [NetHandler getDataWithUrl:str completion:^(NSData *data) {
        id dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        PreviousSubject *previous = [[PreviousSubject alloc] initWithDictionary:dict];
        [self.arr addObject:previous];
        
        self.navigationItem.title = previous.RecipeName;
        self.titleLabel.text = previous.RecipeName;
        [self.bigImageView sd_setImageWithURL:previous.MainImageUrl placeholderImage:[UIImage imageNamed:@"location1.png"]];
        self.feedLabel.text = previous.Ingredients;
        if (previous.Ingredients == nil) {
            self.feedLabel.text = @"无";
        }
        self.flavLabel.text = previous.Seasoning;
        if ([previous.Seasoning isEqualToString:@""]) {
            self.flavLabel.text = [NSString stringWithFormat:@"做%@不用调料哦😊", previous.RecipeName];
        }
        if (previous.RecipeContent.length > 0) {
            for (NSInteger i = 0; i < previous.RecipeContent.length; i++) {
                if ([previous.RecipeContent hasSuffix:@"\n" ] || [previous.RecipeContent hasSuffix:@" "]) {
                    previous.RecipeContent = [previous.RecipeContent substringToIndex:previous.RecipeContent.length - 1];
                }
            }
        }
        NSLog(@"???%@???", previous.RecipeContent);

        
        self.workLabel.text = previous.RecipeContent;
        if (previous.RecipeContent == nil) {
            self.workLabel.text = @"无";
        }
        previous.RecipeNotes = [previous.RecipeNotes stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        self.superWordLabel.text = previous.RecipeNotes;
        if (previous.RecipeContent == nil) {
            self.workLabel.text = @"无";
        }
        for (NSDictionary *dic in [dict objectForKey:@"GraphsList"]) {
            ImageSubject *imageSubject = [[ImageSubject alloc] init];
            imageSubject.ImageHeight = [dic objectForKey:@"ImageHeight"];
            imageSubject.StepGraph = [dic objectForKey:@"StepGraph"];
            [self.imageArr addObject:imageSubject];
            [imageSubject release];
        }
        [previous release];
       
        self.imageView1.frame = CGRectMake(0, self.bigImageView.frame.origin.y + self.bigImageView.frame.size.height + 5, 30, 30);
        self.feedLabel.frame = CGRectMake(self.view.frame.size.width / 2 - self.view.frame.size.width / 2.2, self.bigImageView.frame.origin.y + self.bigImageView.frame.size.height + self.imageView1.frame.size.height + 5, self.view.frame.size.width / 1.1, self.view.frame.size.height / 3);
        self.feedLabel.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.1];
        [self.feedLabel sizeToFit];
        self.imageView2.frame = CGRectMake(0, self.feedLabel.frame.size.height + self.feedLabel.frame.origin.y + 5, 30, 30);
        self.flavLabel.frame = CGRectMake(self.view.frame.size.width / 2 - self.view.frame.size.width / 2.2, self.imageView2.frame.origin.y + self.imageView2.frame.size.height, self.view.frame.size.width / 1.1, self.view.frame.size.height / 3);
        self.flavLabel.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.1];
        [self.flavLabel sizeToFit];
        self.imageView3.frame = CGRectMake(0, self.flavLabel.frame.size.height + self.flavLabel.frame.origin.y + 5, 30, 30);
        self.workLabel.frame = CGRectMake(self.view.frame.size.width / 2 - self.view.frame.size.width / 2.2, self.imageView3.frame.origin.y + self.imageView3.frame.size.height, self.view.frame.size.width / 1.1, self.view.frame.size.height / 3);
        self.workLabel.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.1];
        [self.workLabel sizeToFit];
        self.imageView4.frame = CGRectMake(0, self.workLabel.frame.size.height + self.workLabel.frame.origin.y + 5, 30, 30);
        self.superWordLabel.frame = CGRectMake(self.view.frame.size.width / 2 - self.view.frame.size.width / 2.2, self.imageView4.frame.origin.y + self.imageView4.frame.size.height, self.view.frame.size.width / 1.1, self.view.frame.size.height / 3);
        self.superWordLabel.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.1];
        [self.superWordLabel sizeToFit];
        self.scrollView.contentSize = CGSizeMake(0, self.imageView1.frame.size.height + self.imageView2.frame.size.height + self.imageView3.frame.size.height + self.imageView4.frame.size.height + self.bigImageView.frame.size.height + self.feedLabel.frame.size.height + self.flavLabel.frame.size.height + self.workLabel.frame.size.height + self.superWordLabel.frame.size.height + 20);
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(30, self.bigImageView.frame.origin.y + self.bigImageView.frame.size.height + 5, self.view.frame.size.width - 30, 30)];
        label1.text = @"食材";
        [self.scrollView addSubview:label1];
        label1.textColor = [UIColor cyanColor];
        label1.textAlignment = NSTextAlignmentLeft;
        [label1 release];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(30, self.feedLabel.frame.size.height + self.feedLabel.frame.origin.y + 5, self.view.frame.size.width - 30, 30)];
        label2.text = @"调料";
    
        label2.textColor = [UIColor cyanColor];
        label2.textAlignment = NSTextAlignmentLeft;
        [self.scrollView addSubview:label2];
        [label2 release];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(30, self.flavLabel.frame.size.height + self.flavLabel.frame.origin.y + 5, self.view.frame.size.width - 30, 30)];
        label3.text = @"做法";
        label3.textColor = [UIColor cyanColor];
        label3.textAlignment = NSTextAlignmentLeft;
        [self.scrollView addSubview:label3];
        [label3 release];
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(30, self.workLabel.frame.size.height + self.workLabel.frame.origin.y + 5, self.view.frame.size.width - 30, 30)];
        label4.text = @"小提示";
        label4.textColor = [UIColor cyanColor];
        label4.textAlignment = NSTextAlignmentLeft;
        [self.scrollView addSubview:label4];
        [label4 release];

//        for (NSInteger i = 0; i < self.imageArr.count; i++) {
//            ImageSubject *imageSubject = [self.imageArr objectAtIndex:i];
//            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.scrollView.contentSize.height - 40, self.view.frame.size.width - 20, (self.view.frame.size.width - 20) *imageSubject.ImageHeight.floatValue / 280)];
//            [imageView sd_setImageWithURL:imageSubject.StepGraph placeholderImage:[UIImage imageNamed:@"location1.png"]];
//            self.scrollView.contentSize = CGSizeMake(0, self.scrollView.contentSize.height + 40 * i + imageView.frame.size.height + 10);
//            [self.scrollView addSubview:imageView];
//            [imageView release];
//        }
//        self.scrollView.contentSize = CGSizeMake(0, self.scrollView.contentSize.height - 40 *self.imageArr.count);
//         }];
        for (NSInteger i = 0; i < self.imageArr.count; i++) {
            ImageSubject *imageSubject = [self.imageArr objectAtIndex:i];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.scrollView.contentSize.height, self.view.frame.size.width - 20, (self.view.frame.size.width - 20) *imageSubject.ImageHeight.floatValue / 280)];
            [imageView sd_setImageWithURL:imageSubject.StepGraph placeholderImage:[UIImage imageNamed:@"location1.png"]];
            self.scrollView.contentSize = CGSizeMake(0, self.scrollView.contentSize.height + imageView.frame.size.height);
            [self.scrollView addSubview:imageView];
            [imageView release];
        }
        self.scrollView.contentSize = CGSizeMake(0, self.scrollView.contentSize.height + 10);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollView.contentOffset.y > 0 && self.tabBarController.tabBar.frame.origin.y <= self.view.frame.size.height)  {
        [UIView animateWithDuration:1 animations:^{
            for (NSInteger i = 1; i < 6; i++) {
                self.tabBarController.tabBar.frame = CGRectMake(0, self.view.frame.size.height - 49 + 9.8 * i , self.view.frame.size.width, 49);
            }
        }];
    }
        if (self.offY > self.scrollView.contentOffset.y ) {
        [UIView animateWithDuration:1 animations:^{
            for (NSInteger i = 1; i < 6; i++) {
                self.tabBarController.tabBar.frame = CGRectMake(0, self.view.frame.size.height - 9.8 * i , self.view.frame.size.width, 49);
            }
        }];
    }
    if ((self.scrollView.contentOffset.y - (self.scrollView.contentSize.height - self.view.frame.size.height + 64) < 10) && (self.scrollView.contentOffset.y - (self.scrollView.contentSize.height - self.view.frame.size.height + 64) > -10) && self.tabBarController.tabBar.frame.origin.y <= self.view.frame.size.height) {
        [UIView animateWithDuration:1 animations:^{
            for (NSInteger i = 1; i < 6; i++) {
                self.tabBarController.tabBar.frame = CGRectMake(0, self.view.frame.size.height - 49 + 9.8 * i , self.view.frame.size.width, 49);
            }
        }];
    }
    self.offY = self.scrollView.contentOffset.y;
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
