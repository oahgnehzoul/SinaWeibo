//
//  WeiboView.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/24.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "WeiboView.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"
#import "ThemeManger.h"
@implementation WeiboView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _createSubViews];
    }
    return self;
}

#pragma mark- createSubViews
- (void)_createSubViews {
    _textLabel = [[WXLabel alloc] initWithFrame:CGRectZero];
    _textLabel.wxLabelDelegate = self;
    _sourceLabel = [[WXLabel alloc] initWithFrame:CGRectZero];
    _sourceLabel.wxLabelDelegate = self;
    _imageView = [[ZoomImageView alloc] initWithFrame:CGRectZero];
    _imageView.userInteractionEnabled = YES;
    _bgImageView = [[ThemeImageView alloc] initWithFrame:CGRectZero];
    _bgImageView.leftCapWidth = 25;
    _bgImageView.topCapWidth = 25;
   _bgImageView.imgName = @"timeline_rt_border_9.png";

    [self insertSubview:_bgImageView atIndex:0];

    [self addSubview:_textLabel];
    [self addSubview:_sourceLabel];
    [self addSubview:_imageView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangeAction) name:kThemeDidChangeNofication object:nil];
    
}
#pragma mark - layoutSubViews
//重写layoutFrame的set方法，刷新数据
- (void)setLayoutFrame:(WeiboViewLaoutFrame *)layoutFrame {
    if (_layoutFrame != layoutFrame) {
        _layoutFrame = layoutFrame;
        [self setNeedsLayout];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    WeiboModel *model = self.layoutFrame.weiboModel;
    //1 设置微博文字
    _textLabel.frame = self.layoutFrame.textFrame;
    _textLabel.text = model.text;
    _textLabel.font = [UIFont systemFontOfSize:13];
    _textLabel.textColor = [[ThemeManger shareInstance] getThemeColor:@"Timeline_Content_color"];
    _sourceLabel.textColor = [[ThemeManger shareInstance] getThemeColor:@"Timeline_Content_color"];
    //2  微博是否是转发的
    
    if (model.reWeiboModel != nil) {
        self.bgImageView.hidden = NO;
        self.sourceLabel.hidden = NO;
        //原微博背景图片frame
        self.bgImageView.frame = self.layoutFrame.bgImageFrame;
        
        //原微博内容及frame
       
        self.sourceLabel.text = [NSString stringWithFormat:@"@%@ %@",model.reWeiboModel.userModel.screen_name,model.reWeiboModel.text];
        self.sourceLabel.frame = self.layoutFrame.srTextFrame;
        self.sourceLabel.font = [UIFont systemFontOfSize:13];
        NSString *imgUrl = model.reWeiboModel.thumbnailImage;
        
        if (imgUrl != nil) {
            self.imageView.hidden = NO;
            self.imageView.frame = self.layoutFrame.imgFrame;
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
            self.imageView.urlStr = model.reWeiboModel.originalImage;
            
        }else{
            
            self.imageView.hidden = YES;
        }
        
    }else{
        self.bgImageView.hidden = YES;
        self.sourceLabel.hidden = YES;
        NSString *imgUrl = model.thumbnailImage;
        //是否有图片
        if (imgUrl == nil) {
            self.imageView.hidden = YES;
        }else{
            self.imageView.hidden = NO;
            self.imageView.frame = self.layoutFrame.imgFrame;
            
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
            self.imageView.urlStr = model.originalImage;
            
        }
        
    }
    //判断图片是否为gif
    if (self.imageView.hidden == NO) {
        UIImageView *iconView = self.imageView.iconImageView;
        iconView.frame = CGRectMake(_imageView.width-24, _imageView.height-15, 24, 15);

        NSString *extension = [model.thumbnailImage pathExtension];
        NSString *extension1 = [model.reWeiboModel.thumbnailImage pathExtension];
        if ([extension1 isEqualToString:@"gif"]||[extension isEqualToString:@"gif"]) {
            iconView.hidden = NO;
            self.imageView.isGif = YES;
        }else {
            iconView.hidden = YES;
            self.imageView.isGif = NO;
        }
    }
}
- (void)themeChangeAction {
    _textLabel.textColor = [[ThemeManger shareInstance] getThemeColor:@"Timeline_Content_color"];
    _sourceLabel.textColor = [[ThemeManger shareInstance] getThemeColor:@"Timeline_Content_color"];
    [self setNeedsLayout];
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNofication object:nil];
}
#pragma mark-wxLabelDelegate
- (void)toucheBenginWXLabel:(WXLabel *)wxLabel withContext:(NSString *)context {
    NSLog(@"%@",context);
}

- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel
{
    //需要添加链接字符串的正则表达式：@用户、http://、#话题#
    NSString *regex1 = @"@\\w+";
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    NSString *regex3 = @"#\\w+#";
    NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    return regex;
}
//设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel {
    return [[ThemeManger shareInstance]getThemeColor:@"Link_color"];
}
//链接点击高亮
- (UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel {
    return [UIColor blueColor];
}



@end
