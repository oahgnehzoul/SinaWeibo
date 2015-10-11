//
//  RightViewController.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/22.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "RightViewController.h"
#import "ThemeButton.h"
#import "SendViewController.h"
#import "BaseNavController.h"
#import "NearByViewController.h"
@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubView];
    [self setBgImage];
}


- (void)addSubView {
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 60, KHeight)];
//    subView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:subView];
    
    for (int i = 0; i < 5; i++) {
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 64+i*60, 60, 60)];
        NSString *imageName = [NSString stringWithFormat:@"newbar_icon_%d.png",i+1];
        button.nomalImageName = imageName;
        button.backgroundColor = [UIColor grayColor];
//        if (i == 0) {
//            [button addTarget:self action:@selector(writeWeibo) forControlEvents:UIControlEventTouchUpInside];
//        }
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [subView addSubview:button];
    }
    
}

- (void)btnAction:(UIButton *)btn {
    if (btn.tag == 0) {
        [self writeWeibo];
    }else if (btn.tag == 4) {
        NearByViewController *vc = [[NearByViewController alloc] init];
        BaseNavController *nav = [[BaseNavController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
    }
}
- (void)writeWeibo {
    NSLog(@"发微博");
    SendViewController *vc = [[SendViewController alloc] init];
    BaseNavController *nav = [[BaseNavController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
