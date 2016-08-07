//
//  ProfileView.h
//  Weibo
//
//  Created by oahgnehzoul on 15/9/1.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
@interface ProfileView : UIView


//@property (nonatomic,strong) UIImageView *iconImageView;
//@property (nonatomic,strong) UILabel *nameLabel;
//@property (nonatomic,strong) UILabel *sexLabel;
//@property (nonatomic,strong) UILabel *locationLabel;
//@property (nonatomic,strong) UILabel *descriptionLabel;
//@property (nonatomic,strong) UIButton *friendsCountBtn;
//@property (nonatomic,strong) UIButton *fensCountBtn;
//@property (nonatomic,strong) UIButton *dataBtn;
//@property (nonatomic,strong) UIButton *moreBtn;


@property (nonatomic,strong) UserModel *userModel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendsCount;

@property (weak, nonatomic) IBOutlet UILabel *fensCount;
@property (weak, nonatomic) IBOutlet UIButton *friendsBtn;

@property (weak, nonatomic) IBOutlet UIButton *fensBtn;
@property (weak, nonatomic) IBOutlet UIButton *dataBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@end
