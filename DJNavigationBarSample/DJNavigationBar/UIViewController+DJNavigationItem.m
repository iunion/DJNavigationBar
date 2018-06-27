//
//  UIViewController+DJNavigationItem.m
//  DJNavigationBarSample
//
//  Created by DJ on 2018/5/3.
//Copyright © 2018年 DennisDeng. All rights reserved.
//

#import "UIViewController+DJNavigationItem.h"
#import <objc/runtime.h>
#import "DJNavigationBarDefine.h"
#import "DJNavigationController.h"
#import "DJNavigationTitleLabel.h"
#import "UIViewController+DJNavigationBar.h"
#import "UIButton+DJEdgeInsets.h"
#import "NSDictionary+Category.h"

@implementation UIViewController (DJNavigationItem)

- (UIColor *)dj_NavigationBarTintColor
{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj)
    {
        return obj;
    }
    
    if ([UINavigationBar appearance].tintColor)
    {
        return [UINavigationBar appearance].tintColor;
    }
    
    return [UINavigationBar appearance].barStyle == UIBarStyleDefault ? [UIColor blackColor]: [UIColor whiteColor];
}

- (void)setDj_NavigationBarTintColor:(UIColor *)navigationBarTintColor
{
    objc_setAssociatedObject(self, @selector(dj_NavigationBarTintColor), navigationBarTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)dj_NavigationTitleAlpha
{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (self.dj_NavigationTitleHidden)
    {
        return 0.0f;
    }
    return obj ? [obj doubleValue] : 1.0f;
}

- (void)setDj_NavigationTitleAlpha:(CGFloat)alpha
{
    objc_setAssociatedObject(self, @selector(dj_NavigationTitleAlpha), @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)dj_NavigationTitleHidden
{
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj ? [obj boolValue] : NO;
}

- (void)setDj_NavigationTitleHidden:(BOOL)hidden
{
    objc_setAssociatedObject(self, @selector(dj_NavigationTitleHidden), @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)dj_NavigationTitleTintColor
{
    if (self.dj_NavigationTitleHidden)
    {
        return UIColor.clearColor;
    }
    
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj)
    {
        return obj;
    }
    
    if ([UINavigationBar appearance].tintColor)
    {
        return [UINavigationBar appearance].tintColor;
    }
    
    return [UINavigationBar appearance].barStyle == UIBarStyleDefault ? [UIColor blackColor]: [UIColor whiteColor];
}

- (void)setDj_NavigationTitleTintColor:(UIColor *)tintColor
{
    objc_setAssociatedObject(self, @selector(dj_NavigationTitleTintColor), tintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)dj_NavigationItemAlpha
{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (self.dj_NavigationItemHidden)
    {
        return 0.0f;
    }
    return obj ? [obj doubleValue] : 1.0f;
}

- (void)setDj_NavigationItemAlpha:(CGFloat)alpha
{
    objc_setAssociatedObject(self, @selector(dj_NavigationItemAlpha), @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)dj_NavigationItemHidden
{
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj ? [obj boolValue] : NO;
}

- (void)setDj_NavigationItemHidden:(BOOL)hidden
{
    objc_setAssociatedObject(self, @selector(dj_NavigationItemHidden), @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)dj_NavigationItemTintColor
{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj)
    {
        return obj;
    }
    
    if ([UINavigationBar appearance].tintColor)
    {
        return [UINavigationBar appearance].tintColor;
    }
    
    return [UINavigationBar appearance].barStyle == UIBarStyleDefault ? [UIColor blackColor]: [UIColor whiteColor];
}

- (void)setDj_NavigationItemTintColor:(UIColor *)color
{
    objc_setAssociatedObject(self, @selector(dj_NavigationItemTintColor), color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - Actions

- (DJNavigationTitleLabel *)dj_getNavigationBarTitleLabel
{
    DJNavigationTitleLabel *titleLabel = nil;
    UIView *view = self.navigationItem.titleView;
    
    if ([view isKindOfClass:[DJNavigationTitleLabel class]])
    {
        titleLabel = (DJNavigationTitleLabel *)view;
    }
    else
    {
        titleLabel = [[DJNavigationTitleLabel alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_NAVIGATION_BAR_HEIGHT)];
        titleLabel.textColor = self.dj_NavigationTitleTintColor;
        
        self.navigationItem.titleView = titleLabel;
    }
    
    return titleLabel;
}

- (void)dj_setNavigationBarTitle:(NSString *)title
{
    // tab的一级view不要设置title，否则tab文本重合
    // 可后续清空
    self.title = title;
    
    DJNavigationTitleLabel *titleLabel = [self dj_getNavigationBarTitleLabel];
    
    // 设置标题
    titleLabel.text = title;
}

- (void)dj_setNeedsUpdateNavigationTintColor
{
    if (self.navigationController && [self.navigationController isKindOfClass:[DJNavigationController class]])
    {
        DJNavigationController *nav = (DJNavigationController *)self.navigationController;
        [nav updateNavigationBarTintColorForViewController:self];
    }
}

- (void)dj_setNeedsUpdateNavigationTitleAlpha
{
    DJNavigationTitleLabel *titleLabel = [self dj_getNavigationBarTitleLabel];
    titleLabel.alpha = self.dj_NavigationTitleAlpha;
}

- (void)dj_setNeedsUpdateNavigationTitleTintColor
{
    DJNavigationTitleLabel *titleLabel = [self dj_getNavigationBarTitleLabel];
    titleLabel.textColor = self.dj_NavigationTitleTintColor;
}

- (UIBarButtonItem *)makeBarButton:(NSString *)title image:(id)image toucheEvent:(SEL)selector buttonEdgeInsetsStyle:(DJButtonEdgeInsetsStyle)edgeInsetsStyle imageTitleGap:(CGFloat)gap
{
// 直接使用UIBarButtonItem
//    if (selector != nil)
//    {
//        UIBarButtonItem * buttonItem = nil;
//        if (title != nil)
//        {
//            buttonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:selector];
//        }
//        else if (imageName)
//        {
//            buttonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName] style:UIBarButtonItemStylePlain target:self action:selector];
//        }
//
//        //buttonItem.tintColor = [UIColor whiteColor];
//
//        return buttonItem;
//    }
//    else
//    {
//        return nil;
//    }
//
//    return nil;
    
    if (edgeInsetsStyle > DJButtonEdgeInsetsStyleImageRight)
    {
        edgeInsetsStyle = DJButtonEdgeInsetsStyleImageLeft;
    }
    
    if (selector != nil)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
        btn.exclusiveTouch = YES;
        
        btn.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
        btn.tintColor = self.dj_NavigationItemTintColor;
        
        if (title != nil)
        {
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
            
            CGSize size = [title boundingRectWithSize:CGSizeMake(100.0f, 44.0f) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:btn.titleLabel.font} context:nil].size;
            btn.frame = CGRectMake(0, 0, size.width, size.height);
            [btn setTitle:title forState:UIControlStateNormal];
            //[btn setTitleColor:self.dj_NavigationItemTintColor forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
            
            if (image)
            {
                UIImage *itemImage = nil;
                
                if ([image isKindOfClass:[NSString class]])
                {
                    itemImage = [UIImage imageNamed:image];
                }
                else if ([image isKindOfClass:[UIImage class]])
                {
                    itemImage = image;
                }
                
                if (itemImage)
                {
                    // Set the rendering mode to respect tint color
                    UIImage *tintItemImage = [itemImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    CGFloat width = itemImage.size.width+size.width+gap;
                    CGFloat height = itemImage.size.height>size.height ? itemImage.size.height  : size.height;
                    btn.frame = CGRectMake(0, 0, width, height);
                    [btn setImage:tintItemImage forState:UIControlStateNormal];
                    [btn setBackgroundImage:nil forState:UIControlStateNormal];
                    
                    [btn bm_layoutButtonWithEdgeInsetsStyle:edgeInsetsStyle imageTitleGap:gap];
                }
            }
        }
        else if (image)
        {
            UIImage *itemImage = nil;
            
            if ([image isKindOfClass:[NSString class]])
            {
                itemImage = [UIImage imageNamed:image];
            }
            else if ([image isKindOfClass:[UIImage class]])
            {
                itemImage = image;
            }
            
            if (itemImage)
            {
                // Set the rendering mode to respect tint color
                UIImage *tintItemImage = [itemImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];;
                btn.frame = CGRectMake(0, 0, itemImage.size.width, itemImage.size.height);
                [btn setBackgroundImage:tintItemImage forState:UIControlStateNormal];
                [btn setImage:nil forState:UIControlStateNormal];
            }
        }
        
        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        return buttonItem;
    }
    else
    {
        return nil;
    }
}

- (void)dj_setNavigationLeftItemAlpha:(CGFloat)alpha
{
    for (UIBarButtonItem *buttonItem in self.navigationItem.leftBarButtonItems)
    {
        UIButton *btn = (UIButton *)buttonItem.customView;
        
        btn.alpha = alpha;
    }
}

- (void)dj_setNavigationRightItemAlpha:(CGFloat)alpha
{
    for (UIBarButtonItem *buttonItem in self.navigationItem.rightBarButtonItems)
    {
        UIButton *btn = (UIButton *)buttonItem.customView;
        
        btn.alpha = alpha;
    }
}

- (void)dj_setNeedsUpdateNavigationItemAlpha
{
    [self dj_setNavigationLeftItemAlpha:self.dj_NavigationItemAlpha];
    [self dj_setNavigationRightItemAlpha:self.dj_NavigationItemAlpha];
}

- (void)dj_setNavigationLeftItemTintColor:(UIColor *)tintColor
{
    for (UIBarButtonItem *buttonItem in self.navigationItem.leftBarButtonItems)
    {
        UIButton *btn = (UIButton *)buttonItem.customView;
        
        btn.tintColor = tintColor;
    }
}

- (void)dj_setNavigationRightItemTintColor:(UIColor *)tintColor
{
    for (UIBarButtonItem *buttonItem in self.navigationItem.rightBarButtonItems)
    {
        UIButton *btn = (UIButton *)buttonItem.customView;
        
        btn.tintColor = tintColor;
    }
}

- (void)dj_setNeedsUpdateNavigationItemTintColor
{
    [self dj_setNavigationLeftItemTintColor:self.dj_NavigationItemTintColor];
    [self dj_setNavigationRightItemTintColor:self.dj_NavigationItemTintColor];
}

- (void)dj_setNavigationWithTitle:(NSString *)title barTintColor:(UIColor *)barTintColor leftItemTitle:(NSString *)lTitle leftItemImage:(id)lImage leftToucheEvent:(SEL)lSelector rightItemTitle:(NSString *)rTitle rightItemImage:(id)rImage rightToucheEvent:(SEL)rSelector
{
    [self dj_setNavigationBarTitle:title];
    
    [self dj_setNavigationWithTitleView:nil barTintColor:barTintColor leftItemTitle:lTitle leftItemImage:lImage leftToucheEvent:lSelector rightItemTitle:rTitle rightItemImage:rImage rightToucheEvent:rSelector];
}

- (void)dj_setNavigationWithTitleView:(UIView *)titleView barTintColor:(UIColor *)barTintColor leftItemTitle:(NSString *)lTitle leftItemImage:(id)lImage leftToucheEvent:(SEL)lSelector rightItemTitle:(NSString *)rTitle rightItemImage:(id)rImage rightToucheEvent:(SEL)rSelector
{
    [self.navigationItem setHidesBackButton:YES];
    
    // 设置标题
    if (titleView)
    {
        self.navigationItem.titleView = titleView;
    }
    
    if (barTintColor)
    {
        self.dj_NavigationBarBgTintColor = barTintColor;
        [self dj_setNeedsUpdateNavigationBarBgTintColor];
    }
    
    //self.dj_NavigationTitleTintColor = [UIColor whiteColor];
    //self.dj_NavigationItemTintColor = [UIColor whiteColor];
    [self dj_setNeedsUpdateNavigationTitleTintColor];
    [self dj_setNeedsUpdateNavigationItemTintColor];
    
    // 设置左按键
    UIBarButtonItem *lButtonItem = [self makeBarButton:lTitle image:lImage toucheEvent:lSelector buttonEdgeInsetsStyle:DJButtonEdgeInsetsStyleImageLeft imageTitleGap:2.0f];
    self.navigationItem.leftBarButtonItem = lButtonItem;
    
    // 设置右按键
    UIBarButtonItem *rButtonItem = [self makeBarButton:rTitle image:rImage toucheEvent:rSelector buttonEdgeInsetsStyle:DJButtonEdgeInsetsStyleImageRight imageTitleGap:2.0f];
    self.navigationItem.rightBarButtonItem = rButtonItem;
}

- (void)dj_setNavigationWithTitle:(NSString *)title barTintColor:(UIColor *)barTintColor leftDicArray:(NSArray *)larray rightDicArray:(NSArray *)rarray
{
    [self dj_setNavigationBarTitle:title];
    
    [self dj_setNavigationWithTitleView:nil barTintColor:barTintColor leftDicArray:larray rightDicArray:rarray];
}

- (void)dj_setNavigationWithTitleView:(UIView *)titleView barTintColor:(UIColor *)barTintColor leftDicArray:(NSArray *)larray rightDicArray:(NSArray *)rarray
{
    [self.navigationItem setHidesBackButton:YES];
    
    // 设置标题
    if (titleView)
    {
        self.navigationItem.titleView = titleView;
    }
    
    if (barTintColor)
    {
        self.dj_NavigationBarBgTintColor = barTintColor;
        [self dj_setNeedsUpdateNavigationBarBgTintColor];
    }
    
    //self.dj_NavigationTitleTintColor = [UIColor whiteColor];
    //self.dj_NavigationItemTintColor = [UIColor whiteColor];
    [self dj_setNeedsUpdateNavigationTitleTintColor];
    [self dj_setNeedsUpdateNavigationItemTintColor];
    
    // 设置左Item
    if ([larray isNotEmpty])
    {
        NSMutableArray *btnArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dic in larray)
        {
            NSString *title = [dic DJStringForKey:DJNAVIGATION_BTNITEM_TITLE_KEY];
            NSString *imageName = [dic DJStringForKey:DJNAVIGATION_BTNITEM_TITLE_KEY];
            SEL aSelector = NSSelectorFromString([dic DJStringForKey:DJNAVIGATION_BTNITEM_SELECTOR_KEY]);
            DJButtonEdgeInsetsStyle edgeInsetsStyle = [dic uintForKey:DJNAVIGATION_BTNITEM_EDGESTYLE_KEY withDefault:DJButtonEdgeInsetsStyleImageLeft];
            CGFloat gap = [dic uintForKey:DJNAVIGATION_BTNITEM_GAP_KEY withDefault:2];
            
            UIBarButtonItem *buttonItem = [self makeBarButton:title image:imageName toucheEvent:aSelector buttonEdgeInsetsStyle:edgeInsetsStyle imageTitleGap:gap];
            [btnArray addObject:buttonItem];
        }
        
        if (btnArray.count)
        {
            self.navigationItem.leftBarButtonItems = btnArray;
        }
        else
        {
            self.navigationItem.leftBarButtonItems = nil;
        }
    }
    
    // 设置左Item
    if ([rarray isNotEmpty])
    {
        NSMutableArray *btnArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dic in rarray)
        {
            NSString *title = [dic objectForKey:DJNAVIGATION_BTNITEM_TITLE_KEY];
            NSString *imageName = [dic objectForKey:DJNAVIGATION_BTNITEM_TITLE_KEY];
            SEL aSelector = NSSelectorFromString([dic objectForKey:DJNAVIGATION_BTNITEM_SELECTOR_KEY]);
            DJButtonEdgeInsetsStyle edgeInsetsStyle = [dic uintForKey:DJNAVIGATION_BTNITEM_EDGESTYLE_KEY withDefault:DJButtonEdgeInsetsStyleImageRight];
            CGFloat gap = [dic uintForKey:DJNAVIGATION_BTNITEM_GAP_KEY withDefault:2];

            UIBarButtonItem *buttonItem = [self makeBarButton:title image:imageName toucheEvent:aSelector buttonEdgeInsetsStyle:edgeInsetsStyle imageTitleGap:gap];
            [btnArray addObject:buttonItem];
        }
        
        if (btnArray.count)
        {
            self.navigationItem.rightBarButtonItems = btnArray;
        }
        else
        {
            self.navigationItem.rightBarButtonItems = nil;
        }
    }
}

- (UIButton *)dj_getNavigationLeftItemAtIndex:(NSUInteger)index
{
    if (index < self.navigationItem.leftBarButtonItems.count)
    {
        UIBarButtonItem *buttonItem = [self.navigationItem.leftBarButtonItems objectAtIndex:index];
        return (UIButton *)buttonItem.customView;
    }
    else
    {
        UIBarButtonItem *buttonItem = self.navigationItem.leftBarButtonItem;
        if ( buttonItem != nil)
        {
            return (UIButton *)buttonItem.customView;
        }
        
        return nil;
    }
}

- (UIButton *)dj_getNavigationRightItemAtIndex:(NSUInteger)index
{
    if (index < self.navigationItem.rightBarButtonItems.count)
    {
        UIBarButtonItem *buttonItem = [self.navigationItem.rightBarButtonItems objectAtIndex:index];
        return (UIButton *)buttonItem.customView;
    }
    else
    {
        UIBarButtonItem *buttonItem = self.navigationItem.rightBarButtonItem;
        if ( buttonItem != nil)
        {
            return (UIButton *)buttonItem.customView;
        }
        
        return nil;
    }
}

- (void)dj_setNavigationLeftItemEnable:(BOOL)enable
{
    for (UIBarButtonItem *buttonItem in self.navigationItem.leftBarButtonItems)
    {
        UIButton *btn = (UIButton *)buttonItem.customView;
        
        btn.enabled = enable;
    }
}

- (void)dj_setNavigationRightItemEnable:(BOOL)enable
{
    for (UIBarButtonItem *buttonItem in self.navigationItem.rightBarButtonItems)
    {
        UIButton *btn = (UIButton *)buttonItem.customView;
        
        btn.enabled = enable;
    }
}

- (void)dj_setNavigationItemEnable:(BOOL)enable
{
    [self dj_setNavigationLeftItemEnable:enable];
    [self dj_setNavigationRightItemEnable:enable];
}

@end
