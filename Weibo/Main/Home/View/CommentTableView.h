//
//  CommentTableView.h
//  Weibo
//
//  Created by oahgnehzoul on 15/8/28.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *commentModelArray;


@property (nonatomic,strong) NSDictionary *commentDic;//评论字典
@end
