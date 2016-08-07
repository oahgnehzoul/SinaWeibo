//
//  BaseViewController.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/19.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "ThemeManger.h"
#import "ThemeButton.h"
#import "MBProgressHUD.h"
#import "UIProgressView+AFNetworking.h"
@interface BaseViewController ()
{
    MBProgressHUD *_hud;
    UIWindow *_tipWindow;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
}
#pragma mark - 设置导航栏
- (void)setRootNavItem {
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    
    UIImage *leftImage = [[ThemeManger shareInstance] getImage:@"group_btn_all_on_title.png"];
    UIImage *leftBgImage = [[ThemeManger shareInstance] getImage:@"button_title.png"];
    UIImage *rightImage = [[ThemeManger shareInstance] getImage:@"button_icon_plus.png"];
    UIImage *rightBgImage = [[ThemeManger shareInstance] getImage:@"button_m.png"];
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    [leftButton setImage:leftImage forState:UIControlStateNormal];
    [leftButton setTitle:@"设置" forState:UIControlStateNormal];
    [leftButton setBackgroundImage:leftBgImage forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 90, 40)];
    [rightButton setImage:rightImage forState:UIControlStateNormal];
    [rightButton setBackgroundImage:rightBgImage forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}


- (void)leftAction {
    MMDrawerController *mmDraw = self.mm_drawerController;
    [mmDraw openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}



- (void)editAction {
    MMDrawerController *mmDraw = self.mm_drawerController;
    [mmDraw openDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    
}
#pragma mark - 状态栏显示
- (void)showStatusTip:(NSString *)title show:(BOOL)show operation:(AFHTTPRequestOperation *)operation {
    if (_tipWindow == nil) {
        _tipWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, KWidth, 20)];
        _tipWindow.windowLevel = UIWindowLevelStatusBar;
        _tipWindow.backgroundColor = [UIColor blackColor];
        
        UILabel *tpLabel = [[UILabel alloc] initWithFrame:_tipWindow.bounds];
        tpLabel.backgroundColor = [UIColor clearColor]
        ;
        tpLabel.font = [UIFont systemFontOfSize:13.0f];
        tpLabel.textColor = [UIColor whiteColor];
        tpLabel.tag = 100;
        [_tipWindow addSubview:tpLabel];
        
        UIProgressView *progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        progress.frame = CGRectMake(0, 17, KWidth, 5);
        progress.progress = 0.0;
        progress.tag = 101;
        [_tipWindow addSubview:progress];
    }
    
    UILabel *tpLabel = (UILabel *)[_tipWindow viewWithTag:100];
    tpLabel.text = title;
    
    UIProgressView *progressView = (UIProgressView *)[_tipWindow viewWithTag:101];
    if (show) {
        _tipWindow.hidden = NO;
        if (operation) {
            progressView.hidden = NO;
            [progressView setProgressWithUploadProgressOfOperation:operation animated:YES];
        }else {
            progressView.hidden = YES;
        }
    }else {
        [self performSelector:@selector(removeTipWindow) withObject:nil afterDelay:1];
    }
}

- (void)removeTipWindow {
//    [_tipWindow removeFromSuperview];
    _tipWindow.hidden = YES;
    _tipWindow = nil;
    
}
#pragma mark - 使用第三方库实现加载提示

- (void)showHUD:(NSString *)title {
    if (_hud == nil) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
    }
    [_hud show:YES];
    _hud.labelText = title;
    
    _hud.dimBackground = YES;
}

- (void)hideHUD {
    [_hud hide:YES];
}

- (void)completeHUD:(NSString *)title {
    _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    _hud.mode = MBProgressHUDModeCustomView;
    _hud.labelText = title;
    [_hud hide:YES afterDelay:1.5];
}
#pragma -mark 设置背景图片
- (void)setBgImage{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_loadImage) name:kThemeDidChangeNofication object:nil];
    
    [self _loadImage];
}
- (void)_loadImage{
    
    ThemeManger *manager = [ThemeManger shareInstance];
    UIImage *img = [manager getImage:@"bg_home.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:img];
    
}


@end
