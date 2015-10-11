//
//  WeiboAnnotationView.h
//  Weibo
//
//  Created by oahgnehzoul on 15/9/4.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "WeiboAnnotation.h"
#import "WeiboModel.h"
@interface WeiboAnnotationView : MKAnnotationView{
    UIImageView *_userHeadImageView;//头像图片
    UILabel *_textLabel;//微博内容
}


@end
