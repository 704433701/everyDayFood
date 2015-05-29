//
//  NetHandler.h
//  TianTianFood
//
//  Created by 张健华 on 15-3-28.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetHandler : NSObject

+ (void)getDataWithUrl:(NSString *)str completion:(void(^)(NSData *data))block;
@end
