//
//  TipViewController.m
//  TianTianFood
//
//  Created by dlios on 15/3/27.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController () <UIWebViewDelegate>

@property (nonatomic, retain) UIWebView *webXiaoView;



@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webXiaoView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webXiaoView];
    self.webXiaoView.scrollView.bounces = NO;
    [_webXiaoView release];
    [self requestData];
    
}

- (void)requestData
{
    NSString *str = [NSString stringWithFormat:@"http://ibaby.ipadown.com/api/food/food.tips.detail.php?id=%@", self.ID];
    NSLog(@"%@", str);
    [NetHandler getDataWithUrl:str completion:^(NSData *data) {
        NSString *transStr =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        transStr = [transStr stringByReplacingOccurrencesOfString:@"<div id=\"body_section\" style='padding:10px 18px;'>" withString:@"<div style='background:#FFEC8B; color:#CD661D; padding:10px 18px;'>"];
        [self.webXiaoView loadHTMLString:transStr baseURL:nil];
    }];
}

- (void)dealloc
{
    [_webXiaoView release];
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
