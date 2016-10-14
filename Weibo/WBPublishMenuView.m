//
//  WBPublishMenuView.m
//  Weibo
//
//  Created by oahgnehzoul on 16/10/14.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "WBPublishMenuView.h"
typedef NS_ENUM(NSUInteger,WBPublishButtonType) {
    WBPublishButtonTypeIdea = 0,
    WBPublishButtonTypePhoto = 1,
    WBPublishButtonTypeHeadline = 2,
    WBPublishButtonTypeLbs = 3,
    WBPublishButtonTypeVideo = 4,
    WBPublishButtonTypeMore = 5,
    WBPublishButtonTypeReview,
    WBPublishButtonTypeFriend,
    WBPublishButtonTypeMusic,
    WBPublishButtonTypeShooting,
    WBPublishButtonTypeBonous,
    WBPublishButtonTypeProduct
};
const static CGFloat buttonWidth = 73;
@interface WBPublishMenuView ()

@property (nonatomic, strong) UIButton *ideaButton;
@property (nonatomic, strong) UIButton *photoButton;
@property (nonatomic, strong) UIButton *headlineButton;
@property (nonatomic, strong) UIButton *lbsButton;
@property (nonatomic, strong) UIButton *videoButton;
@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic, strong) UIView *bottomBar;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation WBPublishMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#f4f3f1" alpha:0.8];
        if (!_bottomBar) {
            _bottomBar = [[UIView alloc] init];
            _bottomBar.backgroundColor = [UIColor whiteColor];
            [self addSubview:_bottomBar];
        }
        [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(KWidth, 44));
            make.left.bottom.equalTo(self);
        }];
        if (!_closeButton) {
            _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_closeButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_background_icon_close"] forState:UIControlStateNormal];
            _closeButton.transform = CGAffineTransformRotate(CGAffineTransformIdentity, -M_PI_4);
            [_bottomBar addSubview:_closeButton];
        }
        [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.bottomBar);
        }];
        __weak WBPublishMenuView *weakSelf = self;
        [self.closeButton bk_addEventHandler:^(id sender) {
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.closeButton.transform = CGAffineTransformRotate(CGAffineTransformIdentity, -M_PI_4);
                [UIView animateWithDuration:0.5 delay:0.2 usingSpringWithDamping:0.75 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    _ideaButton.centerY += KHeight / 2;
                    _lbsButton.centerY += KHeight / 2;
                } completion:^(BOOL finished) {
                    self.hidden = YES;
                }];
                
                [UIView animateWithDuration:0.6 delay:0.1 usingSpringWithDamping:0.75 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    _photoButton.centerY += KHeight / 2;
                    _videoButton.centerY += KHeight / 2;
                } completion:^(BOOL finished) {
                    
                }];
                [UIView animateWithDuration:0.25 delay:0.0 usingSpringWithDamping:0.75 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    _headlineButton.centerY += KHeight / 2;
                    _moreButton.centerY += KHeight / 2;
                } completion:^(BOOL finished) {
                }];

            } completion:^(BOOL finished) {
                weakSelf.hidden = YES;
            }];
           
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)addButtons {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.closeButton.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {

    }];
    CGFloat paddingA = (KWidth - buttonWidth * 3) * 3 / 7 / 2;
    CGFloat paddingB = (KWidth - buttonWidth * 3) * 4 / 7 / 2;
    CGFloat paddingC = 100;
    if (!_ideaButton) {
        _ideaButton = [self buttonWithTypeName:WBPublishButtonTypeIdea];
        _ideaButton.center = CGPointMake(paddingA + buttonWidth / 2, KHeight + buttonWidth / 2);
        [self addSubview:_ideaButton];
    }
    if (!_photoButton) {
        _photoButton = [self buttonWithTypeName:WBPublishButtonTypePhoto];
        _photoButton.center = CGPointMake(paddingA + buttonWidth * 3 / 2 + paddingB, KHeight + buttonWidth / 2);
        [self addSubview:_photoButton];
    }
    if (!_headlineButton) {
        _headlineButton = [self buttonWithTypeName:WBPublishButtonTypeHeadline];
        _headlineButton.center = CGPointMake(paddingA + paddingB * 2 + buttonWidth * 5 / 2, KHeight + buttonWidth / 2);
        [self addSubview:_headlineButton];
    }
    if (!_lbsButton) {
        _lbsButton = [self buttonWithTypeName:WBPublishButtonTypeLbs];
        _lbsButton.center = CGPointMake(_ideaButton.centerX, _ideaButton.centerY + paddingC)
        ;
        [self addSubview:_lbsButton];
    }
    if (!_videoButton) {
        _videoButton = [self buttonWithTypeName:WBPublishButtonTypeVideo];
        _videoButton.center = CGPointMake(_photoButton.centerX, _photoButton.centerY + paddingC);
        [self addSubview:_videoButton];
    }
    if (!_moreButton) {
        _moreButton = [self buttonWithTypeName:WBPublishButtonTypeMore];
        _moreButton.center = CGPointMake(_headlineButton.centerX, _headlineButton.centerY + paddingC);
        [self addSubview:_moreButton];
    }
    
    // damping: 动画阻尼值，摩擦力大小 0.0-1.0,越小，弹动幅度越大 \
    initialSpringVelocity  弹簧动画速率/动力，动力越小，幅度越小，0表示忽略该属性
    [UIView animateWithDuration:0.6 delay:0.0 usingSpringWithDamping:0.75 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _ideaButton.centerY -= KHeight / 2;
        _lbsButton.centerY -= KHeight / 2;
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.6 delay:0.1 usingSpringWithDamping:0.75 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _photoButton.centerY -= KHeight / 2;
        _videoButton.centerY -= KHeight / 2;
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.6 delay:0.2 usingSpringWithDamping:0.75 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _headlineButton.centerY -= KHeight / 2;
        _moreButton.centerY -= KHeight / 2;
    } completion:^(BOOL finished) {
        
    }];

}

- (UIButton *)buttonWithTypeName:(WBPublishButtonType)type {
    NSArray *buttonNames = @[
                             @"tabbar_compose_idea",
                             @"tabbar_compose_photo",
                             @"tabbar_compose_headlines",
                             @"tabbar_compose_lbs",
                             @"tabbar_compose_video",
                             @"tabbar_compose_more",
                             ];
    NSArray *titles = @[
                        @"文字",@"照片/视频",@"头条文章",@"签到",@"直播",@"更多"
                        ];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:buttonNames[type]] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, buttonWidth * KWidth / 375, buttonWidth * KWidth / 375);
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:titles[type]];
    [attrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor hx_colorWithHexRGBAString:@"#666465"]} range:NSMakeRange(0, attrStr.length)];
    [button setAttributedTitle:attrStr forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake((11 / 2.0) * KWidth - 1670, 0, 0, 0);
    button.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, 0);
    return button;
}

- (void)showMenuInView:(UIView *)view {
    [view addSubview:self];
    [self addButtons];
}


@end
