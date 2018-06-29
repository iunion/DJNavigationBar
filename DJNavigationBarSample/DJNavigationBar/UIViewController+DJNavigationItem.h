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

NS_ASSUME_NONNULL_BEGIN

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


- (void)dj_setNeedsUpdateNavigationBarTintColor;

// NavigationTitle
- (void)dj_setNeedsUpdateNavigationTitleAlpha;
- (void)dj_setNeedsUpdateNavigationTitleTintColor;

- (DJNavigationTitleLabel *)dj_getNavigationBarTitleLabel;
- (nullable DJNavigationTitleLabel *)dj_getNavigationBarTitleLabelAndCreate:(BOOL)createNew;
- (void)dj_setNavigationBarTitle:(nullable NSString *)title;

// NavigationItem
- (void)dj_setNeedsUpdateNavigationItemAlpha;
- (void)dj_setNeedsUpdateNavigationItemTintColor;

- (void)dj_setNavigationWithTitle:(nullable NSString *)title barTintColor:(nullable UIColor *)barTintColor leftItemTitle:(nullable NSString *)lTitle leftItemImage:(nullable id)lImage leftToucheEvent:(nullable SEL)lSelector rightItemTitle:(nullable NSString *)rTitle rightItemImage:(nullable id)rImage rightToucheEvent:(nullable SEL)rSelector;
- (void)dj_setNavigationWithTitleView:(nullable UIView *)titleView barTintColor:(nullable UIColor *)barTintColor leftItemTitle:(nullable NSString *)lTitle leftItemImage:(nullable id)lImage leftToucheEvent:(nullable SEL)lSelector rightItemTitle:(nullable NSString *)rTitle rightItemImage:(nullable id)rImage rightToucheEvent:(nullable SEL)rSelector;

- (void)dj_setNavigationWithTitle:(nullable NSString *)title barTintColor:(nullable UIColor *)barTintColor leftItemTitle:(nullable NSString *)lTitle leftItemImage:(nullable id)lImage leftToucheEvent:(nullable SEL)lSelector rightDicArray:(nullable NSArray *)rarray;
- (void)dj_setNavigationWithTitleView:(nullable UIView *)titleView barTintColor:(nullable UIColor *)barTintColor leftItemTitle:(nullable NSString *)lTitle leftItemImage:(nullable id)lImage leftToucheEvent:(nullable SEL)lSelector rightDicArray:(nullable NSArray *)rarray;

- (void)dj_setNavigationWithTitle:(nullable NSString *)title barTintColor:(nullable UIColor *)barTintColor leftDicArray:(nullable NSArray *)larray rightDicArray:(nullable NSArray *)rarray;
- (void)dj_setNavigationWithTitleView:(nullable UIView *)titleView barTintColor:(nullable UIColor *)barTintColor leftDicArray:(nullable NSArray *)larray rightDicArray:(nullable NSArray *)rarray;

- (nullable UIButton *)dj_getNavigationLeftItemAtIndex:(NSUInteger)index;
- (nullable UIButton *)dj_getNavigationRightItemAtIndex:(NSUInteger)index;

- (void)dj_setNavigationLeftItemTintColor:(UIColor *)tintColor;
- (void)dj_setNavigationRightItemTintColor:(UIColor *)tintColor;
- (void)dj_setNavigationItemTintColor:(UIColor *)tintColor;

- (void)dj_setNavigationLeftItemEnable:(BOOL)enable;
- (void)dj_setNavigationRightItemEnable:(BOOL)enable;
- (void)dj_setNavigationItemEnable:(BOOL)enable;

@end

NS_ASSUME_NONNULL_END
