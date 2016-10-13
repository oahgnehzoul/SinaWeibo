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
#import "ThemeLabel.h"
#import "MBProgressHUD.h"
#import "RDVTabBarItem.h"
#import "ThemeManger.h"

@interface MainViewController ()
//{
//    ThemeImageView *_tabBarBackView;
//    ThemeImageView *_selectImageView;
//    ThemeImageView *_badgeView;
//    ThemeLabel *_badgeLabel;
//}



@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createViewControllers];
//    [self setTabBarItems];
    
    NSArray *titles = @[@"首页",@"消息",@"",@"发现",@"我"];
    NSArray *icons = @[@"tabbar_home",@"tabbar_message_center",@"",@"tabbar_discover",@"tabbar_profile"];
    for (int i = 0; i < self.tabBar.items.count; i++) {
        if (i == 2) {
            RDVTabBarItem *item = self.tabBar.items[2];
            item.backgroundColor = [UIColor whiteColor];

            [item setBackgroundSelectedImage:[UIImage imageNamed:@"tabbar_compose_button"] withUnselectedImage:[UIImage imageNamed:@"tabbar_compose_button"]];
            UIImageView *add = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_compose_icon_add"]];
            [item addSubview:add];
            [add mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(item);
            }];
            
        } else {
            RDVTabBarItem *item = self.tabBar.items[i];
            item.imagePositionAdjustment = UIOffsetMake(0, -2);
            item.badgeTextFont = [UIFont systemFontOfSize:9];
            item.badgePositionAdjustment = UIOffsetMake(-3, 0);
            NSDictionary *unselectedTitleAttributes = @{NSForegroundColorAttributeName: [UIColor hx_colorWithHexRGBAString:WBTabBarunSelectedColor]};
            NSDictionary *selectedTitleAttributes = @{NSForegroundColorAttributeName:[UIColor hx_colorWithHexRGBAString:WBTabBarSelectedColor]};
            item.unselectedTitleAttributes = unselectedTitleAttributes;
            item.selectedTitleAttributes = selectedTitleAttributes;
            item.title = titles[i];
            item.backgroundColor = [UIColor whiteColor];
            UIImage *icon = [UIImage imageNamed:icons[i]];
            UIImage *selectedIcon = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected", icons[i]]];
            [item setFinishedSelectedImage:selectedIcon withFinishedUnselectedImage:icon];
        }
    }
    
}
/*
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
*/
- (void)createViewControllers {
    NSArray *storyboardNames = @[@"Home",@"Message",@"Profile",@"Discover",@"More"];
    NSMutableArray *ViewControllers = [[NSMutableArray alloc] init];
    for (NSString *name in storyboardNames) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:name bundle:nil];
        BaseNavController *nav = [storyBoard instantiateInitialViewController];
        [ViewControllers addObject:nav];
    }

    self.viewControllers = ViewControllers;

}

//- (void)setSelectedIndex:(NSUInteger)selectedIndex {
//    [super setSelectedIndex:selectedIndex];
//    [UIView animateWithDuration:.2 animations:^{
//        _selectImageView.center = self.tabBar.selectedItem.center;
//    }];
//    if (selectedIndex == 0) {
//        _selectImageView.center = CGPointMake(KWidth / 8, 49 / 2);
//    }
//
//}



@end
