//
//  MoreTableViewCell.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/21.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "MoreTableViewCell.h"
#import "ThemeManger.h"
@implementation MoreTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)themeChangeAction {
    self.backgroundColor = [[ThemeManger shareInstance] getThemeColor:@"More_Item_color"];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
        [self themeChangeAction];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangeAction) name:kThemeDidChangeNofication object:nil];

    }
    return self;
}

- (void)createSubViews {
    _themeImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    _themeTextLabel = [[ThemeLabel alloc] initWithFrame:CGRectMake(50, 5, 150, 40)];
    _themeDetailLabel = [[ThemeLabel alloc] initWithFrame:CGRectMake(KWidth-140, 5, 140, 40)];
    _themeTextLabel.backgroundColor = [UIColor clearColor];
    _themeDetailLabel.backgroundColor = [UIColor clearColor];
    _themeTextLabel.colorName = @"More_Item_Text_color";
    _themeDetailLabel.colorName = @"More_Item_Text_color";
    [self.contentView addSubview:_themeImageView];
    [self.contentView addSubview:_themeTextLabel];
    [self.contentView addSubview:_themeDetailLabel];
    
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
