//
//  WeiboViewLaoutFrame.h
//  Weibo
//
//  Created by oahgnehzoul on 15/8/24.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboModel.h"
@interface WeiboViewLaoutFrame : NSObject


@property (nonatomic,strong) WeiboModel *weiboModel;

@property (nonatomic,assign) CGRect textFrame;//微博内容的frame
@property (nonatomic,assign) CGRect srTextFrame;//原微博内容的frame
@property (nonatomic,assign) CGRect bgImageFrame;//原微博背景图片frame
@property (nonatomic,assign) CGRect imgFrame;//微博图片frame
@property (nonatomic,assign) CGRect frame;  //整个weiboView 的frame

@property (nonatomic,assign) CGRect nameFrame;
@end
