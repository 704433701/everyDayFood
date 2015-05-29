//
//  PreviousSubject.h
//  TianTianFood
//
//  Created by dlios on 15-3-25.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageSubject.h"
@interface PreviousSubject : NSObject
@property(nonatomic, retain) NSString *ID;
@property(nonatomic, retain) NSString *RecipeGuid;
@property(nonatomic, retain) NSString *RecipeName;
@property(nonatomic, retain) NSString *RecipeContent;
@property(nonatomic, retain) NSString *RecipeNotes;
@property(nonatomic, retain) NSString *MainImageUrl;
@property(nonatomic, retain) NSString *Ingredients;
@property(nonatomic, retain) NSString *Seasoning;
@property(nonatomic, retain) ImageSubject *imageSubject;
//@property(nonatomic, retain) NSMutableArray *GraphsList;
//@property(nonatomic, retain) NSString *ImageHeight;
- (instancetype) initWithDictionary:(NSDictionary *)dic;
@end
