//
//  ThemeImageView.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/21.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManger.h"
@implementation ThemeImageView

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNofication object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeAction:) name:kThemeDidChangeNofication object:nil];
    }
    return self;
}
- (void)themeDidChangeAction:(NSNotification *)notification {
    
    [self loadImage];
}
- (void)setImgName:(NSString *)imgName {
    if (![self.imgName isEqualToString:imgName]) {
        _imgName = [imgName copy];
        [self loadImage];
    }
}
- (void)loadImage {
    ThemeManger *manager = [ThemeManger shareInstance];
    UIImage *image = [manager getImage:self.imgName];
    if (image) {
        image = [image stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapWidth];
        [self setImage:image];
    }
}


@end
