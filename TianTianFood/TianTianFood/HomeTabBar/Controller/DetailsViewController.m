//
//  DetailsViewController.m
//  TianTianFood
//
//  Created by 张健华 on 15-3-23.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController () <UIWebViewDelegate>

@property (nonatomic, retain) UIWebView *webDetailsView;
@property (nonatomic, retain) NSString *str;
@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic, retain) NSString *transStr;
@property (nonatomic, assign) BOOL flag;

@property (nonatomic, retain) PQFBouncingBalls *bouncingBalls;
@end

@implementation DetailsViewController

- (void)dealloc
{
    [_webDetailsView release];
    [_str release];
    [_bouncingBalls release];
    [_menu release];
    [_url release];
    [_HUD release];
    [_transStr release];
    [super dealloc];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.menu.title;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share.png"] style:UIBarButtonItemStylePlain target:self action:@selector(ShowShareActionSheet:)];
    
    DataBaseHandler *db = [DataBaseHandler shareInstance];
    [db insert:@"browsed" Menu:self.menu];
    
    self.webDetailsView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + 150)];
    self.webDetailsView.delegate = self;
    self.webDetailsView.scrollView.bounces = NO;
    [self.view addSubview:_webDetailsView];
    [_webDetailsView release];
    
    // MB三方
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    [_HUD release];
    
    // PQ三方
    self.bouncingBalls = [[PQFBouncingBalls alloc] initLoaderOnView:self.view];
    _bouncingBalls.loaderColor = [UIColor orangeColor];
    [self.bouncingBalls show];
    [_bouncingBalls release];
    
    
    [self requestData];
}

#pragma mark - aaaaa
- (void)ShowShareActionSheet:(id)sender
{
    //1.定制分享的内容
    NSString *content = [NSString stringWithFormat:@"我做的%@, 味道相当不错, 你也来试试吧!%@", self.menu.title, self.str];
    NSData  *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.menu.thumb_2]];
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [NSString stringWithFormat:@"%@/Caches/com.hackemist.SDWebImageCache.default/6768.jpg", docPath];
    [data writeToFile:path atomically:YES];
    id<ISSContent> publishContent = [ShareSDK content:content defaultContent:nil image:[ShareSDK imageWithPath:path] title:self.menu.title url:self.str description:content mediaType:SSPublishContentMediaTypeNews];
    
    
    [publishContent addQQSpaceUnitWithTitle:content
                                        url:self.str
                                       site:nil
                                    fromUrl:nil
                                    comment:nil
                                    summary:self.menu.yingyang
                                      image:nil
                                       type:INHERIT_VALUE
                                    playUrl:nil
                                       nswb:nil];
    //2.调用分享菜单分享
    [ShareSDK showShareActionSheet:nil shareList:nil content:publishContent statusBarTips:YES authOptions:nil shareOptions:nil result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        //如果分享成功
        if (state == SSResponseStateSuccess) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"天天美食" message:@"分享成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        //如果分享失败
        if (state == SSResponseStateFail) {
            NSString *message = [NSString stringWithFormat:@"分享失败,%@",[error errorDescription]];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"天天美食" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        if (state == SSResponseStateCancel){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"天天美食" message:@"分享取消" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_bouncingBalls remove];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    //判断是否是单击
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        [self changeFavorite];
    }
    return YES;
}

- (void)changeFavorite
{
    DataBaseHandler *db = [DataBaseHandler shareInstance];
    if (_flag) {
        self.transStr = [self.transStr stringByReplacingOccurrencesOfString:@"已收藏" withString:@"+收藏"];
        [db delete:@"menu" Menu:self.menu];
        _HUD.labelText = @"删除收藏";
    } else {
        // 查询
        [db insert:@"menu" Menu:self.menu];
        self.transStr = [self.transStr stringByReplacingOccurrencesOfString:@"+收藏" withString:@"已收藏"];
        _HUD.labelText = @"收藏成功";
    }
    [self.webDetailsView loadHTMLString:self.transStr baseURL:nil];
    _flag = !_flag;
    _HUD.mode = MBProgressHUDModeCustomView;
    _HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hubyes.png"]] autorelease];
    [_HUD showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    }];
}


- (void)requestData
{
    self.str = [NSString stringWithFormat:@"http://ibaby.ipadown.com/api/food/food.show.detail.php?id=%@", self.menu.ID];
    self.url = [NSURL URLWithString:_str];

    self.webDetailsView.scrollView.bounces = NO;
    
    [NetHandler getDataWithUrl:_str completion:^(NSData *data) {
        self.transStr =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        DataBaseHandler *db = [DataBaseHandler shareInstance];
        for (Home *menu in [db selectAllMenu:@"menu"]) {
            if ([self.menu.ID isEqualToString:menu.ID]) {
                self.transStr = [self.transStr stringByReplacingOccurrencesOfString:@"+收藏" withString:@"已收藏"];
                self.flag = !self.flag;
            }
        }
        [self.webDetailsView loadHTMLString:self.transStr baseURL:nil];
        [_HUD hide:YES];
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    DataBaseHandler *db = [DataBaseHandler shareInstance];
    NSArray *arr = [db selectAllMenu:@"browsed"];
    if (arr.count > 10) {
        [db delete:@"browsed" Menu:[arr lastObject]];
    }
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
