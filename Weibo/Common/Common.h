//
//  Common.h
//  Weibo
//
//  Created by oahgnehzoul on 15/8/19.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#ifndef Weibo_Common_h
#define Weibo_Common_h

#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

// weibo \
名称：We1boo
#define kAppKey             @"2950451531"
#define kAppSecret          @"47c81a11f382e70cec06d576e324d45b"
#define kAppRedirectURI     @"https://api.weibo.com/oauth2/default.html"

//系统版本
#define   kVersion   [[UIDevice currentDevice].systemVersion floatValue]


#define remindCount @"remind/unread_count.json"
#define SendWeibo @"https://api.weibo.com/2/statuses/update.json"
#define SendWeiboWithImage @"https://upload.api.weibo.com/2/statuses/upload.json"
#define geo_to_address @"https://api.weibo.com/2/location/geo/geo_to_address.json"

#define near_by @"place/nearby/pois.json"
#define userInformation @"users/show.json"

#define getWeibo @"statuses/user_timeline.json"
#define getFansData @"friendships/followers.json"

#define nearby_timeline @"https://api.weibo.com/2/place/nearby_timeline.json"

//colors
#define WBTabBarSelectedColor @"#fd8224"
#define WBTabBarunSelectedColor @"#797979"

#endif
