//
//  AppDelegate.h
//  Weibo
//
//  Created by oahgnehzoul on 15/8/19.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SinaWeibo.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//@property (strong,nonatomic) SinaWeibo *sinaweibo;
@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbRefreshToken;
@property (strong, nonatomic) NSString *wbCurrentUserID;

@end

