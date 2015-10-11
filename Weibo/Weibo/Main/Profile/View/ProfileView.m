//
//  ProfileView.m
//  Weibo
//
//  Created by oahgnehzoul on 15/9/1.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "ProfileView.h"
#import "BaseNavController.h"
#import "FansViewController.h"
@implementation ProfileView



- (void)setUserModel:(UserModel *)userModel {
    if (_userModel != userModel) {
        _userModel = userModel;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    NSURL *url = [NSURL URLWithString:self.userModel.profile_image_url];
    [self.iconImageView sd_setImageWithURL:url];
    self.nameLabel.text = self.userModel.screen_name;
    NSString *gender;
    if ([self.userModel.gender isEqualToString:@"m"]) {
        gender = @"男";
    }else if ([self.userModel.gender isEqualToString:@"f"]) {
        gender = @"女";
    }else {
        gender = @"未知";
    }
    self.locationLabel.text = [NSString stringWithFormat:@"%@  %@",gender,self.userModel.location];

    self.descriptionLabel.text = [NSString stringWithFormat:@"简介:%@",self.userModel.descriptions];
    self.descriptionLabel.numberOfLines = 0;
    self.friendsCount.text = [NSString stringWithFormat:@"%@",self.userModel.friends_count];
    self.friendsCount.textAlignment = NSTextAlignmentCenter;
    self.fensCount.text = [NSString stringWithFormat:@"%@",self.userModel.followers_count];
    self.fensCount.textAlignment = NSTextAlignmentCenter;
    
    self.friendsBtn.layer.cornerRadius = 10;
    self.fensBtn.layer.cornerRadius = 10;
    self.dataBtn.layer.cornerRadius = 10;
    self.moreBtn.layer.cornerRadius = 10;
}
- (IBAction)getFensData:(id)sender {
    NSLog(@"粉丝列表");

   
}
- (IBAction)getFriendsData:(id)sender {
    NSLog(@"关注列表");
}

@end
