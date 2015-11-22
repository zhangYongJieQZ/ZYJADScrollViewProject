//
//  ADScrollView.h
//  ZYJADScrollView
//
//  Created by 张永杰 on 15/10/25.
//  Copyright © 2015年 张永杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GameModel;
@protocol jumpDelegate <NSObject>

- (void)pushToWebViewWithModel:(GameModel *)model;

@end

@interface ADScrollView : UIScrollView<UIScrollViewDelegate>
@property (weak, nonatomic)  id<jumpDelegate>jumpDelegate;

- (id)initWithFrame:(CGRect)frame andImageArray:(NSArray *)imgAry;
/**
 *  添加pageControl
 *
 *  @param superView 滚动视图的父视图
 */
- (void)createPageControllOnView:(UIView *)superView;
@end
