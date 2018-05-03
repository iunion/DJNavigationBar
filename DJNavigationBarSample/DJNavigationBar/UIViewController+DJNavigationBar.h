//
//  UIViewController+DJNavigationBar.h
//  DJNavigationBarSample
//
//  Created by DJ on 2018/4/28.
//Copyright © 2018年 DennisDeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - NavigationBar

@interface UIViewController (DJNavigationBar)

// UIBarStyle
@property (nonatomic, assign) UIBarStyle dj_NavigationBarStyle;

// NavigationBar透明度
@property (nonatomic, assign) CGFloat dj_NavigationBarAlpha;
// NavigationBar是否隐藏
@property (nonatomic, assign) BOOL dj_NavigationBarHidden;
// NavigationBar背景色
@property (nonatomic, strong) UIColor *dj_NavigationBarTintColor;
// NavigationBar背景色
@property (nonatomic, strong) UIVisualEffect *dj_NavigationBarEffect;

// Title透明度
@property (nonatomic, assign) CGFloat dj_NavigationTitleAlpha;
// Title是否隐藏
@property (nonatomic, assign) BOOL dj_NavigationTitleHidden;
// Title颜色
@property (nonatomic, strong) UIColor *dj_NavigationTitleTintColor;

// NavigationBar阴影线条透明度
@property (nonatomic, assign, readonly) CGFloat dj_NavigationShadowAlpha;
// NavigationBar阴影线条是否隐藏
@property (nonatomic, assign) BOOL dj_NavigationShadowHidden;
// NavigationBar阴影线条背景色
@property (nonatomic, strong) UIColor *dj_NavigationShadowColor;

// 是否支持右滑返回
@property (nonatomic, assign) BOOL dj_CanBackInteractive;

- (void)dj_setNeedsUpdateNavigationBar;
- (void)dj_setNeedsUpdateNavigationBarStyle;

- (void)dj_setNeedsUpdateNavigationBarAlpha;
- (void)dj_setNeedsUpdateNavigationBarTintColor;
- (void)dj_setNeedsUpdateNavigationBarEffect;

- (void)dj_setNeedsUpdateNavigationShadowAlpha;
- (void)dj_setNeedsUpdateNavigationShadowColor;

@end
