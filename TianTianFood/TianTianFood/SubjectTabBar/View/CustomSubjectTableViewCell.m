//
//  CustomSubjectTableViewCell.m
//  TianTianFood
//
//  Created by dlios on 15-3-31.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "CustomSubjectTableViewCell.h"

@interface CustomSubjectTableViewCell ()
@end



@implementation CustomSubjectTableViewCell


- (void)dealloc
{
    [_timeButton release];
    [_home release];
    [_bigImageView release];
    [_label1 release];
    [_label2 release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bigImageView = [[UIImageView alloc] init];
        //        self.bigImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.bigImageView];
        [_bigImageView release];
        
        self.label1 = [[UILabel alloc] init];
     //           self.label1.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:self.label1];
        [_label1 release];
        
        self.label2 = [[UILabel alloc] init];
     //           self.label2.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:self.label2];
        [_label2 release];
        
        self.timeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.timeButton setTitle:@"定时" forState:UIControlStateNormal];
        [self.contentView addSubview:self.timeButton];
       
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bigImageView.frame = CGRectMake(0, self.contentView.frame.size.height / 2 - self.contentView.frame.size.height / 2.6, self.contentView.frame.size.width / 3.5, self.contentView.frame.size.height / 1.3);
    self.label1.frame = CGRectMake(self.bigImageView.frame.size.width + 12, self.bigImageView.frame.origin.y, self.contentView.frame.size.width - self.bigImageView.frame.size.width, self.contentView.frame.size.height / 4);
    self.label1.textColor = [UIColor colorWithRed:0 green:0.8 blue:0.3 alpha:0.8];
    self.label2.frame = CGRectMake(self.bigImageView.frame.size.width + 12, self.label1.frame.size.height + self.label1.frame.origin.y , self.contentView.frame.size.width - self.bigImageView.frame.size.width, self.contentView.frame.size.height / 4);
    self.timeButton.frame = CGRectMake(self.bigImageView.frame.size.width + 12, self.label2.frame.size.height + self.label2.frame.origin.y, self.contentView.frame.size.width - self.bigImageView.frame.size.width + 7, self.contentView.frame.size.height / 4);
//    self.bigImageView.backgroundColor = [UIColor yellowColor];
//    self.label1.backgroundColor = [UIColor cyanColor];
//    self.label2.backgroundColor = [UIColor orangeColor];
    self.timeButton.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.5 alpha:0.3];
    
}

- (void)setHome:(Home *)home
{
    if (_home != home) {
        [_home release];
        _home = [home retain];
    }
    [self.bigImageView sd_setImageWithURL:self.home.thumb_2 placeholderImage:[UIImage imageNamed:@"location.png"]];
    [[SDImageCache sharedImageCache] storeImage:self.bigImageView.image forKey:@"aa" toDisk:YES];
    self.label1.text = self.home.title;
    self.label2.text = self.home.yuanliao;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
