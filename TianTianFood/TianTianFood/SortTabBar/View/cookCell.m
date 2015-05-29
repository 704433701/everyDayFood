//
//  cookCell.m
//  TianTianFood
//
//  Created by dlios on 15/3/24.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "cookCell.h"

@implementation cookCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageView1 = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageView1];
        [_imageView1 release];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        [_titleLabel release];
        
        self.typeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.typeLabel];
        [_typeLabel release];
        
        self.tasteLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.tasteLabel];
        [_tasteLabel release];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    self.imageView1.frame = CGRectMake(5, 5, width / 3 + 15, height - 10);
    self.titleLabel.frame = CGRectMake(width / 3 + 30, 10, width / 3 + 10, height / 4);
    self.typeLabel.frame = CGRectMake(width / 3 + 30, height / 4 + 20, width / 2, height / 4);
    self.tasteLabel.frame = CGRectMake(width / 3 + 30, height / 2 + 20, width / 2 + 10, height / 4);
    
    [self.imageView1 sd_setImageWithURL:self.foodList.thumb_2 placeholderImage:[UIImage imageNamed:@"location.png"]];
    self.imageView1.layer.cornerRadius = 8;
    self.imageView1.clipsToBounds = YES;
    self.titleLabel.text = self.foodList.title;
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    if (self.foodList.effect.length == 0) {
        self.typeLabel.text = self.foodList.yuanliao;
    } else {
        self.typeLabel.text = self.foodList.effect;
    }
    self.typeLabel.font = [UIFont systemFontOfSize:13];
    self.tasteLabel.text = self.foodList.yingyang;
    self.tasteLabel.font = [UIFont systemFontOfSize:13];
    
}

- (void)dealloc
{
    [_foodList release];
    [_tasteLabel release];
    [_titleLabel release];
    [_imageView1 release];
    [_typeLabel release];
    [super dealloc];
}



- (void)awakeFromNib {
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
