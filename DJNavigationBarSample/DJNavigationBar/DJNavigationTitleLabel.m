//
//  DJNavigationTitleLabel.m
//  DJNavigationBarSample
//
//  Created by DJ on 2018/5/4.
//  Copyright © 2018年 DennisDeng. All rights reserved.
//

#import "DJNavigationTitleLabel.h"

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
    }
    
    return self;
}

- (void)tintColorDidChange
{
    self.textColor = self.tintColor;
}

@end
