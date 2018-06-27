//
//  UIViewController+DJNavigationItem.h
//  DJNavigationBarSample
//
//  Created by DJ on 2018/5/3.
//Copyright © 2018年 DennisDeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DJNAVIGATION_BTNITEM_IMAGE_KEY      @"image"
#define DJNAVIGATION_BTNITEM_TITLE_KEY      @"title"
#define DJNAVIGATION_BTNITEM_SELECTOR_KEY   @"selector"
#define DJNAVIGATION_BTNITEM_EDGESTYLE_KEY  @"edgeStyle"
#define DJNAVIGATION_BTNITEM_GAP_KEY        @"gap"

#pragma mark - NavigationItem

@class DJNavigationTitleLabel;

@interface UIViewController (DJNavigationItem)

// NavigationBar barTintColor
// 控制系统title和btnItem颜色，使用本category请使用dj_NavigationTitleTintColor和dj_NavigationItemTintColor设置颜色
@property (nonatomic, strong) UIColor *dj_NavigationBarTintColor;

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


- (void)dj_setNeedsUpdateNavigationTintColor;

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

- (void)dj_setNavigationWithTitle:(NSString *)title barTintColor:(UIColor *)barTintColor leftDicArray:(NSArray *)larray rightDicArray:(NSArray *)rarray;
- (void)dj_setNavigationWithTitleView:(UIView *)titleView barTintColor:(UIColor *)barTintColor leftDicArray:(NSArray *)larray rightDicArray:(NSArray *)rarray;

- (UIButton *)dj_getNavigationLeftItemAtIndex:(NSUInteger)index;
- (UIButton *)dj_getNavigationRightItemAtIndex:(NSUInteger)index;

- (void)dj_setNavigationLeftItemTintColor:(UIColor *)tintColor;
- (void)dj_setNavigationRightItemTintColor:(UIColor *)tintColor;

- (void)dj_setNavigationLeftItemEnable:(BOOL)enable;
- (void)dj_setNavigationRightItemEnable:(BOOL)enable;
- (void)dj_setNavigationItemEnable:(BOOL)enable;

@end
