//
//  DJNavigationButton.h
//  ODR
//
//  Created by jiang deng on 2018/6/4.
//  Copyright © 2018年 DH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+DJEdgeInsets.h"


IB_DESIGNABLE

@interface DJNavigationButton : UIButton

#if TARGET_INTERFACE_BUILDER
@property (nonatomic, assign) IBInspectable NSUInteger edgeInsetsStyle;
#else
@property (nonatomic, assign) DJButtonEdgeInsetsStyle edgeInsetsStyle;
#endif
@property (nonatomic, assign) IBInspectable CGFloat imageTitleGap;

@end
