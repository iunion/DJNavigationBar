//
//  DJNavigationBarDefine.h
//  DJNavigationBarSample
//
//  Created by DJ on 2018/5/3.
//  Copyright © 2018年 DennisDeng. All rights reserved.
//

#ifndef DJNavigationBarDefine_h
#define DJNavigationBarDefine_h

#ifndef IOS_VERSION
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#endif

#define UI_SCREEN_WIDTH                 ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)
#define UI_NAVIGATION_BAR_HEIGHT        44

#define DJNavigationBar_DefaultEffect  [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]

#endif /* DJNavigationBarDefine_h */
