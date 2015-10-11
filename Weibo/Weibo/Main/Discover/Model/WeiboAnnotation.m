//
//  WeiboAnnotation.m
//  Weibo
//
//  Created by oahgnehzoul on 15/9/4.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "WeiboAnnotation.h"

@implementation WeiboAnnotation


- (void)setWeiboModel:(WeiboModel *)weiboModel{
    _weiboModel = weiboModel;
    NSDictionary *geo = weiboModel.geo;
    
    
    NSArray *coordinates = [geo objectForKey:@"coordinates"];
    if (coordinates.count >= 2) {
        
        NSString *longitude = coordinates[0];
        NSString *latitude = coordinates[1];
        
        _coordinate = CLLocationCoordinate2DMake([longitude floatValue], [latitude floatValue]);
    }
}


@end
