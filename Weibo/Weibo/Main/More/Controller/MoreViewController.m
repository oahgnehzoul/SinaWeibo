//
//  MoreViewController.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/19.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreTableViewCell.h"
#import "ThemeTableViewController.h"
#import "ThemeManger.h"
#import "AppDelegate.h"
@interface MoreViewController ()
{
    UITableView *_tableView;
    NSString *logStr;
    BOOL isLogin;
}
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTableView];
}

- (void)createTableView {
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWidth, KHeight) style: UITableViewStyleGrouped];
#ifdef debug
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWidth, KHeight) style:UITableViewStyleGrouped];
#else
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight) style:UITableViewStyleGrouped];
#endif

    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerClass:[MoreTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return 1;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.themeImageView.imgName = @"more_icon_theme.png";
             cell.themeTextLabel.text = @"主题选择";
            cell.themeDetailLabel.text = [ThemeManger shareInstance].themeName;
        }else {
            cell.themeImageView.imgName = @"more_icon_account.png";
            cell.themeTextLabel.text = @"账户管理";
        }
    }else if (indexPath.section == 1) {
        cell.themeTextLabel.text = @"意见反馈";
        cell.themeImageView.imgName = @"more_icon_feedback.png";
    }else {
//        cell.textLabel.text = @"登陆";
//        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        if (appDelegate.sinaweibo.isLoggedIn) {
            logStr = @"登出当前账号";
        }else {
            logStr = @"登陆";
        }
        cell.themeTextLabel.text = logStr;
        cell.themeTextLabel.center = cell.contentView.center;
        cell.themeTextLabel.textAlignment = NSTextAlignmentCenter;
//        cell.themeTextLabel.backgroundColor = [UIColor redColor];
    }
    if (indexPath.section != 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
//    cell.backgroundColor = []
//    cell.textLabel.text = @"主题选择";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (indexPath.section == 0 && indexPath.row == 0) {
        ThemeTableViewController *vc = [[ThemeTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        if (appDelegate.sinaweibo.isLoggedIn) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认登出么?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            
            [alert show];
        }else {
           
            if (appDelegate.sinaweibo.isLoggedIn) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登陆成功" message:nil delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                [alert show];
                [_tableView reloadData];
            }else {
                

                [appDelegate.sinaweibo logIn];
//                if (appDelegate.sinaweibo.isLoggedIn) {
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登陆成功" message:nil delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//                    [alert show];
//
//                }
//                NSLog(@"%@",appDelegate.sinaweibo.isLoggedIn);
                NSLog(@"11111");
               
            }
            
            
        }
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登陆成功" message:nil delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//        [alert show];
        [_tableView reloadData];


        
    }
//    [_tableView reloadData];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        [appDelegate.sinaweibo logOut];
    }
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    
    [_tableView reloadData];
}
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo {
    [_tableView reloadData];
}

@end
