//
//  DetailWeiboViewController.h
//  Weibo
//
//  Created by oahgnehzoul on 15/8/28.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboView.h"
#import "WeiboModel.h"
#import "WeiboViewLaoutFrame.h"
#import "SinaWeibo.h"
@interface DetailWeiboViewController : BaseViewController<SinaWeiboRequestDelegate>


@property (nonatomic,strong) WeiboViewLaoutFrame *layoutFrame;
@property (nonatomic,strong) WeiboModel *model;

@property (nonatomic,strong) NSMutableArray *data;

@end
