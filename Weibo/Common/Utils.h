//
//  Utils.h
//  Weibo
//
//  Created by oahgnehzoul on 15/8/24.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject


+ (NSDate *)dateFromString:(NSString *)dateString withFormatterStr:(NSString *)formatterStr;

+ (NSString *)stringFromDate:(NSDate *)date withFormatterStr:(NSString *)formatterStr;
+ (NSString *)weiboDateString:(NSString *)str;

//处理文字中的表情
+ (NSString *)parseTextImage:(NSString *)text ;

@end
