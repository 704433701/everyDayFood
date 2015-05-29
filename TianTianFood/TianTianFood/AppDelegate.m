//
//  AppDelegate.m
//  TianTianFood
//
//  Created by 张健华 on 15-3-21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "SortViewController.h"
#import "FindViewController.h"
#import "SubjectViewController.h"
#import "MoreViewController.h"
#import "BaseNavigationController.h"
#import "DetailsViewController.h"
#import "WelcomePage.h"


@interface AppDelegate () <UIAlertViewDelegate>

@property (nonatomic, retain) UITabBarController *tabBarVC;
@property (nonatomic, retain) BaseNavigationController *homeNA;
@property (nonatomic, retain) Home *menu;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [_window release];
    
    
    
    //1.初始化ShareSDK应用,字符串"5559f92aa230"换成http://www.mob.com/后台申请的ShareSDK应用的Appkey
    [ShareSDK registerApp:@"68d82f2c4578"];
    
    //2. 初始化社交平台
    //2.1 代码初始化社交平台的方法
    [self initializePlat];
    
    //TabBar
    self.tabBarVC = [[UITabBarController alloc] init];
    _tabBarVC.tabBar.tintColor = BarColor;
    _tabBarVC.tabBar.barTintColor = HomeColor;
    self.window.rootViewController = _tabBarVC;
    [_tabBarVC release];
    // 首页页面
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    _homeNA = [[BaseNavigationController alloc] initWithRootViewController:homeVC];
    homeVC.title = @"首页";
    homeVC.tabBarItem.image = [UIImage imageNamed:@"homeTabBar.png"];
    
    // 分类页面
    SortViewController *sortVC = [[SortViewController alloc] init];
    BaseNavigationController *sortNA = [[BaseNavigationController alloc] initWithRootViewController:sortVC];
    sortVC.title = @"分类";
    sortVC.tabBarItem.image = [UIImage imageNamed:@"sortTabBar.png"];
    
    // 今日发现
    FindViewController *findVC = [[FindViewController alloc] init];
    BaseNavigationController *findNA = [[BaseNavigationController alloc] initWithRootViewController:findVC];
    findVC.title = @"今日发现";
    findVC.tabBarItem.image = [UIImage imageNamed:@"findTabBar.png"];
    
    // 专题
    SubjectViewController *subjectVC = [[SubjectViewController alloc] init];
    BaseNavigationController *subjectNA = [[BaseNavigationController alloc] initWithRootViewController:subjectVC];
    subjectVC.title = @"专题";
    subjectVC.tabBarItem.image = [UIImage imageNamed:@"subjectTabBar.png"];
    
    // 更多
    MoreViewController *moreVC = [[MoreViewController alloc] init];
    BaseNavigationController *moreNA = [[BaseNavigationController alloc] initWithRootViewController:moreVC];
    moreVC.title = @"更多";
    moreVC.tabBarItem.image = [UIImage imageNamed:@"moreTabBar.png"];    
    _tabBarVC.viewControllers = @[_homeNA, sortNA, findNA, subjectNA, moreNA];
    
    [_homeNA release];
    [homeVC release];
    
    [sortVC release];
    [sortNA release];
    
    [findVC release];
    [findNA release];
    
    [subjectVC release];
    [subjectNA release];
    
    [moreVC release];
    [moreNA release];
    [self reach];
    
    [NSThread sleepForTimeInterval:1];
    NSUserDefaults *userDe = [NSUserDefaults standardUserDefaults];
    if ([userDe boolForKey:@"firstapp"] == NO) {
        WelcomePage *welcome = [[WelcomePage alloc] initWithFrame:self.window.bounds];
        [self.window addSubview:welcome];
        [welcome release];
        [userDe setBool:YES forKey:@"firstapp"];
        [userDe synchronize];
    }
    //如果已经获得发送通知的授权则创建本地通知，否则请求授权(注意：如果不请求授权在设置中是没有对应的通知设置项的，也就是说如果从来没有发送过请求，即使通过设置也打不开消息允许设置)
    if ([[UIApplication sharedApplication] currentUserNotificationSettings].types!=UIUserNotificationTypeNone) {
    }else{
        [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil]];
    }
    
    [self cancelAllNotification];
    
    return YES;
}

- (void)cancelAllNotification
{
    NSUserDefaults *userDe = [NSUserDefaults standardUserDefaults];
    if ([userDe boolForKey:@"notification"] == NO) {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [userDe setBool:YES forKey:@"notification"];
        [userDe synchronize];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification*)notification{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"该做饭啦" message:notification.alertBody delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    self.menu = [[Home alloc] initWithDictionary:notification.userInfo];
    [_menu release];
    // 图标上的数字减1
    application.applicationIconBadgeNumber = 0;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        DetailsViewController *detailsVC = [[DetailsViewController alloc] init];
        detailsVC.menu = self.menu;
        _tabBarVC.selectedIndex = 0;
        [_homeNA pushViewController:detailsVC animated:NO];
        [detailsVC release];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //当程序还在后天运行
    application.applicationIconBadgeNumber = 0;
}

- (void)dealloc
{
    [_menu release];
    [_tabBarVC release];
    [_window release];
    [super dealloc];
}
- (void)reach
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络,不花钱
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"检测网络状态的变化 %ld", status);
        MBProgressHUD *mb = [[MBProgressHUD alloc] initWithView:self.window];
        [self.window addSubview:mb];
        [mb release];
        mb.mode = MBProgressHUDModeCustomView;
        if (status == 0) {
            mb.labelText = @"😭离线状态";
        } else if (status == 1) {
            mb.labelText = @"😢网络状态";
        } else if (status == 2) {
            mb.labelText = @"😊WIFI状态";
        }
        [mb showAnimated:YES whileExecutingBlock:^{
            sleep(1);
        } completionBlock:^{
            [mb removeFromSuperview];
        }];
    }];
}

- (void)initializePlat
{
    /**
     连接新浪微博开放平台应用以使用相关功能，此应用需要引用SinaWeiboConnection.framework
     http://open.weibo.com上注册新浪微博开放平台应用，并将相关信息填写到以下字段
     **/
    [ShareSDK connectSinaWeiboWithAppKey:@"3295510728"
                               appSecret:@"110546060ae7c502c3b147fca84b448d"
                             redirectUri:@"http://www.sharesdk.cn"];
    /**
     连接QQ空间应用以使用相关功能，此应用需要引用QZoneConnection.framework
     http://connect.qq.com/intro/login/上申请加入QQ登录，并将相关信息填写到以下字段
     
     如果需要实现SSO，需要导入TencentOpenAPI.framework,并引入QQApiInterface.h和TencentOAuth.h，将QQApiInterface和TencentOAuth的类型传入接口
     **/
    [ShareSDK connectQZoneWithAppKey:@"1104470987"
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    /**
     连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
     http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
     **/
    [ShareSDK connectWeChatWithAppId:@"wxe453894590c98799"
                           appSecret:@"e5b7d7b3653ba1036ed19db83d66fbd9"
                           wechatCls:[WXApi class]];
    /**
     连接QQ应用以使用相关功能，此应用需要引用QQConnection.framework和QQApi.framework库
     http://mobile.qq.com/api/上注册应用，并将相关信息填写到以下字段
     **/
    [ShareSDK connectQQWithQZoneAppKey:@"1104470987"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
