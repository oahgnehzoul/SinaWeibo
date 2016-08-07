//
//  WeiboModel.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/22.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "WeiboModel.h"
#import "RegexKitLite.h"
@implementation WeiboModel

- (NSDictionary*)attributeMapDictionary {
    NSDictionary *mapAtt = @{
                             @"createDate":@"created_at",
                             @"weiboId":@"id",
                             @"text":@"text",
                             @"source":@"source",
                             @"favorited":@"favorited",
                             @"thumbnailImage":@"thumbnail_pic",
                             @"bmiddlelImage":@"bmiddle_pic",
                             @"originalImage":@"original_pic",
                             @"geo":@"geo",
                             @"repostsCount":@"reposts_count",
                             @"commentsCount":@"comments_count",
                             @"weiboIdStr":@"idstr"
                             };
    
    return mapAtt;
}

- (void)setAttributes:(NSDictionary *)dataDic {
    [super setAttributes:dataDic];
    if (self.source) {
        NSString *regex = @">.+<";
        NSArray *items = [self.source componentsMatchedByRegex:regex];
        if (items.count) {
            NSString *temp = items[0];
            self.source = [temp substringWithRange:NSMakeRange(1, temp.length-2)];
        }
       
    }
    NSString *regex = @"\\[\\w+\\]";
    NSArray *faceItems = [self.text componentsMatchedByRegex:regex];
    //表情配置文件
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *faceConfigArray = [NSArray arrayWithContentsOfFile:configPath];
    
    for (NSString *faceName in faceItems) {
        //用谓词进行过滤 在plist中找到对应的字典，facename = @“[兔子]”,
        //self.chs='[兔子]'
        NSString *t = [NSString stringWithFormat:@"self.chs='%@'",faceName];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:t];
        NSArray *items = [faceConfigArray filteredArrayUsingPredicate:predicate];
        if (items.count> 0) {
            NSDictionary *faceDic = items[0];
            //取得图片的名字
            NSString *imageName = [faceDic objectForKey:@"png"];
            //[兔子]-----<image url = '001.png'>
            NSString *replaceStr = [NSString stringWithFormat:@"<image url = '%@'>",imageName];
            self.text = [self.text stringByReplacingOccurrencesOfString:faceName withString:replaceStr];
        }
    }
    
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    if (userDic) {
        self.userModel = [[UserModel alloc] initWithDataDic:userDic];
    }
    
    NSDictionary *reDic = [dataDic objectForKey:@"retweeted_status"];
    if (reDic) {
        self.reWeiboModel = [[WeiboModel alloc] initWithDataDic:reDic];
    }
}

@end
