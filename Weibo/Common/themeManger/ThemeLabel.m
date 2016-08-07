//
//  ThemeLabel.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/21.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "ThemeLabel.h"
#import "ThemeManger.h"
@implementation ThemeLabel


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeAction:) name:kThemeDidChangeNofication object:nil];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeAction:) name:kThemeDidChangeNofication object:nil];

}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNofication object:nil];
}

- (void)setColorName:(NSString *)colorName {
    if (![_colorName isEqualToString:colorName]) {  //!!!!!
        _colorName = [colorName copy];
        [self loadLabel];
    }
}
- (void)themeDidChangeAction:(NSNotification *)notification {
    
    [self loadLabel];
}

- (void)loadLabel {
    ThemeManger *manager = [ThemeManger shareInstance];
    UIColor *color = [manager getThemeColor:self.colorName];
    self.textColor = color;
}










@end
