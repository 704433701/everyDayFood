//
//  TongueSubject.h
//  TianTianFood
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TongueSubject : NSObject
@property(nonatomic, retain) NSString *ID;
@property(nonatomic, retain) NSString *title;
//@property(nonatomic, retain) NSString *thumb;
@property(nonatomic, retain) NSString *thumb_2;
//@property(nonatomic, retain) NSMutableArray *tlist;
@property(nonatomic, retain) NSString *category;
@property(nonatomic, retain) NSString *age;
@property(nonatomic ,retain) NSString *effect;

- (instancetype) initWithDictionary:(NSDictionary *)dic;

@end
