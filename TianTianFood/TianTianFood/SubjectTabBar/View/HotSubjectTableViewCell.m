//
//  HotSubjectTableViewCell.m
//  TianTianFood
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "HotSubjectTableViewCell.h"

@implementation HotSubjectTableViewCell
- (void)dealloc
{
    [_tongue release];
    [_bigImageView release];
    [_label1 release];
    [_label2 release];
    [_label3 release];
    [_label4 release];
    [super dealloc];
    
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bigImageView = [[UIImageView alloc] init];
//        self.bigImageView.backgroundColor = [UIColor redColor];
        self.bigImageView.layer.cornerRadius = 5;
        self.bigImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.bigImageView];
        [_bigImageView release];
        
        self.label1 = [[UILabel alloc] init];
//        self.label1.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:self.label1];
        [_label1 release];
        
        self.label2 = [[UILabel alloc] init];
//        self.label2.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:self.label2];
        [_label2 release];
        
        self.label3 = [[UILabel alloc] init];
//        self.label3.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.label3];
        [_label3 release];
        
        self.label4 = [[UILabel alloc] init];
//        self.label4.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:self.label4];
        [_label4 release];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bigImageView.frame = CGRectMake(0, self.contentView.frame.size.height / 2 - self.contentView.frame.size.height / 2.6, self.contentView.frame.size.width / 3.5, self.contentView.frame.size.height / 1.3);
    self.label1.frame = CGRectMake(self.bigImageView.frame.size.width + 12, 6, self.contentView.frame.size.width - self.bigImageView.frame.size.width, self.contentView.frame.size.height / 4);
    self.label1.textColor = [UIColor colorWithRed:0 green:0.8 blue:0.3 alpha:0.8];
    self.label2.frame = CGRectMake(self.bigImageView.frame.size.width + 12, self.label1.frame.size.height , self.contentView.frame.size.width - self.bigImageView.frame.size.width, self.contentView.frame.size.height / 4);
    self.label3.frame = CGRectMake(self.bigImageView.frame.size.width + 12, self.label2.frame.size.height + self.label2.frame.origin.y - 3, self.contentView.frame.size.width - self.bigImageView.frame.size.width + 7, self.contentView.frame.size.height / 4);
    self.label4.frame = CGRectMake(self.bigImageView.frame.size.width + 12, self.label3.frame.size.height + self.label3.frame.origin.y - 6, self.contentView.frame.size.width - self.bigImageView.frame.size.width + 7, self.contentView.frame.size.height / 4);
    
}

- (void)setTongue:(TongueSubject *)tongue
{
    if (_tongue != tongue) {
        [_tongue release];
        _tongue = [tongue retain];
    }
    [self.bigImageView sd_setImageWithURL:self.tongue.thumb_2 placeholderImage:[UIImage imageNamed:@"location1.png"]];
    self.label1.text = self.tongue.title;
    self.label1.font = [UIFont systemFontOfSize:17];
    self.label2.text = self.tongue.category;
    self.label2.font = [UIFont systemFontOfSize:12];
    self.label3.text = self.tongue.age;
    self.label3.font = [UIFont systemFontOfSize:12];
    self.label4.text = self.tongue.effect;
    self.label4.font = [UIFont systemFontOfSize:12];
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
