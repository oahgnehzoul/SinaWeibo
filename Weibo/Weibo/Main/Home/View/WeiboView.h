//
//  WeiboView.h
//  Weibo
//
//  Created by oahgnehzoul on 15/8/24.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
#import "WeiboViewLaoutFrame.h"
#import "WXLabel.h"
#import "ZoomImageView.h"
@interface WeiboView : UIView<WXLabelDelegate>

@property (nonatomic,strong) WXLabel *textLabel;//微博文字
@property (nonatomic,strong) WXLabel *sourceLabel;  //转发的微博文字
@property (nonatomic,strong) ZoomImageView *imageView;//微博图片
@property (nonatomic,strong) ThemeImageView *bgImageView; //转发的背景图片


@property (nonatomic,strong) WeiboViewLaoutFrame *layoutFrame;//weiboView的布局
@end
