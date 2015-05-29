//
//  NetHandler.m
//  TianTianFood
//
//  Created by 张健华 on 15-3-28.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "NetHandler.h"

@implementation NetHandler


+ (void)getDataWithUrl:(NSString *)str completion:(void (^)(NSData *))block
{
    // 获取wifi的菊花圈
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *path = [NSString stringWithFormat:@"%@/Caches/com.hackemist.SDWebImageCache.default/%ld.aa", docPath, [str hash]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
        // 处理数据
        // 确定地址 
        
        BOOL result = [NSKeyedArchiver archiveRootObject:data toFile:path];
        NSLog(@"存储成功: %d", result);
        block(data);
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 没有网络/请求失败 就从本地读取最近的一次成功数据
        NSData *pickData = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (pickData != nil) {
            // 确保有数据才返回.
            block(pickData); 
        } else {
            NSData *data = [NSData data];
            block(data);
        }
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}
@end
