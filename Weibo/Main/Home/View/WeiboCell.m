//
//  WeiboCell.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/22.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "WeiboCell.h"
#import "UIImageView+WebCache.h"
#import "Utils.h"
@implementation WeiboCell

- (void)awakeFromNib {
    self.weiboView = [[WeiboView alloc] initWithFrame:CGRectZero];
    self.weiboView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.weiboView];
    self.backgroundColor = [UIColor clearColor];
    [self setNeedsLayout];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)setLayoutFrame:(WeiboViewLaoutFrame *)layoutFrame {
    if (_layoutFrame != layoutFrame) {
        _layoutFrame = layoutFrame;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    WeiboModel *model = self.layoutFrame.weiboModel;
    NSURL *url = [NSURL URLWithString:model.userModel.profile_image_url];
    [self.headImageView sd_setImageWithURL:url];
    self.userName.text = model.userModel.screen_name;
    self.commentLabel.text = [NSString stringWithFormat:@"评论:%@",model.commentsCount];
    self.repostsLabel.text = [NSString stringWithFormat:@"转发:%@",model.repostsCount];

    if ([model.source isEqualToString:@""]) {
        self.sourceLabel.text = @" ";
    }else {
        self.sourceLabel.text = [NSString stringWithFormat:@"来自%@",model.source];
    }
    self.sourceLabel.colorName = @"Timeline_Time_color";
    self.commentLabel.colorName = @"Timeline_Name_color";
    self.repostsLabel.colorName = @"Timeline_Name_color";
    self.userName.colorName = @"Timeline_Name_color";
    NSString *str = [Utils weiboDateString:model.createDate];
    self.creatTime.text = str;
    self.creatTime.colorName = @"Timeline_Time_color";
    self.weiboView.frame = self.layoutFrame.frame;
    self.weiboView.layoutFrame = self.layoutFrame;


}



@end
