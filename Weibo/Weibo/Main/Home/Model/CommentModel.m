//
//  CommentModel.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/28.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "CommentModel.h"
#import "Utils.h"
@implementation CommentModel


- (void)setAttributes:(NSDictionary *)dataDic {
    [super setAttributes:dataDic];
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    if (userDic) {
        self.userModel = [[UserModel alloc] initWithDataDic:userDic];
    }
    NSDictionary *status  = [dataDic objectForKey:@"status"];
    WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:status];
    self.weiboModel = weibo;
    
    NSDictionary *commentDic = [dataDic objectForKey:@"reply_comment"];
    if (commentDic) {
        CommentModel *sourceComment = [[CommentModel alloc] initWithDataDic:commentDic];
        self.sourceComment = sourceComment;
    }
    
    self.text = [Utils parseTextImage:_text];
}

@end
