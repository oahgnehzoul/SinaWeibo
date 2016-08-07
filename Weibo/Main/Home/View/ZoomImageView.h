//
//  ZoomImageView.h
//  Weibo
//
//  Created by oahgnehzoul on 15/8/29.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZoomImageView;

@protocol zoomImageViewDelegate  <NSObject>

@optional
- (void)imageViewWillZoomIn:(ZoomImageView *)imageView;

- (void)imageViewWillZoomOut:(ZoomImageView *)imageView;
@end


@interface ZoomImageView : UIImageView<NSURLConnectionDataDelegate,UIAlertViewDelegate>

{
    UIScrollView *_scrollView;
    UIImageView *_fullImageView;
    
}

@property (nonatomic,copy) NSString *urlStr;

@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,assign) BOOL isGif;

@property (nonatomic,weak) id delegate;
@end
