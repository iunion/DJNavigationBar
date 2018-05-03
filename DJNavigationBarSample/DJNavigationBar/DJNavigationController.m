//
//  DJNavigationController.m
//  DJNavigationBarSample
//
//  Created by DJ on 2018/4/28.
//  Copyright © 2018年 DennisDeng. All rights reserved.
//

#import "DJNavigationController.h"
#import "DJNavigationBarDefine.h"
#import "DJNavigationBar.h"
#import "UIViewController+DJNavigationBar.h"

@interface DJNavigationController ()
<
    UIGestureRecognizerDelegate,
    UINavigationControllerDelegate
>

@property (nonatomic, readonly) DJNavigationBar *navigationBar;

@property (nonatomic, strong) UIVisualEffectView *fromFakeBar;
@property (nonatomic, strong) UIVisualEffectView *toFakeBar;
@property (nonatomic, strong) UIImageView *fromFakeShadow;
@property (nonatomic, strong) UIImageView *toFakeShadow;

/// A Boolean value indicating whether navigation controller is currently pushing or pop a new view controller on the stack.
@property (nonatomic, getter = isDuringPushAnimation) BOOL duringPushAnimation;
@property (nonatomic, getter = isDuringPopAnimation) BOOL duringPopAnimation;
/// A real delegate of the class. `delegate` property is used only for keeping an internal state during
/// animations – we need to know when the animation ended, and that info is available only
/// from `navigationController:didShowViewController:animated:`.
@property (weak, nonatomic) id<UINavigationControllerDelegate> realDelegate;

@end

@implementation DJNavigationController
@dynamic navigationBar;

- (void)dealloc
{
    self.delegate = nil;
    self.interactivePopGestureRecognizer.delegate = nil;
}

- (instancetype)init
{
    return [super initWithNavigationBarClass:[DJNavigationBar class] toolbarClass:nil];
}

- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass
{
    NSAssert([navigationBarClass isSubclassOfClass:[DJNavigationBar class]], @"navigationBarClass Must be a subclass of DJNavigationBar");
    return [super initWithNavigationBarClass:navigationBarClass toolbarClass:toolbarClass];
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithNavigationBarClass:[DJNavigationBar class] toolbarClass:nil])
    {
        self.viewControllers = @[rootViewController];
    }
    return self;
}


#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!self.delegate)
    {
        self.delegate = self;
    }
    
    self.interactivePopGestureRecognizer.delegate = self;
    [self.navigationBar setShadowImage:[UINavigationBar appearance].shadowImage];
    [self.navigationBar setTranslucent:YES]; // make sure translucent
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate
{
    self.realDelegate = delegate != self ? delegate : nil;
    [super setDelegate:delegate ? self : nil];
}


#pragma mark - UINavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (animated)
    {
        if ([self isDuringPushAnimation])
        {
            return;
        }
        self.duringPushAnimation = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (animated)
    {
        if ([self isDuringPopAnimation])
        {
            return nil;
        }
        self.duringPopAnimation = YES;
    }
    
    UIViewController *vc = [super popViewControllerAnimated:animated];
    self.navigationBar.barStyle = self.topViewController.dj_NavigationBarStyle;
    return vc;
}

- (NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (animated)
    {
        if ([self isDuringPopAnimation])
        {
            return nil;
        }
        self.duringPopAnimation = YES;
    }
    
    NSArray *array = [super popToViewController:viewController animated:animated];
    self.navigationBar.barStyle = self.topViewController.dj_NavigationBarStyle;
    return array;
}

- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    if (animated)
    {
        if ([self isDuringPopAnimation])
        {
            return nil;
        }
        self.duringPopAnimation = YES;
    }
    
    NSArray *array = [super popToRootViewControllerAnimated:animated];
    self.navigationBar.barStyle = self.topViewController.dj_NavigationBarStyle;
    return array;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    id <UIViewControllerTransitionCoordinator> coordinator = self.transitionCoordinator;
    if (coordinator && [coordinator initiallyInteractive])
    {
        [coordinator notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            //NSog(@"%@", @([context isCancelled]));
            self.duringPopAnimation = NO;
        }];
    }
    else
    {
        self.duringPopAnimation = NO;
    }
    
    self.navigationBar.barStyle = viewController.dj_NavigationBarStyle;
    
    if (coordinator)
    {
        UIViewController *from = [coordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *to = [coordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
            BOOL shouldFake = (to == viewController) && (![from.dj_NavigationBarTintColor.description  isEqual:to.dj_NavigationBarTintColor.description] || ABS(from.dj_NavigationBarAlpha - to.dj_NavigationBarAlpha) > 0.1f);
            if (shouldFake)
            {
                [UIView performWithoutAnimation:^{
                    self.navigationBar.effectView.alpha = 0;
                    self.navigationBar.shadowLineImageView.alpha = 0;
                    
                    // from
                    self.fromFakeBar.contentView.backgroundColor = from.dj_NavigationBarTintColor;
                    self.fromFakeBar.effect = from.dj_NavigationBarEffect;
                    self.fromFakeBar.alpha = from.dj_NavigationBarAlpha == 0 ? 0.01:from.dj_NavigationBarAlpha;
                    if (from.dj_NavigationBarAlpha == 0) {
                        self.fromFakeBar.subviews[1].alpha = 0.01;
                    }
                    self.fromFakeBar.frame = [self fakeBarFrameForViewController:from];
                    [from.view addSubview:self.fromFakeBar];
                    self.fromFakeShadow.alpha = from.dj_NavigationShadowAlpha;
                    self.fromFakeShadow.frame = [self fakeShadowFrameWithBarFrame:self.fromFakeBar.frame];
                    [from.view addSubview:self.fromFakeShadow];
                    // to
                    self.toFakeBar.contentView.backgroundColor = to.dj_NavigationBarTintColor;
                    self.toFakeBar.effect = to.dj_NavigationBarEffect;
                    self.toFakeBar.alpha = to.dj_NavigationBarAlpha;
                    self.toFakeBar.frame = [self fakeBarFrameForViewController:to];
                    [to.view addSubview:self.toFakeBar];
                    self.toFakeShadow.alpha = to.dj_NavigationShadowAlpha;
                    self.toFakeShadow.frame = [self fakeShadowFrameWithBarFrame:self.toFakeBar.frame];
                    [to.view addSubview:self.toFakeShadow];
                }];
            } else {
                [self updateNavigationBarForController:viewController];
            }
        } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            if (context.isCancelled) {
                [self updateNavigationBarForController:from];
            } else {
                // 当 present 时 to 不等于 viewController
                [self updateNavigationBarForController:viewController];
            }
            if (to == viewController) {
                [self clearFake];
            }
        }];
    }
    else
    {
        [self updateNavigationBarForController:viewController];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSCAssert(self.interactivePopGestureRecognizer.delegate == self, @"AHKNavigationController won't work correctly if you change interactivePopGestureRecognizer's delegate.");
    
    self.duringPushAnimation = NO;
    self.duringPopAnimation = NO;
    
    if ([self.realDelegate respondsToSelector:_cmd])
    {
        [self.realDelegate navigationController:navigationController didShowViewController:viewController animated:animated];
    }
}

- (UIVisualEffectView *)fromFakeBar {
    if (!_fromFakeBar) {
        _fromFakeBar = [[UIVisualEffectView alloc] initWithEffect:DJNavigationBar_DefaultEffect];
    }
    return _fromFakeBar;
}

- (UIVisualEffectView *)toFakeBar {
    if (!_toFakeBar) {
        _toFakeBar = [[UIVisualEffectView alloc] initWithEffect:DJNavigationBar_DefaultEffect];
    }
    return _toFakeBar;
}

- (UIImageView *)fromFakeShadow {
    if (!_fromFakeShadow) {
        _fromFakeShadow = [[UIImageView alloc] initWithImage:self.navigationBar.shadowLineImageView.image];
        _fromFakeShadow.backgroundColor = self.navigationBar.shadowLineImageView.backgroundColor;
    }
    return _fromFakeShadow;
}

- (UIImageView *)toFakeShadow {
    if (!_toFakeShadow) {
        _toFakeShadow = [[UIImageView alloc] initWithImage:self.navigationBar.shadowLineImageView.image];
        _toFakeShadow.backgroundColor = self.navigationBar.shadowLineImageView.backgroundColor;
    }
    return _toFakeShadow;
}

- (void)clearFake {
    [self.fromFakeBar removeFromSuperview];
    [self.toFakeBar removeFromSuperview];
    [self.fromFakeShadow removeFromSuperview];
    [self.toFakeShadow removeFromSuperview];
    self.fromFakeBar = nil;
    self.toFakeBar = nil;
    self.fromFakeShadow = nil;
    self.toFakeShadow = nil;
}

- (CGRect)fakeBarFrameForViewController:(UIViewController *)vc {
    CGRect frame = [self.navigationBar.effectView convertRect:self.navigationBar.effectView.frame toView:vc.view];
    frame.origin.x = vc.view.frame.origin.x;
    return frame;
}

- (CGRect)fakeShadowFrameWithBarFrame:(CGRect)frame {
    return CGRectMake(frame.origin.x, frame.size.height + frame.origin.y, frame.size.width, 0.5);
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.viewControllers.count <= 1)
    {
        return NO;
    }
    // 私有变量标志transition动画是否正在进行
    // 后面可以不判断 !self.isDuringPushAnimation && !self.isDuringPopAnimation
    if ([[self valueForKey:@"_isTransitioning"] boolValue])
    {
        return NO;
    }
    
    if (gestureRecognizer == self.interactivePopGestureRecognizer)
    {
        // Disable pop gesture in two situations:
        // 1) when the pop animation is in progress
        // 2) when user swipes quickly a couple of times and animations don't have time to be performed
        // 3) 页面VC 支持返回手势
        BOOL canGesture = self.topViewController.dj_CanBackInteractive;
        if (canGesture && !self.isDuringPushAnimation && !self.isDuringPopAnimation)
        {
            return YES;
        }
        
        return NO;
    }
    else
    {
        // default value
        return YES;
    }
}

#pragma mark - Delegate Forwarder

// Thanks for the idea goes to: https://github.com/steipete/PSPDFTextView/blob/ee9ce04ad04217efe0bc84d67f3895a34252d37c/PSPDFTextView/PSPDFTextView.m#L148-164

- (BOOL)respondsToSelector:(SEL)s
{
    return [super respondsToSelector:s] || [self.realDelegate respondsToSelector:s];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)s
{
    return [super methodSignatureForSelector:s] ?: [(id)self.realDelegate methodSignatureForSelector:s];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    id delegate = self.realDelegate;
    if ([delegate respondsToSelector:invocation.selector])
    {
        [invocation invokeWithTarget:delegate];
    }
}


#pragma mark -
#pragma mark actions

- (void)updateNavigationBarForController:(UIViewController *)vc
{
    [self updateNavigationBarStyleForViewController:vc];

    [self updateNavigationBarEffectForViewController:vc];
    
    [self updateNavigationBarAlphaForViewController:vc];
    [self updateNavigationBarTintColorForViewController:vc];
    
    [self updateNavigationShadowAlphaForViewController:vc];
    [self updateNavigationShadowColorForViewController:vc];
}

- (void)updateNavigationBarStyleForViewController:(UIViewController *)vc
{
    self.navigationBar.barStyle = vc.dj_NavigationBarStyle;
    self.navigationBar.barTintColor = vc.dj_NavigationBarTintColor;
}

- (void)updateNavigationBarAlphaForViewController:(UIViewController *)vc
{
    self.navigationBar.effectView.alpha = vc.dj_NavigationBarAlpha;
    self.navigationBar.shadowLineImageView.alpha = vc.dj_NavigationShadowAlpha;
    self.navigationBar.barTintColor = vc.dj_NavigationBarTintColor;
}

- (void)updateNavigationBarTintColorForViewController:(UIViewController *)vc
{
    self.navigationBar.barTintColor = vc.dj_NavigationBarTintColor;
}

- (void)updateNavigationBarEffectForViewController:(UIViewController *)vc
{
    self.navigationBar.effect = vc.dj_NavigationBarEffect;
}

- (void)updateNavigationShadowAlphaForViewController:(UIViewController *)vc
{
    self.navigationBar.shadowLineImageView.alpha = vc.dj_NavigationShadowAlpha;
    self.navigationBar.shadowLineImageView.backgroundColor = vc.dj_NavigationShadowColor;
}

- (void)updateNavigationShadowColorForViewController:(UIViewController *)vc
{
    self.navigationBar.shadowLineImageView.backgroundColor = vc.dj_NavigationShadowColor;
}

@end
