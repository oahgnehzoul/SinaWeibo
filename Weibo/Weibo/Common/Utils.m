//
//  Utils.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/24.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "Utils.h"
//#import "WeiboCell.h"
#import "RegexKitLite.h"
@implementation Utils


//创建一个NSDateFormatter,设置格式
//NSString *formatterStr = @"EEE MMM dd HH:mm:ss Z yyyy";
//NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//[formatter setDateFormat:formatterStr];
//
//[NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
//
////Date,
//NSDate *date = [[NSDate alloc] init];
//date = [formatter dateFromString:self.model.createDate];
//
//
//NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//[dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
//
//NSString *time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
//
//self.creatTime.text = time;
//

+ (NSDate *)dateFromString:(NSString *)dateString withFormatterStr:(NSString *)formatterStr {
//    NSString *formatterStr = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    NSDate *date = [formatter dateFromString:dateString];
    return date;
}

+ (NSString *)stringFromDate:(NSDate *)date withFormatterStr:(NSString *)formatterStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    NSString *string = [formatter stringFromDate:date];
    return string;

}

+ (NSString *)weiboDateString:(NSString *)str {
    NSString *formatterStr = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *date = [Utils dateFromString:str withFormatterStr:formatterStr];
    NSString *timeStr = [Utils stringFromDate:date withFormatterStr:@"MM月dd日 HH:mm"];
    return timeStr;
}
//处理文本中显示的图片
+ (NSString *)parseTextImage:(NSString *)text {
    //[哈哈]--->图片名 ----> 替换成： <image url = '图片名'>
    NSString *faceRegex = @"\\[\\w+\\]";
    NSArray *faceItem = [text componentsMatchedByRegex:faceRegex];
    
    //1>.读取emoticons.plist 表情配置文件
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *faceConfig = [NSArray arrayWithContentsOfFile:configPath];
    
    //2>.循环、遍历所有的查找出来的表情名：[哈哈]、[赞]、....
    for (NSString *faceName in faceItem) {
        //faceName = [哈哈]
        
        //3.定义谓词条件，到emoticons.plist中查找表情名对应的表情item
        NSString *t = [NSString stringWithFormat:@"self.chs='%@'",faceName];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:t];
        NSArray *items = [faceConfig filteredArrayUsingPredicate:predicate];
        
        if (items.count > 0) {
            //4.取得过滤出来的表情item
            NSDictionary *faceDic = items[0];
            
            //5.取得图片名
            NSString *imgName = faceDic[@"png"];
            
            //6.构造表情表情 <image url = '图片名'>
            NSString *replace = [NSString stringWithFormat:@"<image url = '%@'>",imgName];
            
            //7.替换：将[哈哈] 替换成 <image url = '90.png'>
            text = [text stringByReplacingOccurrencesOfString:faceName withString:replace];
            
        }
        
    }
    
    return text;
}


@end
