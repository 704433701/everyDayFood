//
//  CustomFavoriteTableViewCell.m
//  TianTianFood
//
//  Created by 张健华 on 15-3-28.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "CustomFavoriteTableViewCell.h"
#import "TimerViewController.h"

@implementation CustomFavoriteTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)dealloc
{
    [_timeLabel release];
    [_button release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor whiteColor];
        [self.image addSubview:_timeLabel];
        [_timeLabel release];
        
        self.button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button setTitle:@"制作时间" forState:UIControlStateNormal];
        _button.backgroundColor = [UIColor colorWithRed:254.0 / 256.0 green:84.0 / 256.0  blue:154.0 / 256.0 alpha:0.7];
        _button.tintColor = [UIColor whiteColor];
        _button.layer.cornerRadius = 10;
        [_button addTarget:self action:@selector(timerAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button];
    }
    return self;
}

- (void)timerAction:(UIButton *)button
{
    TimerViewController *timeVC = [[TimerViewController alloc] init];
    timeVC.home = self.caipu;
    timeVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self.target presentModalViewController:timeVC animated:YES];
    [timeVC release];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (![self.caipu.time isEqualToString:@"null"]) {
        _timeLabel.backgroundColor = self.bgView.backgroundColor;
        self.timeLabel.frame = CGRectMake(0, 0, self.image.frame.size.width, 30);
        NSString *timeStr = [NSString stringWithFormat:@"   %@", self.caipu.time];
        _timeLabel.text = timeStr;
    } else {
        _timeLabel.frame = CGRectMake(0, 0, 0, 0);
    }
    self.bgView.frame = CGRectMake(0, self.image.frame.size.height - 30, self.image.frame.size.width, 30);
    self.titleLabel.frame = CGRectMake(15, 0, self.image.frame.size.width - 30, 30);
    self.button.frame = CGRectMake(self.bgView.frame.size.width - 90, self.image.frame.size.height - 25, 100, 30);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
