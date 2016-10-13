//
//  HomeViewController.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/19.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "HomeViewController.h"
#import "ThemeManger.h"
#import "AppDelegate.h"
#import "WeiboModel.h"
#import "WeiboTableView.h"
#import "WeiboViewLaoutFrame.h"
#import "MJRefresh.h"
#import "ThemeImageView.h"
#import "ThemeLabel.h"
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
@interface HomeViewController ()
{
    WeiboTableView *_tableView;
    NSMutableArray *_dataArray;
    ThemeImageView *_barImageView;
    ThemeLabel *_barLabel;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setRootNavItem];
    
    

//    [self createTableView];
//    [self loadWeiboData];
}
/*
//创建tableView
- (void)createTableView {
    _tableView = [[WeiboTableView alloc] init];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

//设置AppDelegate为代理
- (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}
//登陆获取weibo数据
- (void)loadWeiboData {
    
    SinaWeibo *sinaweibo = [self sinaweibo];
    sinaweibo.delegate = self;
        if ([sinaweibo isAuthValid]) {
            NSLog(@"已经登陆");
            NSDictionary *params = @{@"count":@"20"};
            //获取微博
           SinaWeiboRequest *request = [sinaweibo requestWithURL:@"statuses/home_timeline.json"
                               params:[params mutableCopy]
                           httpMethod:@"GET"
                             delegate:self];
            request.tag = 100;
            [self showHUD:@"正在加载"];
            _tableView.hidden = YES;
    
        } else {
            [sinaweibo logIn];
        }

}
- (void)loadNewData {
    
    SinaWeibo *sinaweibo = [self sinaweibo];
    WeiboViewLaoutFrame *layout = [_dataArray firstObject];
    NSString *sinceId = layout.weiboModel.weiboId.stringValue;

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@"10" forKey:@"count"];
    [params setValue:sinceId forKey:@"since_id"];
    //获取微博
    SinaWeiboRequest *request = [sinaweibo requestWithURL:@"statuses/home_timeline.json"
                       params:[params mutableCopy]
                   httpMethod:@"GET"
                     delegate:self];
    request.tag = 101;
}
- (void)loadMoreData {
    SinaWeibo *sinaweibo = [self sinaweibo];
    WeiboViewLaoutFrame *layout = [_dataArray lastObject];
    NSString *maxId = layout.weiboModel.weiboId.stringValue;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@"10" forKey:@"count"];
    [params setValue:maxId forKey:@"max_id"];
    //获取微博
    SinaWeiboRequest *request = [sinaweibo requestWithURL:@"statuses/home_timeline.json"
                                                   params:[params mutableCopy]
                                               httpMethod:@"GET"
                                                 delegate:self];
    request.tag = 102;
}

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo {
    
    
    [self loadWeiboData];
    //保存认证的信息
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [_tableView reloadData];
}

//view重新刷新导航栏背景
- (void)viewWillAppear:(BOOL)animated {
    [self setRootNavItem];
}
#pragma mark - sinaWeiboRequestDelegate
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"请求失败%@",error);
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
//    NSLog(@"获得请求数据%@",result);
    
    NSArray *statuses = [result objectForKey:@"statuses"];
    NSMutableArray *layoutFrameArray = [[NSMutableArray alloc] initWithCapacity:statuses.count];
    for (NSDictionary *dataDic in statuses) {
        WeiboViewLaoutFrame *layoutFrame = [[WeiboViewLaoutFrame alloc] init];
        WeiboModel *model = [[WeiboModel alloc] initWithDataDic:dataDic];
        layoutFrame.weiboModel = model;
        [layoutFrameArray addObject:layoutFrame];
    }
    
    if (request.tag == 100) {
        if (layoutFrameArray.count) {
            _dataArray = layoutFrameArray;
            [self completeHUD:@"加载完毕"];
            _tableView.hidden = NO;
        }
    }
    if (request.tag == 101) {
        if (layoutFrameArray.count > 0) {
            NSRange range = NSMakeRange(0, layoutFrameArray.count);
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
            [_dataArray insertObjects:layoutFrameArray atIndexes:indexSet];
            [self showNewWeiboCount:layoutFrameArray.count];
        }
    }
    if (request.tag == 102) {
        if (layoutFrameArray.count > 1) {
            [layoutFrameArray removeObjectAtIndex:0];
            [_dataArray addObjectsFromArray:layoutFrameArray];
        }
    }
    

    _tableView.layoutFrameArray = _dataArray;
//    [_tableView reloadData];
    
    
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
    [_tableView reloadData];
}


- (void)showNewWeiboCount:(NSInteger)count {
    if (_barImageView == nil) {
        _barImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(5, -40, KWidth-10, 40)];
        _barImageView.imgName = @"timeline_notify.png";
        [self.view addSubview:_barImageView];
        
        _barLabel = [[ThemeLabel alloc] initWithFrame:_barImageView.bounds];
        _barLabel.colorName = @"Timeline_Notice_color";
        _barLabel.backgroundColor = [UIColor clearColor];
        _barLabel.textAlignment = NSTextAlignmentCenter;
        [_barImageView addSubview:_barLabel];
    }
    if (count > 0 ) {
         _barLabel.text = [NSString stringWithFormat:@"刷新了%ld条微博",(long)count];
        [UIView animateWithDuration:.6 animations:^{
            _barImageView.transform = CGAffineTransformMakeTranslation(0, 40+64+5);
            
        } completion:^(BOOL finished) {
            if (finished) {
                [UIView animateWithDuration:.6 animations:^{
                    [UIView setAnimationDelay:1];
                    _barImageView.transform = CGAffineTransformIdentity;
                }];
            }
        }];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"msgcome" ofType:@"wav"];
        NSURL *url = [NSURL fileURLWithPath:path];
        SystemSoundID soundId;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundId);
        AudioServicesPlaySystemSound(soundId);
    }
    
}

*/


@end
