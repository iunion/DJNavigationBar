//
//  DJNavigationBar.m
//  DJNavigationBarSample
//
//  Created by DJ on 2018/4/28.
//  Copyright © 2018年 DennisDeng. All rights reserved.
//

#import "DJNavigationBar.h"
#import "DJNavigationBarDefine.h"

@interface DJNavigationBar ()

@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UIImageView *shadowLineImageView;

@end

@implementation DJNavigationBar

- (UIVisualEffectView *)effectView
{
    if (!_effectView)
    {
        [super setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        UIView *view = self.subviews.firstObject;
        
        _effectView = [[UIVisualEffectView alloc] initWithEffect:DJNavigationBar_DefaultEffect];
        //_effectView = [[UIVisualEffectView alloc] initWithEffect:nil];
        _effectView.userInteractionEnabled = NO;
        _effectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [view insertSubview:_effectView atIndex:0];
        _effectView.frame = view.bounds;
    }
    
    return _effectView;
}

- (UIImageView *)shadowLineImageView
{
    if (!_shadowLineImageView)
    {
        [super setShadowImage:[UIImage new]];
        UIView *view = self.subviews.firstObject;
        
        _shadowLineImageView = [[UIImageView alloc] init];
        _shadowLineImageView.userInteractionEnabled = NO;
        [view insertSubview:_shadowLineImageView aboveSubview:self.effectView];
    }
    
    return _shadowLineImageView;
}

- (UIVisualEffect *)effect
{
    return self.effectView.effect;
}

- (void)setEffect:(UIVisualEffect *)effect
{
    self.effectView.effect = effect;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.effectView.frame = self.effectView.superview.bounds;
    self.shadowLineImageView.frame = CGRectMake(0, CGRectGetHeight(self.shadowLineImageView.superview.bounds), CGRectGetWidth(self.shadowLineImageView.superview.bounds), 1.0f/[UIScreen mainScreen].scale);
}

- (void)setBackgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics
{
    return;
}

- (void)setBarTintColor:(UIColor *)barTintColor
{
    [super setBarTintColor:barTintColor];
    self.effectView.contentView.backgroundColor =  barTintColor;
}

- (void)setShadowImage:(UIImage *)shadowImage
{
//    UIImage *shinobiHead = [UIImage imageNamed:@"shinobihead"];
//    // Set the rendering mode to respect tint color
//    shinobiHead = [shinobiHead imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    // And set to the image view
//    self.tintedImageView.image = shinobiHead;

    self.shadowLineImageView.image = shadowImage;
    if (shadowImage)
    {
        self.shadowLineImageView.backgroundColor = nil;
    }
    else
    {
        self.shadowLineImageView.backgroundColor = [UIColor colorWithWhite:0.3f alpha:0.4f];
    }
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01)
//    {
//        return nil;
//    }
//    
//    UIView *view = [super hitTest:point withEvent:event];
//    NSString *viewName = [[[view classForCoder] description] stringByReplacingOccurrencesOfString:@"_" withString:@""];
//    
//    if (view && [viewName isEqualToString:@"DJNavigationBar"])
//    {
//        for (UIView *subview in self.subviews)
//        {
//            NSString *viewName = [[[subview classForCoder] description] stringByReplacingOccurrencesOfString:@"_" withString:@""];
//            NSArray *array = @[@"UINavigationItemButtonView"];
//            if ([array containsObject:viewName])
//            {
//                CGPoint convertedPoint = [self convertPoint:point toView:subview];
//                CGRect bounds = subview.bounds;
//                if (bounds.size.width < 80.0f)
//                {
//                    bounds = CGRectInset(bounds, bounds.size.width - 80.0f, 0);
//                }
//                if (CGRectContainsPoint(bounds, convertedPoint))
//                {
//                    return view;
//                }
//            }
//        }
//    }
//    
//    NSArray *array = @[ @"UINavigationBarContentView", @"DJNavigationBar" ];
//    if ([array containsObject:viewName])
//    {
//        if (self.effectView.alpha < 0.01)
//        {
//            return nil;
//        }
//    }
//    
//    if (CGRectEqualToRect(view.bounds, CGRectZero))
//    {
//        return nil;
//    }
//    
//    return view;
//}

@end
