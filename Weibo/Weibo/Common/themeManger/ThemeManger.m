//
//  ThemeManger.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/21.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "ThemeManger.h"
#define kDefaultThemeName @"Cat"
#define kThemeName @"kThemeName"
@implementation ThemeManger

+ (ThemeManger *)shareInstance {
    static ThemeManger *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}
+(ThemeManger *)sharedInstance {
    static ThemeManger *instance = nil;
    static dispatch_once_t onceToken; // 线程安全
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _themeName = kDefaultThemeName;
        
        //读取本地存储的主题名字
        NSString *saveThemeName = [[NSUserDefaults standardUserDefaults] objectForKey:kThemeName];
        if (saveThemeName.length > 0) {
            _themeName = saveThemeName;
        }
        
        NSString *configPath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        self.themeConfig = [NSDictionary dictionaryWithContentsOfFile:configPath];
        //获取颜色配置
        NSString *themePath = [self themePath];
        NSString *filePath = [themePath stringByAppendingPathComponent:@"config.plist"];
        self.colorConfig = [NSDictionary dictionaryWithContentsOfFile:filePath];
    }
    return self;
}

//切换主题
- (void)setThemeName:(NSString *)themeName {
    if (![_themeName isEqualToString:themeName]) {
        _themeName = [themeName copy];
        
        [[NSUserDefaults standardUserDefaults] setObject:_themeName forKey:kThemeName];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //获取颜色配置
        NSString *themePath = [self themePath];
        NSString *filePath = [themePath stringByAppendingPathComponent:@"config.plist"];
        self.colorConfig = [NSDictionary dictionaryWithContentsOfFile:filePath];
       
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNofication object:nil];
    }
}
- (UIImage *)getImage:(NSString *)imageName {
    if (imageName.length == 0) {
        return nil;
    }
    NSString *themePath = [self themePath];
    //拼接图片路径
    NSString *filePath = [themePath stringByAppendingPathComponent:imageName];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}

//获取主题包中相应地颜色。
- (UIColor *)getThemeColor:(NSString *)colorName {
    if (colorName.length == 0) {
        return nil;
    }
    NSDictionary *rgbDic = [self.colorConfig objectForKey:colorName];
    CGFloat r = [rgbDic[@"R"] floatValue];
    CGFloat g = [rgbDic[@"G"] floatValue];
    CGFloat b = [rgbDic[@"B"] floatValue];
    CGFloat alpha = [rgbDic[@"alpha"] floatValue];
    if (rgbDic[@"alpha"] == nil) {
        alpha = 1;
    }
    UIColor *color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
    return color;
}
//获取主题包路径
- (NSString *)themePath {
    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
    NSString *themePath = [self.themeConfig objectForKey:_themeName];
    NSString *path = [bundlePath stringByAppendingPathComponent:themePath];
    return path;
}
@end
