//
//  DJNavigationButton.m
//  ODR
//
//  Created by jiang deng on 2018/6/4.
//  Copyright © 2018年 DH. All rights reserved.
//

#import "DJNavigationButton.h"
#import "DJNavigationBarDefine.h"

@implementation DJNavigationButton

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self setEdgeInsetsStyle:_edgeInsetsStyle];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self setEdgeInsetsStyle:_edgeInsetsStyle];
}

- (void)setEdgeInsetsStyle:(DJButtonEdgeInsetsStyle)edgeInsetsStyle
{
    [self setTitleEdgeInsets:UIEdgeInsetsZero];
    [self setImageEdgeInsets:UIEdgeInsetsZero];
    
    [self layoutIfNeeded];
    
    _edgeInsetsStyle = edgeInsetsStyle;
    
    CGFloat gap = self.imageTitleGap;
    CGFloat imageViewWidth = CGRectGetWidth(self.imageView.frame);
    CGFloat labelWidth = CGRectGetWidth(self.titleLabel.frame);
    
    if (labelWidth == 0)
    {
        CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
        labelWidth  = titleSize.width;
    }
    
    CGFloat imageInsetsTop = 0.0f;
    CGFloat imageInsetsLeft = 0.0f;
    CGFloat imageInsetsBottom = 0.0f;
    CGFloat imageInsetsRight = 0.0f;
    
    CGFloat titleInsetsTop = 0.0f;
    CGFloat titleInsetsLeft = 0.0f;
    CGFloat titleInsetsBottom = 0.0f;
    CGFloat titleInsetsRight = 0.0f;
    
    switch (edgeInsetsStyle)
    {
        case DJButtonEdgeInsetsStyleImageRight:
        {
            gap = gap * 0.5f;
            
            imageInsetsLeft = labelWidth + gap;
            imageInsetsRight = -imageInsetsLeft;
            
            titleInsetsLeft = -(imageViewWidth + gap);
            titleInsetsRight = -titleInsetsLeft;
        }
            break;
            
        case DJButtonEdgeInsetsStyleImageLeft:
        {
            gap = gap * 0.5f;
            
            imageInsetsLeft = -gap;
            imageInsetsRight = -imageInsetsLeft;
            
            titleInsetsLeft = gap;
            titleInsetsRight = -titleInsetsLeft;
        }
            break;
            
        case DJButtonEdgeInsetsStyleImageBottom:
        {
            CGFloat imageHeight = CGRectGetHeight(self.imageView.frame);
            CGFloat labelHeight = CGRectGetHeight(self.titleLabel.frame);
            CGFloat buttonHeight = CGRectGetHeight(self.frame);
            CGFloat boundsCentery = (imageHeight + gap + labelHeight) * 0.5f;
            
            CGFloat centerX_button = CGRectGetMidX(self.bounds); // bounds
            CGFloat centerX_titleLabel = CGRectGetMidX(self.titleLabel.frame);
            CGFloat centerX_image = CGRectGetMidX(self.imageView.frame);
            
            CGFloat imageBottomY = CGRectGetMaxY(self.imageView.frame);
            CGFloat titleTopY = CGRectGetMinY(self.titleLabel.frame);
            
            imageInsetsTop = buttonHeight - (buttonHeight * 0.5f - boundsCentery) - imageBottomY;
            imageInsetsLeft = centerX_button - centerX_image;
            imageInsetsRight = -imageInsetsLeft;
            imageInsetsBottom = -imageInsetsTop;
            
            titleInsetsTop = (buttonHeight * 0.5f - boundsCentery) - titleTopY;
            titleInsetsLeft = -(centerX_titleLabel - centerX_button);
            titleInsetsRight = -titleInsetsLeft;
            titleInsetsBottom = -titleInsetsTop;
            
        }
            break;
            
        case DJButtonEdgeInsetsStyleImageTop:
        {
            CGFloat imageHeight = CGRectGetHeight(self.imageView.frame);
            CGFloat labelHeight = CGRectGetHeight(self.titleLabel.frame);
            CGFloat buttonHeight = CGRectGetHeight(self.frame);
            CGFloat boundsCentery = (imageHeight + gap + labelHeight) * 0.5f;
            
            CGFloat centerX_button = CGRectGetMidX(self.bounds); // bounds
            CGFloat centerX_titleLabel = CGRectGetMidX(self.titleLabel.frame);
            CGFloat centerX_image = CGRectGetMidX(self.imageView.frame);
            
            CGFloat imageTopY = CGRectGetMinY(self.imageView.frame);
            CGFloat titleBottom = CGRectGetMaxY(self.titleLabel.frame);
            
            imageInsetsTop = (buttonHeight * 0.5f - boundsCentery) - imageTopY;
            imageInsetsLeft = centerX_button - centerX_image;
            imageInsetsRight = -imageInsetsLeft;
            imageInsetsBottom = -imageInsetsTop;
            
            titleInsetsTop = buttonHeight - (buttonHeight * 0.5f - boundsCentery) - titleBottom;
            titleInsetsLeft = -(centerX_titleLabel - centerX_button);
            titleInsetsRight = -titleInsetsLeft;
            titleInsetsBottom = -titleInsetsTop;
        }
            break;
            
        default:
            break;
    }
    
    self.imageEdgeInsets = UIEdgeInsetsMake(imageInsetsTop, imageInsetsLeft, imageInsetsBottom, imageInsetsRight);
    self.titleEdgeInsets = UIEdgeInsetsMake(titleInsetsTop, titleInsetsLeft, titleInsetsBottom, titleInsetsRight);
}

- (void)setImageTitleGap:(CGFloat)imageTitleGap
{
    _imageTitleGap = imageTitleGap;
    
    [self setEdgeInsetsStyle:_edgeInsetsStyle];
}

@end
