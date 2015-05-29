//
//  Subject.h
//  TianTianFood
//
//  Created by 张健华 on 15-3-21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Subject : NSObject
@property(nonatomic, retain) NSString *flag;
@property(nonatomic, retain) NSString *ID;
@property(nonatomic, retain) NSString *Guid;
@property(nonatomic, retain) NSString *RecipeGuid;
@property(nonatomic, retain) NSString *UserGuid;
@property(nonatomic, retain) NSString *NickName;
@property(nonatomic, retain) NSString *UserImageUrl;
@property(nonatomic, retain) NSString *ImageUrl;
@property(nonatomic, retain) NSString *DateCreated;
@property(nonatomic, retain) NSString *RecipeName;
@property(nonatomic, retain) NSString *LastUpdTime;
- (instancetype) initWithDictionary:(NSDictionary *)dic;

@end
