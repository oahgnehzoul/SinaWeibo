//
//  DetailWeiboViewController.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/28.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "DetailWeiboViewController.h"
#import "WeiboView.h"
#import "HeaderView.h"
#import "CommentTableView.h"
#import "WeiboViewLaoutFrame.h"
#import "AppDelegate.h"
#import "CommentModel.h"
#import "MJRefresh.h"
@interface DetailWeiboViewController ()
{
    UIView *_topView;
    HeaderView *_headerView;
    CommentTableView *_commentTableView;
}
@end

@implementation DetailWeiboViewController
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"微博详情";
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"微博详情";
    }
    return self;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self _createTopView];
    [self _createCommentTableView];
    [self _loadCommentData];
}

- (void)_createTopView {
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KWidth, 0)];
    [self.view addSubview:_topView];
    
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
    _headerView = [views lastObject];
    _headerView.frame = CGRectMake(0, 0, KWidth, 100);
    _headerView.backgroundColor = [UIColor clearColor];
    _headerView.weiboModel = self.model;
    
    [_topView addSubview:_headerView];
    

    WeiboView *_weiboView = [[WeiboView alloc] init];
    _weiboView.layoutFrame = self.layoutFrame;
    CGRect frame = self.layoutFrame.frame;
    CGFloat height = frame.size.height;
    _weiboView.frame = CGRectMake(_headerView.headImageView.right, _headerView.sourceLabel.bottom + 5, KWidth - _headerView.nameLabel.left, height );
    _topView.frame = CGRectMake(0, 0, KWidth, height+50);
    [_topView addSubview:_weiboView];
}


//创建tableView
- (void)_createCommentTableView {
    _commentTableView = [[CommentTableView alloc] initWithFrame:self.view.bounds];
    _commentTableView.tableHeaderView = _topView;
    _commentTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_commentTableView];
    _commentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _commentTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

}
- (void)loadNewData {
    

    
    SinaWeibo *sinaweibo = [self sinaweibo];
    
    CommentModel *model = [_data firstObject];

    NSString *weiboId = self.model.weiboIdStr;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@"10" forKey:@"count"];
    [params setValue:model.idstr forKey:@"since_id"];
    [params setValue:sinaweibo.accessToken forKey:@"access_token"];
    [params setValue:weiboId  forKey:@"id"];
    //获取微博
    SinaWeiboRequest *request = [sinaweibo requestWithURL:@"comments/show.json"
                                                   params:params
                                               httpMethod:@"GET"
                                                 delegate:self];
    request.tag = 101;
}
- (void)loadMoreData {
    SinaWeibo *sinaweibo = [self sinaweibo];
    CommentModel *model = [self.data lastObject];
    
    if (model == nil) {
        return;
    }
    NSString *maxId = model.idstr;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *weiboId = self.model.weiboIdStr;
    [params setValue:weiboId  forKey:@"id"];
    [params setValue:maxId forKey:@"max_id"];
    //获取微博
    SinaWeiboRequest *request = [sinaweibo requestWithURL:@"comments/show.json"
                                                   params:params
                                               httpMethod:@"GET"
                                                 delegate:self];
    request.tag = 102;
}


//设置AppDelegate为代理
- (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}
- (void)_loadCommentData {
    SinaWeibo *sinaweibo = [self sinaweibo];

   
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

    NSString *weiboId = self.model.weiboIdStr;
    [params setValue:@"10" forKey:@"count"];
    [params setValue:weiboId  forKey:@"id"];
    //获取微博
    SinaWeiboRequest *request = [sinaweibo requestWithURL:@"comments/show.json"
                                                   params:params
                                               httpMethod:@"GET"
                                                 delegate:self];
    request.tag = 100;

}





#pragma mark - sinaWeiboRequestDelegate
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"请求失败%@",error);
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    
    NSArray *comments = [result objectForKey:@"comments"];
    NSMutableArray *commentModelArray = [[NSMutableArray alloc] initWithCapacity:comments.count];
    
    for (NSDictionary *dataDic in comments) {
        CommentModel *commentModel = [[CommentModel alloc] initWithDataDic:dataDic];
        [commentModelArray addObject:commentModel];
    }
    
    if (request.tag == 100) {
            self.data = commentModelArray;
    }
    if (request.tag == 101) {
        if (commentModelArray.count > 0) {
            NSRange range = NSMakeRange(0, commentModelArray.count);
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
            [_data insertObjects:commentModelArray atIndexes:indexSet];
        }
    }
    if (request.tag == 102) {
        
        if (commentModelArray.count > 1) {
            [_commentTableView.mj_footer endRefreshing];
            [commentModelArray removeObjectAtIndex:0];
            [self.data addObjectsFromArray:commentModelArray];
        }
    }
    
    _commentTableView.commentModelArray = self.data;
    _commentTableView.commentDic = result;
    [_commentTableView reloadData];
    
    
    [_commentTableView.mj_header endRefreshing];
    [_commentTableView.mj_footer endRefreshing];
   
}




@end
