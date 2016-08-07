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
@interface MainViewController ()
{
    ThemeImageView *_tabBarView;
    ThemeImageView *_selectImageView;
    ThemeImageView *_badgeView;
    ThemeLabel *_badgeLabel;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createViewControllers];
    [self createTabBarView];
    
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];

}
- (void)timerAction {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaweibo = delegate.sinaweibo;
    [sinaweibo requestWithURL:remindCount params:nil httpMethod:@"GET" delegate:self];
}

- (void)createTabBarView {
//    [self.tabBar removeFromSuperview];
    for (UIView *view in self.tabBar.subviews) {
        Class cls = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass: cls]) {
            [view removeFromSuperview];
        }
    }
    
    _tabBarView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 49)];
    _tabBarView.userInteractionEnabled = YES;
//    _tabBarView.image = [UIImage imageNamed:@"Skins/cat/mask_navbar.png"];
    _tabBarView.imgName = @"mask_navbar.png";


    [self.tabBar addSubview:_tabBarView];
    
    //  @"home_tab_icon_2.png",
    NSArray *imgNames = @[
                          @"home_tab_icon_1.png",
                          @"home_tab_icon_4.png",
                          @"home_tab_icon_3.png",
                          @"home_tab_icon_5.png",
                          ];
   
    _selectImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(13, 0, 64, 49)];
    _selectImageView.imgName = @"home_bottom_tab_arrow.png";

    [self.tabBar addSubview:_selectImageView];
    for (int i = 0; i < 4; i++) {
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(i*KWidth/4, 0, KWidth/4, 49)];
        button.nomalImageName = imgNames[i];

        button.tag = i;
        [button addTarget: self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:button];
    }

}

- (void)buttonAction:(UIButton *)btn {
    [UIView animateWithDuration:.2 animations:^{
        _selectImageView.center = btn.center;

    }];
//    [self selectAction:btn.tag];
    self.selectedIndex = btn.tag;
}
//- (void)selectAction:(NSInteger)selectIndex {
//    if (_selectIndex != selectIndex) {
//        UIViewController *lastVC = self.childViewControllers[_selectIndex];
//        UIViewController *currentVC = self.childViewControllers[selectIndex];
//        [lastVC.view removeFromSuperview];
//        [self.view insertSubview:currentVC.view belowSubview:_tabBarView];
//        _selectIndex = selectIndex;
//    }
//}
- (void)createViewControllers {
    //,@"Message"
    NSArray *storyboardNames = @[@"Home",@"Profile",@"Discover",@"More"];
    NSMutableArray *ViewControllers = [[NSMutableArray alloc] init];
    for (NSString *name in storyboardNames) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:name bundle:nil];
        BaseNavController *nav = [storyBoard instantiateInitialViewController];
//        [self addChildViewController:nav];
        [ViewControllers addObject:nav];
    }
//    UIViewController *firstVc = self.childViewControllers[0];
//    [self.view insertSubview:firstVc.view belowSubview:_tabBarView];
    self.viewControllers = ViewControllers;

}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    CGFloat tabBarButtonWidth = KWidth / 4;
    if (_badgeView == nil) {
        _badgeView = [[ThemeImageView alloc] initWithFrame:CGRectMake(tabBarButtonWidth - 32, 0, 32, 32)];
//        _badgeView.backgroundColor = [UIColor redColor];
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
        _badgeLabel.text = [NSString stringWithFormat:@"%d",count];

    }else {
        _badgeView.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
