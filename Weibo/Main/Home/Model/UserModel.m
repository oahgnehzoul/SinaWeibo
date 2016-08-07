//
//  UserModel.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/24.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
- (NSDictionary *)attributeMapDictionary {
    NSDictionary *mapAtt = @{@"descriptions":@"description",
                 @"idstr":@"idstr",
           @"screen_name":@"screen_name",
              @"location":@"location",
     @"profile_image_url":@"profile_image_url",
                @"gender":@"gender",
       @"followers_count":@"followers_count",
        @"statuses_count": @"statuses_count",
        @"friends_count":@"friends_count"
                             };
    return mapAtt;
}
@end
