//
//  MoreTableViewCell.h
//  Weibo
//
//  Created by oahgnehzoul on 15/8/21.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
#import "ThemeLabel.h"
@interface MoreTableViewCell : UITableViewCell


@property (nonatomic,strong) ThemeImageView *themeImageView;

@property (nonatomic,strong) ThemeLabel *themeTextLabel;
@property (nonatomic,strong) ThemeLabel *themeDetailLabel;
@end
