//
//  MainViewController.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/19.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "MainViewController.h"
#import "BaseNavController.h"
#import "ThemeButton.h"
#import "AppDelegate.h"
#import "ThemeImageView.h"
#import "SinaWeibo.h"
#import "ThemeLabel.h"
#import "MBProgressHUD.h"
#import "RDVTabBarItem.h"
#import "ThemeManger.h"
@interface MainViewController ()
{
    ThemeImageView *_tabBarBackView;
    ThemeImageView *_selectImageView;
    ThemeImageView *_badgeView;
    ThemeLabel *_badgeLabel;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createViewControllers];
    [self setTabBarItems];
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

- (void)setTabBarItems {
    if (!_tabBarBackView) {
        _tabBarBackView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 49)];
        _tabBarBackView.imgName = @"mask_navbar.png";
        [self.tabBar.backgroundView addSubview:_tabBarBackView];
    }
    NSUInteger index = 0;
    NSArray *images = @[ @"home_tab_icon_1.png",
                         @"home_tab_icon_4.png",
                         @"home_tab_icon_3.png",
                         @"home_tab_icon_5.png"
                         ];
    for (RDVTabBarItem *item in [self.tabBar items]) {
        UIImage *image = [[ThemeManger shareInstance] getImage:images[index]];
        [item setFinishedSelectedImage:image withFinishedUnselectedImage:image];
        index++;
    }
    if (!_selectImageView) {
        _selectImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, KWidth / images.count, 49)];
        _selectImageView.imgName = @"home_bottom_tab_arrow.png";
        [self.tabBar addSubview:_selectImageView];
    }
}

- (void)timerAction {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaweibo = delegate.sinaweibo;
    [sinaweibo requestWithURL:remindCount params:nil httpMethod:@"GET" delegate:self];
}

- (void)createViewControllers {
    //,@"Message"
    NSArray *storyboardNames = @[@"Home",@"Profile",@"Discover",@"More"];
    NSMutableArray *ViewControllers = [[NSMutableArray alloc] init];
    for (NSString *name in storyboardNames) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:name bundle:nil];
        BaseNavController *nav = [storyBoard instantiateInitialViewController];
        [ViewControllers addObject:nav];
    }

    self.viewControllers = ViewControllers;

}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    [UIView animateWithDuration:.2 animations:^{
        _selectImageView.center = self.tabBar.selectedItem.center;
    }];
    if (selectedIndex == 0) {
        _selectImageView.center = CGPointMake(KWidth / 8, 49 / 2);
    }

}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    CGFloat tabBarButtonWidth = KWidth / 4;
    if (_badgeView == nil) {
        _badgeView = [[ThemeImageView alloc] initWithFrame:CGRectMake(tabBarButtonWidth - 32, 0, 32, 32)];
        _badgeView.imgName = @"number_notify_9.png";
        [self.tabBar addSubview:_badgeView];
        
        _badgeLabel = [[ThemeLabel alloc] initWithFrame:_badgeView.bounds];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.backgroundColor = [UIColor clearColor];
        _badgeLabel.colorName = @"Timeline_Notice_color";
        [_badgeView addSubview:_badgeLabel];
    }
    
    NSNumber *status = [result objectForKey:@"status"];
    NSInteger count = [status integerValue];

    if (count > 0) {
        _badgeView.hidden = NO;
        if (count >= 100) {
            count = 99;
        }
        _badgeLabel.text = [NSString stringWithFormat:@"%ld",count];

    }else {
        _badgeView.hidden = YES;
    }
}


@end
