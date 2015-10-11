//
//  HeaderView.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/28.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "HeaderView.h"
#import "UIImageView+WebCache.h"
@implementation HeaderView

- (void)setWeiboModel:(WeiboModel *)weiboModel {
    _weiboModel = weiboModel;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    NSString *urlStr = self.weiboModel.userModel.profile_image_url;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    self.nameLabel.text = self.weiboModel.userModel.screen_name;
    if (![self.weiboModel.source isEqualToString:@""]) {
        self.sourceLabel.text = [NSString stringWithFormat:@"来自:%@",self.weiboModel.source];
    }else {
        self.sourceLabel.text = @"";
    }
    
}

@end
