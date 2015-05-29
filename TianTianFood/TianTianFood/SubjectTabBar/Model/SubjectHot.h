//
//  SubjectHot.h
//  TianTianFood
//
//  Created by dlios on 15-3-24.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubjectHot : NSObject
@property(nonatomic, retain) NSString *ID;
@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *thumb;
//@property(nonatomic, retain) NSString *category;
//@property(nonatomic, retain) NSString *age;
//@property(nonatomic, retain) NSString *effect;
- (instancetype) initWithDictionary:(NSDictionary *)dic;

@end
