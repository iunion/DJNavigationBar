//
//  DJNavigationController.h
//  DJNavigationBarSample
//
//  Created by DJ on 2018/4/28.
//  Copyright © 2018年 DennisDeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJNavigationController : UINavigationController

// 刷新bar
- (void)updateNavigationBarForController:(UIViewController *)vc;
- (void)updateNavigationBarStyleForViewController:(UIViewController *)vc;

// 刷新bar背景
- (void)updateNavigationBarAlphaForViewController:(UIViewController *)vc;
- (void)updateNavigationBarTintColorForViewController:(UIViewController *)vc;
- (void)updateNavigationBarEffectForViewController:(UIViewController *)vc;

// 刷新bar阴影
- (void)updateNavigationShadowAlphaForViewController:(UIViewController *)vc;
- (void)updateNavigationShadowColorForViewController:(UIViewController *)vc;

@end
