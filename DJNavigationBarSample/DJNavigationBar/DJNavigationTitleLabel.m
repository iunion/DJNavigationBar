//
//  DJNavigationTitleLabel.m
//  DJNavigationBarSample
//
//  Created by DJ on 2018/5/4.
//  Copyright © 2018年 DennisDeng. All rights reserved.
//

#import "DJNavigationTitleLabel.h"

#define BMNAVIGATIONTITLE_WIDTH     180.0f

@implementation DJNavigationTitleLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.font = [UIFont boldSystemFontOfSize:18.0f];
        //self.font = [UIFont systemFontOfSize:16.0f weight:UIFontWeightSemibold];
        self.minimumScaleFactor = 0.5f;
        self.adjustsFontSizeToFitWidth = YES;
        self.backgroundColor = [UIColor clearColor];
        self.contentMode = UIViewContentModeTop;
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = nil;//[UIColor whiteColor];
        self.tintColor = [UIColor whiteColor];
        CGRect frame = self.frame;
        frame.size.width = BMNAVIGATIONTITLE_WIDTH;
        self.frame = frame;
    }
    
    return self;
}

- (void)tintColorDidChange
{
    self.textColor = self.tintColor;
}

@end
