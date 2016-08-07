//
//  WeiboCell.h
//  Weibo
//
//  Created by oahgnehzoul on 15/8/22.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "WeiboViewLaoutFrame.h"
#import "WeiboView.h"
#import "ThemeLabel.h"
@interface WeiboCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet ThemeLabel *userName;

@property (weak, nonatomic) IBOutlet ThemeLabel *creatTime;

@property (weak, nonatomic) IBOutlet ThemeLabel *commentLabel;
@property (weak, nonatomic) IBOutlet ThemeLabel *repostsLabel;
@property (weak, nonatomic) IBOutlet ThemeLabel *sourceLabel;
//@property (weak, nonatomic) IBOutlet UILabel *favoritedLabel;

@property (nonatomic,strong) WeiboViewLaoutFrame *layoutFrame;
@property (nonatomic,strong) WeiboView *weiboView;
@end
