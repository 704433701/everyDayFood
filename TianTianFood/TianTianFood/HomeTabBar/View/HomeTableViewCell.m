//
//  HomeTableViewCell.m
//  TianTianFood
//
//  Created by 张健华 on 15-3-23.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "SDImageCache.h"

@implementation HomeTableViewCell

- (void)dealloc
{
    [_image release];
    [_bgView release];
    [_titleLabel release];
    [_yongliaoLabel release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.image = [[UIImageView alloc] init];
        self.image.clipsToBounds = YES;
        [self.contentView addSubview:_image];
        [_image release];
        
        self.bgView = [[UIImageView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.3];
        [self.image addSubview:_bgView];
        [_bgView release];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor whiteColor];
        [_titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        [_bgView addSubview:_titleLabel];
        [_titleLabel release];
        
        self.yongliaoLabel = [[UILabel alloc] init];
        self.yongliaoLabel.font = [UIFont systemFontOfSize:15];
        self.yongliaoLabel.textColor = [UIColor whiteColor];
        [_bgView addSubview:_yongliaoLabel];
        [_yongliaoLabel release];
        
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.image.frame = CGRectMake(10, 5, width - 20, height - 10);
    self.image.layer.cornerRadius = 10;
    [self.image sd_setImageWithURL:self.caipu.thumb_2 placeholderImage:[UIImage imageNamed:@"location.png"]];
    [[SDImageCache sharedImageCache] storeImage:self.image.image forKey:@"aa" toDisk:YES];
    self.bgView.frame = CGRectMake(0, _image.frame.size.height - 50, _image.frame.size.width, 50);
    self.titleLabel.frame = CGRectMake(15, 0, _image.frame.size.width - 30, 25);
    _titleLabel.text = self.caipu.title;
    self.yongliaoLabel.frame = CGRectMake(15, 25, _image.frame.size.width - 30, 25);
    _yongliaoLabel.text = self.caipu.yingyang;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
