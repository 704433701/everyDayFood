//
//  DataBaseHandler.h
//  TianTianFood
//
//  Created by 张健华 on 15-3-25.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Home.h"

@interface DataBaseHandler : NSObject
{
    // 数据库文件指针, 可以通过它读取本地的数据库文件
    sqlite3 *dbPoint;
}

+ (DataBaseHandler *)shareInstance; // 单例

- (void)opernDB;

- (void)closeDB;

- (void)createTable:(NSString *)tableName;

- (void)insert:(NSString *)tableName Menu:(Home *)menu;

- (void)update:(NSString *)tableName Menu:(Home *)menu time:(NSString *)time;

- (void)delete:(NSString *)tableName Menu:(Home *)menu;

- (NSMutableArray *)selectAllMenu:(NSString *)tableName;
@end
