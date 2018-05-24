//
//  UIViewController+DJNavigationItem.h
//  DJNavigationBarSample
//
//  Created by DJ on 2018/5/3.
//Copyright © 2018年 DennisDeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - NavigationItem

@class DJNavigationTitleLabel;

@interface UIViewController (DJNavigationItem)

// Title透明度
@property (nonatomic, assign) CGFloat dj_NavigationTitleAlpha;
// Title是否隐藏
@property (nonatomic, assign) BOOL dj_NavigationTitleHidden;
// Title颜色
@property (nonatomic, strong) UIColor *dj_NavigationTitleTintColor;

// BarItem透明度
@property (nonatomic, assign) CGFloat dj_NavigationItemAlpha;
// BarItem是否隐藏
@property (nonatomic, assign) BOOL dj_NavigationItemHidden;
// BarItem tintColor
@property (nonatomic, strong) UIColor *dj_NavigationItemTintColor;

// NavigationTitle
- (void)dj_setNeedsUpdateNavigationTitleAlpha;
- (void)dj_setNeedsUpdateNavigationTitleTintColor;

- (DJNavigationTitleLabel *)dj_getNavigationBarTitleLabel;
- (void)dj_setNavigationBarTitle:(NSString *)title;

// NavigationItem
- (void)dj_setNeedsUpdateNavigationItemAlpha;
- (void)dj_setNeedsUpdateNavigationItemTintColor;

- (void)dj_setNavigationWithTitle:(NSString *)title barTintColor:(UIColor *)barTintColor leftItemTitle:(NSString *)lTitle leftItemImage:(id)lImage leftToucheEvent:(SEL)lSelector rightItemTitle:(NSString *)rTitle rightItemImage:(id)rImage rightToucheEvent:(SEL)rSelector;
- (void)dj_setNavigationWithTitleView:(UIView *)titleView barTintColor:(UIColor *)barTintColor leftItemTitle:(NSString *)lTitle leftItemImage:(id)lImage leftToucheEvent:(SEL)lSelector rightItemTitle:(NSString *)rTitle rightItemImage:(id)rImage rightToucheEvent:(SEL)rSelector;

- (UIButton *)dj_getNavigationLeftItemAtIndex:(NSUInteger)index;
- (UIButton *)dj_getNavigationRightItemAtIndex:(NSUInteger)index;

- (void)dj_setNavigationLeftItemTintColor:(UIColor *)tintColor;
- (void)dj_setNavigationRightItemTintColor:(UIColor *)tintColor;

- (void)dj_setNavigationLeftItemEnable:(BOOL)enable;
- (void)dj_setNavigationRightItemEnable:(BOOL)enable;
- (void)dj_setNavigationItemEnable:(BOOL)enable;

@end
