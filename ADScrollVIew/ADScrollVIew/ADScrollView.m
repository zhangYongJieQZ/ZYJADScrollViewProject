//
//  ADScrollView.m
//  ZYJADScrollView
//
//  Created by 张永杰 on 15/10/25.
//  Copyright © 2015年 张永杰. All rights reserved.
//

#import "ADScrollView.h"
#import "GameModel.h"
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/UIImageView+WebCache.h>

#define SELF_WIDTH      self.frame.size.width
#define SELF_HEIGHT     self.frame.size.height
#define SELF_Y          self.frame.origin.y
#define SELF_X          self.frame.origin.x


static int const PAGE_NUMBER = 3;
static float const SCROLL_TIMER = 2.0f;
@interface ADScrollView ()
{
    NSTimer *_timer;
    UIPageControl *_pageControl;
    NSInteger _currentPage;
    BOOL _isTimeToScroll;
    SDImageCache *_imageCache;
}
@property (strong, nonatomic)   NSArray *imageArray;
@property (strong, nonatomic)   UIImageView *leftImageView;
@property (strong, nonatomic)   UIImageView *centerImageView;
@property (strong, nonatomic)   UIImageView *rightImageView;

@end

@implementation ADScrollView

- (id)initWithFrame:(CGRect)frame andImageArray:(NSArray *)imgAry{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.contentOffset =CGPointMake(SELF_WIDTH, 0);
        self.contentSize = CGSizeMake(SELF_WIDTH * PAGE_NUMBER, SELF_HEIGHT);
        self.pagingEnabled = YES;
        //添加手势，点击跳转
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToWebView)];
        [self addGestureRecognizer:tap];
        
        _imageCache = [SDImageCache sharedImageCache];
        self.imageArray = imgAry;
        [self addADContentImage];
        [self startTimerToScroll];
        _isTimeToScroll = NO;
    }
    return self;
}

- (void)dealloc{
    [_timer invalidate];
    _timer = nil;
}
- (void)addADContentImage{
    _currentPage = 0;
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SELF_WIDTH, SELF_HEIGHT)];
    _centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SELF_WIDTH, 0, SELF_WIDTH, SELF_HEIGHT)];
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SELF_WIDTH * 2, 0, SELF_WIDTH, SELF_HEIGHT)];
    [self addSubview:_leftImageView];
    [self addSubview:_centerImageView];
    [self addSubview:_rightImageView];
    [self setImages];
}

- (void)setImages{
    
    GameModel *leftModel = _imageArray[[self previousPage]];
    GameModel *centerModel = _imageArray[_currentPage];
    GameModel *rightModel = _imageArray[[self nextPage]];
    
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:leftModel.imageAddress] placeholderImage:[UIImage imageNamed:@"1.jpg"] options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:centerModel.imageAddress] placeholderImage:[UIImage imageNamed:@"1.jpg"] options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    
    }];
    
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:rightModel.imageAddress] placeholderImage:[UIImage imageNamed:@"1.jpg"] options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}

- (NSInteger)previousPage{
    if (_currentPage == 0) {
        return _imageArray.count - 1;
    }
    else{
        return _currentPage - 1;
    }
}

- (NSInteger)nextPage{
    if (_currentPage == _imageArray.count - 1) {
        return 0;
    }
    else{
        return _currentPage + 1;
    }
}

- (void)createPageControllOnView:(UIView *)superView{
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.numberOfPages = _imageArray.count;
    _pageControl.frame = CGRectMake( SELF_WIDTH - 20 * _pageControl.numberOfPages, SELF_Y + SELF_HEIGHT - 20, 20 * _pageControl.numberOfPages, 20);
    _pageControl.currentPage = 0;
    _pageControl.enabled = NO;
    [superView addSubview:_pageControl];
    [superView bringSubviewToFront:_pageControl];
}

- (void)startTimerToScroll{
    _timer = [NSTimer scheduledTimerWithTimeInterval:SCROLL_TIMER target:self selector:@selector(startScroll) userInfo:nil repeats:YES];
}

- (void)startScroll{
    [self setContentOffset:CGPointMake(SELF_WIDTH * 2, 0) animated:YES];
    _isTimeToScroll = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}

- (void)jumpToWebView{
    if (_jumpDelegate && [_jumpDelegate respondsToSelector:@selector(pushToWebViewWithModel:)]) {
        [_jumpDelegate pushToWebViewWithModel:[_imageArray objectAtIndex:_currentPage]];
    }
}

#pragma mark - 滚动代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //根据偏移量设置图片
    if (self.contentOffset.x == 0) {
        _currentPage = [self previousPage];
        [self setImages];
    }
    else if(self.contentOffset.x == SELF_WIDTH * 2){
        _currentPage = [self nextPage];
        [self setImages];
    }
    else{
        return;
    }
    
    _pageControl.currentPage = _currentPage;
    //重设偏移
    self.contentOffset = CGPointMake(SELF_WIDTH, 0);
    //如果是手动滚动。。。设置定时器2秒后再次系统滚动
    if (!_isTimeToScroll) {
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:SCROLL_TIMER]];
    }
    _isTimeToScroll = NO;
}
@end
