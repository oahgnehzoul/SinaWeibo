//
//  CommentModel.h
//  Weibo
//
//  Created by oahgnehzoul on 15/8/28.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "BaseModel.h"
#import "UserModel.h"
#import "WeiboModel.h"
@interface CommentModel : BaseModel

@property(nonatomic,copy)NSString       *createDate;       //评论创建时间
@property(nonatomic,copy)NSString       *text;              //评论的内容
@property(nonatomic,copy) NSString *idstr;
@property(nonatomic,copy) NSString *source;


@property (nonatomic,strong) UserModel *userModel;  //评论人
@property (nonatomic,strong) WeiboModel *weiboModel;
@property (nonatomic,strong) CommentModel *sourceComment;
@end
