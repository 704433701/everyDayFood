//
//  TimerViewController.m
//  TianTianFood
//
//  Created by 张健华 on 15-4-6.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()

@property (nonatomic, retain) UILabel *label;
@end

@implementation TimerViewController

- (void)dealloc
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
    
    [_label release];
    [_home release];
    [_datePicker release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 250, self.view.frame.size.width, 50)];
    _label.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_label];
    [_label release];
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 200, self.view.frame.size.width, 200)];
    _datePicker.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_datePicker];
    [_datePicker release];
    
    UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [enterButton setTitle:@"保存" forState:UIControlStateNormal];
    enterButton.backgroundColor = [UIColor whiteColor];
    enterButton.frame = CGRectMake(self.view.frame.size.width * 3 / 4, self.view.frame.size.height - 50 - 200, self.view.frame.size.width / 4, 50);
    [enterButton addTarget:self action:@selector(enterAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enterButton];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelButton setTitle:@"不做了" forState:UIControlStateNormal];
    cancelButton.backgroundColor = [UIColor whiteColor];
    cancelButton.frame = CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height - 50 - 200, self.view.frame.size.width / 4, 50);
    [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)cancelAction:(UIButton *)button
{
    DataBaseHandler *db = [DataBaseHandler shareInstance];
    [db update:@"menu" Menu:self.home time:@"null"];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"刷新页面" object:nil userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)enterAction:(UIButton *)button
{
    DataBaseHandler *db = [DataBaseHandler shareInstance];
    NSDate *dateNew = [NSDate dateWithTimeInterval:28800 sinceDate:_datePicker.date];
    NSString *time = [NSString stringWithFormat:@"%@", dateNew];
    time = [time substringToIndex:19];
    [db update:@"menu" Menu:self.home time:time];
    [self addLocalNotification];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"刷新页面" object:nil userInfo:nil];
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)addLocalNotification
{
    // 创建一个本地推送
    UILocalNotification *notification = [[[UILocalNotification alloc] init] autorelease];
    // 获得 UIApplication
    UIApplication *app = [UIApplication sharedApplication];
    //获取本地推送数组
    NSArray *localArray = [app scheduledLocalNotifications];
    if (localArray) {
        for (UILocalNotification *noti in localArray) {
            NSDictionary *dict = noti.userInfo;
            if (dict) {
                if ([[dict objectForKey:@"ID"] isEqualToString:self.home.ID]) {
                    [app cancelLocalNotification:noti];
                    break;
                }
            }
        }
    }
     NSLog(@"%@", localArray);
    if (notification != nil) {
        // 设置推送时间
        notification.fireDate = _datePicker.date;
        // 设置时区
        notification.timeZone = [NSTimeZone defaultTimeZone];
        // 设置重复间隔
        notification.repeatInterval = 0;
        // 推送声音
        notification.soundName = UILocalNotificationDefaultSoundName;
        // 推送内容
        NSString *bodyStr = [NSString stringWithFormat:@"快来和我一起做%@吧😄", self.home.title];
        notification.alertBody = bodyStr;
        //显示在icon上的红色圈中的数子
        notification.applicationIconBadgeNumber = 1;
        
        //设置userinfo 方便在之后需要撤销的时候使用
        NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:self.home.ID,@"ID", self.home.title, @"title", nil];
        notification.userInfo = info;
        //添加推送到UIApplication
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:notification];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    _label.text = [NSString stringWithFormat:@"  %@:", self.home.title];
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
