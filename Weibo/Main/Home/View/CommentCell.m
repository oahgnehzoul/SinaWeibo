//
//  CommentCell.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/28.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "CommentCell.h"
#import "UIImageView+WebCache.h"
#import "Utils.h"
@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
    [self setNeedsLayout];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _createContentView];
    }
    return self;

}

- (void)_createContentView {
    _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _timeLabel = [[WXLabel alloc] initWithFrame:CGRectZero];
    _contentLabel = [[WXLabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_nameLabel];
   
    [self.contentView addSubview:_contentLabel];
    [self.contentView addSubview:_timeLabel];
}
- (void)setCommentModel:(CommentModel *)commentModel {
    _commentModel = commentModel;
    [self setNeedsLayout];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    NSURL *url = [NSURL URLWithString:_commentModel.userModel.profile_image_url];
                  
    _imgView.frame = CGRectMake(8, 8, 35, 35);
    _imgView.layer.cornerRadius = 17.5;
    _imgView.layer.masksToBounds = YES;
    [_imgView sd_setImageWithURL:url];
    _nameLabel.frame = CGRectMake(_imgView.right + 8, _imgView.top, 200, 15);
    _nameLabel.text = self.commentModel.userModel.screen_name;
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = [UIColor orangeColor];
    _timeLabel.frame = CGRectMake(_nameLabel.left, _nameLabel.bottom + 3, 100, 12);
    _timeLabel.font = [UIFont systemFontOfSize:10];
    _timeLabel.text = self.commentModel.createDate;


//    NSString *str = [Utils weiboDateString:self.commentModel.createDate];

//    _timeLabel.text = str;
    _timeLabel.text = @"2016/08/29";
    CGFloat height = [WXLabel getTextHeight:14 width:KWidth-55 text:self.commentModel.text linespace:9.0f];
    _contentLabel.frame = CGRectMake(_nameLabel.left, 45, KWidth-55, height+10);
    _contentLabel.text = self.commentModel.text;
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:14];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



@end
