//
//  WelcomePage.m
//  TianTianFood
//
//  Created by 张健华 on 15-4-7.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "WelcomePage.h"

@implementation WelcomePage

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.firstApp = [[UIScrollView alloc] initWithFrame:frame];
        _firstApp.contentSize = CGSizeMake(self.frame.size.width * 4, self.frame.size.height);
        _firstApp.pagingEnabled = YES;
        _firstApp.delegate = self;
        _firstApp.backgroundColor = [UIColor whiteColor];
        _firstApp.bounces = NO;
        _firstApp.showsHorizontalScrollIndicator = NO;
        for (NSInteger i = 0; i < 4; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height)];
            NSString *App = [NSString stringWithFormat:@"App%ld", i + 1];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.image = [UIImage imageNamed:App];
            [_firstApp addSubview:imageView];
            [imageView release];
        }
        [self addSubview:_firstApp];
        [_firstApp release];
        
        self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height * 4 / 5, frame.size.width, 50)];
        self.page.numberOfPages = 4;
        self.page.currentPageIndicatorTintColor = [UIColor redColor];
        self.page.pageIndicatorTintColor = BarColor;
        [self.page addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_page];
        [_page release];
        
        UIButton *jumpButton = [UIButton buttonWithType:UIButtonTypeSystem];
        jumpButton.frame = CGRectMake(frame.size.width - 100, 30, 100, 50);
        jumpButton.layer.cornerRadius = 15;
        [jumpButton setTintColor:BarColor];
        [jumpButton setTitle:@"跳过" forState:UIControlStateNormal];
        [jumpButton addTarget:self action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];
        [self.firstApp addSubview:jumpButton];
        
        UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeSystem];
        enterButton.frame = CGRectMake(frame.size.width * 3 + frame.size.width  / 4, _page.frame.origin.y + 50, frame.size.width * 2 / 4, 40);
        enterButton.layer.cornerRadius = 10;
        enterButton.layer.borderWidth = 1;
        enterButton.layer.borderColor = BarColor.CGColor;
        [enterButton setTintColor:BarColor];
        [enterButton setTitle:@"立即体验" forState:UIControlStateNormal];
        [enterButton addTarget:self action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];
        [self.firstApp addSubview:enterButton];
    }
    return self;
}

- (void)removeFromSuperview
{
    [UIView animateWithDuration:0.6 animations:^{
        self.frame = CGRectMake( - self.frame.size.width, 0, 0, 0);
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}
- (void)dealloc
{
    [_firstApp release];
    [_page release];
    [super dealloc];
}

- (void)pageAction:(UIPageControl *)pagecontrol
{
    //self.scrollView.contentOffset = CGPointMake(335 * pagecontrol.currentPage, 0);
    
    //动画效果
    [self.firstApp setContentOffset:CGPointMake(self.frame.size.width * pagecontrol.currentPage, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _page.currentPage = scrollView.contentOffset.x / self.firstApp.frame.size.width;
}

@end
