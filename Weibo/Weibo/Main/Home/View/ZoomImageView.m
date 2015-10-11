//
//  ZoomImageView.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/29.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "ZoomImageView.h"
#import "DDProgressView.h"
#import "MBProgressHUD.h"
#import "UIImage+GIF.h"
@implementation ZoomImageView
{
    NSMutableData *_data;
    DDProgressView *_progressView;
    double _length;
    NSURLConnection *_connection;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initTap];
        [self _createGifIcon];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image {
    self = [super initWithImage:image];
    if (self) {
        [self _initTap];
        [self _createGifIcon];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initTap];
        [self _createGifIcon];
    }
    return self;
}

- (void)_createGifIcon {
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _iconImageView.hidden = YES;
    _iconImageView.image = [UIImage imageNamed:@"timeline_gif.png"];
    [self addSubview:_iconImageView];
}
- (void)_initTap {
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomIn)];
    [self addGestureRecognizer:tap];
    self.contentMode =  UIViewContentModeScaleAspectFit;
    
//    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap)];
//    doubleTap.numberOfTapsRequired = 2;

    
}
//- (void)doubleTap {
//    [UIView animateWithDuration:.5 animations:^{
//        CGRect frame = [self convertRect:self.bounds toView:self.window];
//        self.frame = frame;
//    }];
//}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    NSInteger tapCount = [touch tapCount];
//    NSLog(@"%ld",tapCount);
//    if (tapCount == 2) {
//        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(zoomIn) object:nil];
//        [self doubleTap];
//    }
//}
- (void)createView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomOut)];
        [_scrollView addGestureRecognizer:tap];
        
        
        //添加长按手势
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(savePhoto:)];
        [_scrollView addGestureRecognizer:longPress];
        [self.window addSubview:_scrollView];
        _fullImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
        _fullImageView.image = self.image;
        [_scrollView addSubview:_fullImageView];
        
        _progressView = [[DDProgressView alloc] init];
        _progressView.frame = CGRectMake(10, KWidth/2, KWidth-10, 50);
        _progressView.outerColor = [UIColor whiteColor];
        _progressView.innerColor = [UIColor lightGrayColor];
        _progressView.emptyColor = [UIColor darkGrayColor];
        _progressView.hidden = YES;
        [_scrollView addSubview:_progressView];
    }
    
}

//长按图片调用
- (void)savePhoto:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否保存图片" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        UIImage *img = [UIImage imageWithData:_data];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
        hud.labelText = @"正在保存";
        hud.dimBackground = YES;
        //保存图片到相册
        UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void*)hud);
    }
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    //提示保存成功
    MBProgressHUD *hud = (__bridge MBProgressHUD *)(contextInfo);
    
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    //显示模式改为：自定义视图模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"保存成功";
    
    //延迟隐藏
    [hud hide:YES afterDelay:1.5];
}



- (void)zoomIn {
    if ([self.delegate respondsToSelector:@selector(imageViewWillZoomIn:)]) {
        [self.delegate imageViewWillZoomIn:self];
    }
    
    self.hidden = YES;
    [self createView];
    
    CGRect frame = [self convertRect:self.bounds toView:self.window];
    [UIView animateWithDuration:.3 animations:^{
        _fullImageView.frame = frame;
    }];
//    _fullImageView.frame = frame;
    [UIView animateWithDuration:.5 animations:^{
        _fullImageView.frame = _scrollView.bounds;
    } completion:^(BOOL finished) {
        _scrollView.backgroundColor = [UIColor blackColor];
    }];
    
    if (self.urlStr.length > 0) {
        NSURL *url = [NSURL URLWithString:self.urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
    
       _connection = [NSURLConnection connectionWithRequest:request delegate:self];
    }
   
    
}

- (void)zoomOut {
    [self.delegate imageViewWillZoomOut:self];
    [_connection cancel];
    self.hidden = NO;
    [UIView animateWithDuration:.5 animations:^{
        _scrollView.backgroundColor = [UIColor clearColor];
        CGRect frame = [self convertRect:self.bounds toView:self.window];
        _fullImageView.frame = frame;
    } completion:^(BOOL finished) {
        [_scrollView removeFromSuperview];
        _scrollView = nil;
        _fullImageView = nil;
        _progressView = nil;
    }];
}
#pragma mark 网络下载代理
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSDictionary *dic = [httpResponse allHeaderFields];
    _length = [[dic objectForKey:@"content-Length"] doubleValue];
    _data = [[NSMutableData alloc] init];
    _progressView.hidden = NO;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_data appendData:data];
//    NSLog(@"%f",_data.length/_length);
    _progressView.progress = _data.length/_length;
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    _progressView.hidden = YES;
    UIImage *image = [UIImage imageWithData:_data];
    _fullImageView.image = image;
    
    [UIView animateWithDuration:.5 animations:^{
        CGFloat length = image.size.height/image.size.width *KWidth;
        if (length < KWidth) {
            _fullImageView.top = (KWidth -length)/2;
            
        }
        _fullImageView.height = length;
        _scrollView.contentSize = CGSizeMake(KWidth, length);
    }];
    if (self.isGif) {
        [self gifImageShow];
    }
   
}

- (void)gifImageShow {
    _fullImageView.image = [UIImage sd_animatedGIFWithData:_data];
}

@end
