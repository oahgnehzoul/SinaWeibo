//
//  ThemeManger.h
//  Weibo
//
//  Created by oahgnehzoul on 15/8/21.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kThemeDidChangeNofication @"kThemeDidChangeNofication"
@interface ThemeManger : NSObject


@property (nonatomic,strong) NSDictionary *themeConfig;
@property (nonatomic,strong) NSDictionary *colorConfig;
@property (nonatomic,copy) NSString *themeName;


+ (ThemeManger *)shareInstance;
- (UIImage *)getImage:(NSString *)imageName;
- (UIColor *)getThemeColor:(NSString *)colorName;
@end
