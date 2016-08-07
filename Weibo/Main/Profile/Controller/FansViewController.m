//
//  FansViewController.m
//  Weibo
//
//  Created by oahgnehzoul on 15/9/2.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "FansViewController.h"
#import "DataService.h"
#import "UserModel.h"
@interface FansViewController ()
{
    NSMutableArray *_dataArray;
    UITableView *_tableView;
}
@end

@implementation FansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"粉丝";
//    self.navigationItem.leftBarButtonItem.title = @"我";
    [self _createTableView];
    [self _loadFansData];
//    [_tableView reloadData];

}

- (void)_createTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)_loadFansData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    NSString *weiboId = [sinaweiboInfo objectForKey:@"UserIDKey"];
    [params setValue:weiboId forKey:@"uid"];
    [DataService requestUrl:getFansData httpMethod:@"GET" params:params block:^(id result) {
//        NSLog(@"%@",result);
        NSArray *users = [result objectForKey:@"users"];
        _dataArray = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in users) {
            UserModel *userModel = [[UserModel alloc]initWithDataDic:dic];
            [_dataArray addObject:userModel];
//            NSLog(@"%li",_dataArray.count);
        }
        [_tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"%ld",_dataArray.count);
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    UserModel *model = _dataArray[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.profile_image_url]];
//    NSLog(@"%@",model.profile_image_url);
    cell.textLabel.text = model.screen_name;
   
//    NSLog(@"%@",model.profile_image_url);
    return cell;
}


@end
