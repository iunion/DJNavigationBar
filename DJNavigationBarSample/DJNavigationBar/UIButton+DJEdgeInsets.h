//
//  UIButton+DJEdgeInsets.h
//  BMBasekit
//
//  Created by DennisDeng on 15/7/20.
//  Copyright (c) 2015年 DennisDeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DJButtonEdgeInsetsStyle)
{
    DJButtonEdgeInsetsStyleImageLeft,
    DJButtonEdgeInsetsStyleImageRight,
    DJButtonEdgeInsetsStyleImageTop,
    DJButtonEdgeInsetsStyleImageBottom
};

@interface UIButton (DJEdgeInsets)

- (void)bm_layoutButtonWithEdgeInsetsStyle:(DJButtonEdgeInsetsStyle)style imageTitleGap:(CGFloat)gap;

@end
