//
//  ThemeTableViewController.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/21.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "ThemeTableViewController.h"
#import "MoreTableViewCell.h"
#import "ThemeManger.h"
static NSString *moreCellId = @"moreCellId";
@interface ThemeTableViewController ()
{
    NSArray *themeNameArray;
}
@end

@implementation ThemeTableViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    NSString *path = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
    NSDictionary *configDic = [NSDictionary dictionaryWithContentsOfFile:path];
    themeNameArray = [configDic allKeys];
     [self.tableView registerClass:[MoreTableViewCell class] forCellReuseIdentifier:@"cell"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return themeNameArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    cell.textLabel.text = themeNameArray[indexPath.row];  !!!!!!! 简直醉了
    cell.themeTextLabel.text = themeNameArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *themeName = themeNameArray[indexPath.row];
    [[ThemeManger shareInstance] setThemeName:themeName];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




@end
