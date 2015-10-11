//
//  CommentCell.h
//  Weibo
//
//  Created by oahgnehzoul on 15/8/28.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
#import "WXLabel.h"
@interface CommentCell : UITableViewCell
{
    UIImageView *_imgView;
    UILabel *_nameLabel;
    UILabel *_timeLabel;
    WXLabel *_contentLabel;
}
@property (nonatomic,strong) CommentModel *commentModel;

@end
