//
//  MySubjectTableViewCell.m
//  TianTianFood
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "MySubjectTableViewCell.h"

@implementation MySubjectTableViewCell
- (void)dealloc
{
    [_subject release];
    [_subjectHot release];
    [_bigImageView release];
    [_wordLabel release];
    [super dealloc];
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bigImageView = [[UIImageView alloc] init];
        self.bigImageView.layer.cornerRadius = 10;
        self.bigImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.bigImageView];
        self.bigImageView.backgroundColor = [UIColor yellowColor];
        [_bigImageView release];
        
        self.wordLabel = [[UILabel alloc] init];
        self.wordLabel.text = @"请稍等...";
//        self.wordLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        self.wordLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        self.wordLabel.textColor = [UIColor whiteColor];
        [self.bigImageView addSubview:self.wordLabel];
        [_wordLabel release];
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.bigImageView.frame = CGRectMake(10 , 0, self.contentView.frame.size.width - 20, self.contentView.frame.size.height / 1.1);
    self.wordLabel.frame = CGRectMake(0, self.contentView.frame.size.height * 3 / 4, self.contentView.frame.size.width - 20, self.contentView.frame.size.height / 1.1 - self.contentView.frame.size.height * 3 / 4);
}

- (void) setSubjectHot:(SubjectHot *)subjectHot
{
    if (_subjectHot != subjectHot) {
        [_subjectHot release];
        _subjectHot = [subjectHot retain];
    }
    [self.bigImageView sd_setImageWithURL:self.subjectHot.thumb placeholderImage:[UIImage imageNamed:@"location.png"]];
//    self.wordLabel.text = self.subjectHot.title;
    
}



















- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
