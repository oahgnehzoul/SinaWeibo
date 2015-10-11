//
//  BaseNavController.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/19.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "BaseNavController.h"
#import "ThemeManger.h"
#import "UIViewController+MMDrawerController.h"
@interface BaseNavController ()

@end

@implementation BaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadImage];
}



-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNofication object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeAction:) name:kThemeDidChangeNofication object:nil];
    }
    return self;
}

- (void)themeDidChangeAction:(NSNotification *)notification {
    
    [self loadImage];
}
- (void)loadImage {
    ThemeManger *manager = [ThemeManger shareInstance];
    NSString *imageName = @"mask_titlebar64.png";
    UIImage *bgImage = [manager getImage:imageName];
    [self.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    
    UIColor *titleColor = [manager getThemeColor:@"Mask_Title_color"];
    NSDictionary *attributes = @{NSForegroundColorAttributeName:titleColor};
    self.navigationBar.titleTextAttributes = attributes;
    
    //返回按钮的颜色
    self.navigationBar.tintColor = titleColor;
    
    UIImage *image = [manager getImage:@"bg_home.jpg"];
//    self.view.contentMode = UIViewContentModeScaleAspectFill;
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}


@end
