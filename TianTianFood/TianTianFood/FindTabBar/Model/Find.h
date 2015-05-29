//
//  Find.h
//  TianTianFood
//
//  Created by 张健华 on 15-3-21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Find : NSObject

@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSString *thumb_2;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *yingyang;

- (instancetype)initWithDictionary:(NSDictionary *)dic;


@end
