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
#import "WBPublishMenuView.h"

@interface MainViewController ()<RDVTabBarControllerDelegate>

@property (nonatomic, strong) WBPublishMenuView *menuView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createViewControllers];
    self.tabBar.frame = CGRectMake(0, 0, KWidth, 44);
    NSArray *titles = @[@"首页",@"消息",@"",@"发现",@"我"];
    NSArray *icons = @[@"tabbar_home",@"tabbar_message_center",@"",@"tabbar_discover",@"tabbar_profile"];
    for (int i = 0; i < self.tabBar.items.count; i++) {
        if (i == 2) {
            RDVTabBarItem *item = self.tabBar.items[2];
            item.backgroundColor = [UIColor whiteColor];

            [item setBackgroundSelectedImage:[UIImage imageNamed:@"tabbar_compose_button"] withUnselectedImage:[UIImage imageNamed:@"tabbar_compose_button"]];
            UIImageView *add = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] highlightedImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"]];
            [item addSubview:add];
            [add mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(item);
            }];
            
        } else {
            RDVTabBarItem *item = self.tabBar.items[i];
            item.badgeTextFont = [UIFont systemFontOfSize:8];
            item.badgePositionAdjustment = UIOffsetMake(-3, 0);
            NSDictionary *unselectedTitleAttributes = @{NSForegroundColorAttributeName: [UIColor hx_colorWithHexRGBAString:WBTabBarunSelectedColor],NSFontAttributeName:[UIFont systemFontOfSize:10]};
            NSDictionary *selectedTitleAttributes = @{NSForegroundColorAttributeName:[UIColor hx_colorWithHexRGBAString:WBTabBarSelectedColor],NSFontAttributeName:[UIFont systemFontOfSize:10]};
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

- (void)tabBar:(RDVTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index {
    [super tabBar:tabBar didSelectItemAtIndex:index];
    if (index == 2) {
        self.menuView = [[WBPublishMenuView alloc] init];
        [self.view addSubview:self.menuView];
        [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        [self.menuView showMenuInView:self.view];
    }
}

- (BOOL)tabBar:(RDVTabBar *)tabBar shouldSelectItemAtIndex:(NSInteger)index {
    if (index == 2) {
        return YES;
    }
    return [super tabBar:tabBar shouldSelectItemAtIndex:index];
}




@end
