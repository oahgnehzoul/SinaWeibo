//
//  ProfileViewController.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/19.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileView.h"
#import "WeiboView.h"
#import "WeiboTableView.h"
#import "MJRefresh.h"
#import "DataService.h"
#import "WeiboCell.h"
#import "SinaWeiboRequest.h"
#import "AppDelegate.h"
#import "FansViewController.h"
@interface ProfileViewController ()

@end

@implementation ProfileViewController
{
    UserModel *_userModel;
    WeiboTableView *_tableView;
    ProfileView *_headView;
    NSMutableArray *_layoutFrameArray;
    NSMutableArray *_dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadUserData];
    [self _loadWeiboData];
    [self _createHeaderView];
    [self _createTableView];
    
}


- (void)_createHeaderView {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"Profile" owner:self options:nil];
    _headView = [views lastObject];
    _headView.frame = CGRectMake(0, 64, KWidth, 200);
    [_headView.fensBtn addTarget:self action:@selector(getFans) forControlEvents:UIControlEventTouchUpInside];
    _headView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_headView];
}
- (void)getFans {
//    NSLog(@"1");
    FansViewController *vc = [[FansViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)_createTableView {
//    _tableView = [[WeiboTableView alloc]initWithFrame:CGRectMake(0, 64, KWidth, KHeight-64-49)];
#ifdef debug
    _tableView = [[WeiboTableView alloc] initWithFrame:CGRectMake(0, 64, KWidth, KHeight-64-49)];
#else
    _tableView = [[WeiboTableView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight)];
#endif

    _tableView.tableHeaderView = _headView;
//    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewWeibo)];
//    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreWeibo)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UINib *nib = [UINib nibWithNibName:@"WeiboCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}
- (void)loadNewWeibo {
    
}
- (void)loadMoreWeibo {
    
}
- (void)loadUserData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    NSString *weiboId = [sinaweiboInfo objectForKey:@"UserIDKey"];
    [params setValue:weiboId forKey:@"uid"];
    [DataService requestUrl:userInformation httpMethod:@"GET" params:params block:^(id result) {
//        NSLog(@"%@",result);
        _userModel = [[UserModel alloc] initWithDataDic:result];
//        NSLog(@"%@",_userModel.screen_name);
        _headView.userModel = _userModel;
    }];
}
- (void)_loadWeiboData {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
//    NSString *accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [DataService requestUrl:getWeibo httpMethod:@"GET" params:params block:^(id result) {
////        NSLog(@"%@",result);
//        NSArray *statuses = [result objectForKey:@"statuses"];
//        _layoutFrameArray = [[NSMutableArray alloc] initWithCapacity:statuses.count];
//        for (NSDictionary *dataDic in statuses) {
//            WeiboViewLaoutFrame *layoutFrame = [[WeiboViewLaoutFrame alloc] init];
//            WeiboModel *model = [[WeiboModel alloc] initWithDataDic:dataDic];
//            layoutFrame.weiboModel = model;
//            [_layoutFrameArray addObject:layoutFrame];
//        }
//    }];
//    NSLog(@"%@",_layoutFrameArray);
//    _tableView.layoutFrameArray = _layoutFrameArray;
    SinaWeibo *sinaweibo = [self sinaweibo];
    SinaWeiboRequest *request = [sinaweibo requestWithURL:getWeibo params:params httpMethod:@"GET" delegate:self];
    request.tag = 100;
    [_tableView reloadData];
    
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    NSArray *statuses = [result objectForKey:@"statuses"];
    _layoutFrameArray = [[NSMutableArray alloc] initWithCapacity:statuses.count];
    for (NSDictionary *dataDic in statuses) {
        WeiboViewLaoutFrame *layoutFrame = [[WeiboViewLaoutFrame alloc] init];
        WeiboModel *model = [[WeiboModel alloc] initWithDataDic:dataDic];
        layoutFrame.weiboModel = model;
        [_layoutFrameArray addObject:layoutFrame];
    }
    if (request.tag == 100) {
        if (_layoutFrameArray.count) {
            _dataArray = _layoutFrameArray;
        }
    }
    _tableView.layoutFrameArray = _layoutFrameArray;
    [_tableView reloadData];
}
//设置AppDelegate为代理
- (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}
#pragma mark - UItableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"count:%ld",_layoutFrameArray.count);
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.layoutFrame = _layoutFrameArray[indexPath.row];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeiboViewLaoutFrame *layoutFrame = _layoutFrameArray[indexPath.row];
    CGRect frame = layoutFrame.frame;
    CGFloat height = frame.size.height;
    return height + 72;

}
@end