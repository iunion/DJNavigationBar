//
//  UIViewController+DJNavigationBar.m
//  DJNavigationBarSample
//
//  Created by DJ on 2018/4/28.
//Copyright © 2018年 DennisDeng. All rights reserved.
//

#import "UIViewController+DJNavigationBar.h"
#import <objc/runtime.h>
#import "DJNavigationBarDefine.h"
#import "DJNavigationController.h"

@implementation UIViewController (DJNavigationBar)

- (UIBarStyle)dj_NavigationBarStyle
{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj)
    {
        return [obj integerValue];
    }
    return [UINavigationBar appearance].barStyle;
}

- (void)setDj_NavigationBarStyle:(UIBarStyle)navigationBarStyle
{
    objc_setAssociatedObject(self, @selector(dj_NavigationBarStyle), @(navigationBarStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)dj_NavigationBarAlpha
{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (self.dj_NavigationBarHidden)
    {
        return 0.0f;
    }
    return obj ? [obj doubleValue] : 1.0f;
}

- (void)setDj_NavigationBarAlpha:(CGFloat)alpha
{
    objc_setAssociatedObject(self, @selector(dj_NavigationBarAlpha), @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)dj_NavigationBarHidden
{
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj ? [obj boolValue] : NO;
}

- (void)setDj_NavigationBarHidden:(BOOL)hidden
{
    objc_setAssociatedObject(self, @selector(dj_NavigationBarHidden), @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)dj_NavigationBarBgTintColor
{
    if (self.dj_NavigationBarHidden)
    {
        return UIColor.clearColor;
    }
    
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj)
    {
        return obj;
    }
    
    if ([UINavigationBar appearance].barTintColor)
    {
        return [UINavigationBar appearance].barTintColor;
    }
    
    return (self.dj_NavigationBarStyle == UIBarStyleDefault) ? [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:0.8]: [UIColor colorWithRed:28/255.0 green:28/255.0 blue:28/255.0 alpha:0.729];
}

- (void)setDj_NavigationBarBgTintColor:(UIColor *)navigationBarBgTintColor
{
    objc_setAssociatedObject(self, @selector(dj_NavigationBarBgTintColor), navigationBarBgTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIVisualEffect *)dj_NavigationBarEffect
{
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj ? obj : DJNavigationBar_DefaultEffect;
}

- (void)setDj_NavigationBarEffect:(UIVisualEffect *)navigationBarEffect
{
    objc_setAssociatedObject(self, @selector(dj_NavigationBarEffect), navigationBarEffect, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)dj_NavigationBarImage
{
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj;
}

- (void)setDj_NavigationBarImage:(UIImage *)navigationBarImage
{
    objc_setAssociatedObject(self, @selector(dj_NavigationBarImage), navigationBarImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)dj_NavigationShadowAlpha
{
    return  self.dj_NavigationShadowHidden ? 0.0f : self.dj_NavigationBarAlpha;
}

- (BOOL)dj_NavigationShadowHidden
{
    id obj = objc_getAssociatedObject(self, _cmd);
    return  self.dj_NavigationBarHidden || obj ? [obj boolValue] : NO;
}

- (void)setDj_NavigationShadowHidden:(BOOL)hidden
{
    objc_setAssociatedObject(self, @selector(dj_NavigationShadowHidden), @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)dj_NavigationShadowColor
{
    if (self.dj_NavigationShadowHidden)
    {
        return UIColor.clearColor;
    }
    
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj)
    {
        return obj;
    }
    
    return [UINavigationBar appearance].barStyle == UIBarStyleDefault ? [UIColor blackColor]: [UIColor whiteColor];
}

- (void)setDj_NavigationShadowColor:(UIColor *)color
{
    objc_setAssociatedObject(self, @selector(dj_NavigationShadowColor), color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)dj_CanBackInteractive
{
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj ? [obj boolValue] : YES;
}

-(void)setDj_CanBackInteractive:(BOOL)interactive
{
    objc_setAssociatedObject(self, @selector(dj_CanBackInteractive), @(interactive), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)dj_NavigationBarTranslationY
{
    return self.navigationController.navigationBar.transform.ty;
}

- (void)setDj_NavigationBarTranslationY:(CGFloat)translationY
{
    self.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0, translationY);
}



#pragma mark -
#pragma mark Navigation Actions

- (void)dj_setNeedsUpdateNavigationBar
{
    if (self.navigationController && [self.navigationController isKindOfClass:[DJNavigationController class]])
    {
        DJNavigationController *nav = (DJNavigationController *)self.navigationController;
        [nav updateNavigationBarForController:self];
    }
}

- (void)dj_setNeedsUpdateNavigationBarStyle
{
    if (self.navigationController && [self.navigationController isKindOfClass:[DJNavigationController class]])
    {
        DJNavigationController *nav = (DJNavigationController *)self.navigationController;
        [nav updateNavigationBarStyleForViewController:self];
    }
}

- (void)dj_setNeedsUpdateNavigationBarAlpha
{
    if (self.navigationController && [self.navigationController isKindOfClass:[DJNavigationController class]])
    {
        DJNavigationController *nav = (DJNavigationController *)self.navigationController;
        [nav updateNavigationBarAlphaForViewController:self];
    }
}

- (void)dj_setNeedsUpdateNavigationBarBgTintColor
{
    if (self.navigationController && [self.navigationController isKindOfClass:[DJNavigationController class]])
    {
        DJNavigationController *nav = (DJNavigationController *)self.navigationController;
        [nav updateNavigationBarBgTintColorForViewController:self];
    }
}

- (void)dj_setNeedsUpdateNavigationBarEffect
{
    if (self.navigationController && [self.navigationController isKindOfClass:[DJNavigationController class]])
    {
        DJNavigationController *nav = (DJNavigationController *)self.navigationController;
        [nav updateNavigationBarEffectForViewController:self];
    }
}

- (void)dj_setNeedsUpdateNavigationBarImage
{
    if (self.navigationController && [self.navigationController isKindOfClass:[DJNavigationController class]])
    {
        DJNavigationController *nav = (DJNavigationController *)self.navigationController;
        [nav updateNavigationBarImageForViewController:self];
    }
}

- (void)dj_setNeedsUpdateNavigationShadowAlpha
{
    if (self.navigationController && [self.navigationController isKindOfClass:[DJNavigationController class]])
    {
        DJNavigationController *nav = (DJNavigationController *)self.navigationController;
        [nav updateNavigationShadowAlphaForViewController:self];
    }
}

- (void)dj_setNeedsUpdateNavigationShadowColor
{
    if (self.navigationController && [self.navigationController isKindOfClass:[DJNavigationController class]])
    {
        DJNavigationController *nav = (DJNavigationController *)self.navigationController;
        [nav updateNavigationShadowColorForViewController:self];
    }
}

@end
