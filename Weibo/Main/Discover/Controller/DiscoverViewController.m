//
//  DiscoverViewController.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/19.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "DiscoverViewController.h"
#import "NearViewController.h"
@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发现";
}
- (IBAction)getWeiboAction:(id)sender {
    NearViewController *vc = [[NearViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
