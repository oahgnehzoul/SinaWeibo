//
//  ThemeButton.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/21.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManger.h"
@implementation ThemeButton



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeAction:) name:kThemeDidChangeNofication object:nil];
    }
    return self;
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNofication object:nil];
}
- (void)awakeFromNib {
    [super awakeFromNib];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeAction:) name:kThemeDidChangeNofication object:nil];
}
- (void)setNomalImageName:(NSString *)nomalImageName {
    if (![self.nomalImageName isEqualToString:nomalImageName]) {
        _nomalImageName = [nomalImageName copy];
        [self loadImage];
    }
}
- (void)setHighlightedImageName:(NSString *)highlightedImageName {
    if (![self.highlightedImageName isEqualToString:highlightedImageName]) {
        _highlightedImageName = [highlightedImageName copy];
        [self loadImage];
    }
}
- (void)setNomalBgImageName:(NSString *)nomalBgImageName {
    if (![self.nomalBgImageName isEqualToString:nomalBgImageName]) {
        _nomalBgImageName = [nomalBgImageName copy];
        [self loadImage];
    }
}

- (void)setHighlightedBgImageName:(NSString *)highlightedBgImageName {
    if (![self.highlightedBgImageName isEqualToString:highlightedBgImageName]) {
        _highlightedBgImageName = [highlightedBgImageName copy];
        [self loadImage];
    }

}
- (void)themeDidChangeAction:(NSNotification *)notification {
    
    [self loadImage];
}

- (void)loadImage {
    ThemeManger *manger  = [ThemeManger shareInstance];
    UIImage *normalImage = [manger getImage:self.nomalImageName];
    UIImage *highlightedImage = [manger getImage:self.highlightedImageName];
    if (normalImage != nil) {
        [self setImage:normalImage forState:UIControlStateNormal];
    }
    if (highlightedImage) {
        [self setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    UIImage *normalBgImage = [manger getImage:self.nomalBgImageName];
    UIImage *highlightedBgImage = [manger getImage:self.highlightedBgImageName];
    if (normalBgImage) {
        [self setImage:normalBgImage forState:UIControlStateNormal];
    }
    if (highlightedBgImage) {
        [self setImage:highlightedBgImage forState:UIControlStateHighlighted];
    }
}
@end
