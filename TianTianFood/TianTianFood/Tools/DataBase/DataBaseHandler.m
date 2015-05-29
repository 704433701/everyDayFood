//
//  DataBaseHandler.m
//  TianTianFood
//
//  Created by 张健华 on 15-3-25.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "DataBaseHandler.h"

@implementation DataBaseHandler

// 单例
+ (DataBaseHandler *)shareInstance
{
    static DataBaseHandler *dbHandler = nil;
    if (dbHandler == nil) {
        dbHandler = [[DataBaseHandler alloc] init];
    }
    return dbHandler;
}

- (void)judgeResult:(int)result type:(NSString *)type
{
    // 判断结果的方法
    if (result == SQLITE_OK) {
        NSLog(@"%@成功", type);
    } else {
        NSLog(@"%@失败, 失败编号:%d", type, result);
    }
}

- (void)opernDB
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [docPath stringByAppendingPathComponent:@"shouCang.db"];
    int result = sqlite3_open([dbPath UTF8String], &dbPoint);
    [self judgeResult:result type:@"打开数据库"];
}

- (void)closeDB
{
    int result = sqlite3_close(dbPoint);
    [self judgeResult:result type:@"关闭数据库"];
}

- (void)createTable:(NSString *)tableName
{
    NSString *sqlStr = [NSString stringWithFormat:@"create table %@ (ID text primary key, title text, thumb_2 text, time date)", tableName];
    int result = sqlite3_exec(dbPoint, [sqlStr UTF8String], NULL, NULL, NULL);
    [self judgeResult:result type:@"创建收藏表"];
}

- (void)insert:(NSString *)tableName Menu:(Home *)menu
{
    NSString *sqlStr = [NSString stringWithFormat:@"insert into %@ values ('%@', '%@', '%@', 'null')", tableName, menu.ID, menu.title, menu.thumb_2];
    
    int result = sqlite3_exec(dbPoint, [sqlStr UTF8String], NULL, NULL, NULL);
    [self judgeResult:result type:@"添加Menu"];
}

- (void)update:(NSString *)tableName Menu:(Home *)menu time:(NSString *)time
{
    NSString *sqlStr = [NSString stringWithFormat:@"UPDATE %@ SET time = '%@' WHERE ID = '%@'", tableName, time, menu.ID];
    int result = sqlite3_exec(dbPoint, [sqlStr UTF8String], NULL, NULL, NULL);
    [self judgeResult:result type:@"更新Menu"];
}

- (void)delete:(NSString *)tableName Menu:(Home *)menu
{
    NSString *sqlStr = [NSString stringWithFormat:@"delete  from %@ where ID = '%@'", tableName, menu.ID];
    if (menu == nil) {
        sqlStr = [NSString stringWithFormat:@"delete  from %@", tableName];
    }
    
    int result = sqlite3_exec(dbPoint, [sqlStr UTF8String], NULL, NULL, NULL);
    [self judgeResult:result type:@"删除Menu"];
}

- (NSMutableArray *)selectAllMenu:(NSString *)tableName
{
    NSString *sqlStr = [NSString stringWithFormat:@"select * from %@ ORDER BY time", tableName];
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare(dbPoint, [sqlStr UTF8String], -1, &stmt, NULL);
    [self judgeResult:result type:@"查询Menu"];
    NSMutableArray *menuArr = [NSMutableArray array];
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            Home *menu = [[Home alloc] init];
            const unsigned char *idChar = sqlite3_column_text(stmt, 0);
            menu.ID = [NSString stringWithUTF8String:(const char *)idChar];
            const unsigned char *titleChar = sqlite3_column_text(stmt, 1);
            menu.title = [NSString stringWithUTF8String:(const char *)titleChar];
            const unsigned char *thumb_2Char = sqlite3_column_text(stmt, 2);
            menu.thumb_2 = [NSString stringWithUTF8String:(const char *)thumb_2Char];
            const unsigned char *timeChar = sqlite3_column_text(stmt, 3);
            menu.time = [NSString stringWithUTF8String:(const char *)timeChar];
            [menuArr addObject:menu];
            [menu release];
        }
    }
    sqlite3_finalize(stmt);
    return menuArr;
}
@end
