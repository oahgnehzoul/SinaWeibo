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
                  
    _imgView.frame = CGRectMake(5, 5, 35, 35);
    [_imgView sd_setImageWithURL:url];
    _nameLabel.frame = CGRectMake(45, 5, 200, 15);
    _nameLabel.text = self.commentModel.userModel.screen_name;
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = [UIColor orangeColor];
    _timeLabel.frame = CGRectMake(45, 25, 100, 15);

    _timeLabel.text = self.commentModel.createDate;


    NSString *str = [Utils weiboDateString:self.commentModel.createDate];

    _timeLabel.text = str;
    CGFloat height = [WXLabel getTextHeight:14 width:KWidth-55 text:self.commentModel.text linespace:9.0f];
    _contentLabel.frame = CGRectMake(45, 45, KWidth-55, height+10);
    _contentLabel.text = self.commentModel.text;
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:14];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
