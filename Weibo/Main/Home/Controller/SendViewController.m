//
//  SendViewController.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/30.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "SendViewController.h"
#import "DataService.h"
#import "AppDelegate.h"
#import "ThemeButton.h"
#import "ThemeImageView.h"
#import "MMDrawerController.h"
#import "ZoomImageView.h"
@interface SendViewController ()
{
    UITextView *_textView;
    ThemeImageView *_bottomView;
    ZoomImageView *_imgView;
    
    UILabel *_locationLabel;
}
@end

@implementation SendViewController
//移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"发微博";
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigation];
    [self addTextView];
    [self addBottomView];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [_textView becomeFirstResponder];
}
//键盘出现
- (void)showKeyBoard:(NSNotification *)notification {
    NSValue *rectValue = [notification.userInfo objectForKeyedSubscript:UIKeyboardFrameEndUserInfoKey];
    CGFloat height = [rectValue CGRectValue].size.height;
    _bottomView.bottom = KHeight- height-64;
    _locationLabel.bottom = _bottomView.top;
}
//键盘消失
- (void)hideKeyBoard:(NSNotification *)notification {
    _bottomView.frame = CGRectMake(0, KHeight-55-64, KWidth, 55);
    _locationLabel.bottom = _bottomView.top;
}

#pragma mark - 添加导航栏
- (void)addNavigation {
    ThemeButton *closeBtn = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    closeBtn.nomalImageName = @"button_icon_close.png";
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    ThemeButton *sendBtn = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    sendBtn.nomalImageName = @"button_icon_ok.png";
    [sendBtn addTarget:self action:@selector(sendWeibo) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendBtn];
    
}

- (void)closeAction {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([window.rootViewController isKindOfClass:[MMDrawerController class]]) {
        MMDrawerController *mmDrawer = (MMDrawerController *)window.rootViewController;
        
        [mmDrawer closeDrawerAnimated:YES completion:NULL];
    }
    [_textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//发送微博
- (void)sendWeibo {
    NSLog(@"发送");
    NSString *error = nil;
    if (_textView.text.length == 0) {
        error = @"微博内容不能为空";
    }else if (_textView.text.length > 140) {
        error = @"微博内容不能大于140字符";
    }
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
    }
    if (_textView.text.length != 0 && _textView.text.length <= 140) {
        AFHTTPRequestOperation *operation = [DataService sendWeibo:_textView.text image:_imgView.image block:^(id result) {
            NSLog(@"发送成功");
            [self showStatusTip:@"发送成功" show:NO operation:nil];
        }];
        [self showStatusTip:@"正在发送..." show:YES operation:operation];
        [self closeAction];
    }
    

   }

- (void)addTextView {
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 120)];
    _textView.backgroundColor = [UIColor lightGrayColor];
    _textView.layer.cornerRadius = 10;
    _textView.layer.borderWidth = 2;
    _textView.layer.borderColor = [UIColor blackColor].CGColor;
    _textView.scrollEnabled = NO;
    [_textView becomeFirstResponder];
    _imgView = [[ZoomImageView alloc] initWithFrame:CGRectMake(20, _textView.bottom +10, 150, 150)];
    _imgView.delegate = self;
    [self.view addSubview:_imgView];
    [self.view addSubview:_textView];
    
    
}
#pragma mark - 创建子视图
//添加工具栏
- (void)addBottomView {
    NSArray *imageNames = @[@"compose_toolbar_1@2x.png",@"compose_toolbar_3@2x.png",@"compose_toolbar_4@2x.png",@"compose_toolbar_5@2x.png",@"compose_toolbar_6@2x.png"];
    _bottomView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, KHeight-KWidth/5, KWidth, 55)];
    _bottomView.imgName = @"compose_option_bg_9";
    _bottomView.userInteractionEnabled = YES;
    for (int i = 0; i < 5; i++) {
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(i*KWidth/5, 0, KWidth/5, 55)];
        button.nomalImageName = imageNames[i];
        [_bottomView addSubview:button];
        button.tag = i;
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:_bottomView];
    
    //显示位置信息
    _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KWidth, 20)];
    _locationLabel.backgroundColor = [UIColor lightGrayColor];
    _locationLabel.textColor = [UIColor blackColor];
    _locationLabel.font = [UIFont systemFontOfSize:14];
    _locationLabel.hidden = YES;
//    [_bottomView addSubview:_locationLabel];
    [self.view addSubview:_locationLabel];
    _locationLabel.bottom = _bottomView.top;
    
}

- (void)btnAction:(UIButton *)button {
    if (button.tag == 0) {
        [self addImage];
    }else if (button.tag ==3) {
        [self _location];
    }else if (button.tag == 4) {
        BOOL isFirstResponder = _textView.isFirstResponder;
        if (isFirstResponder) {
            [_textView resignFirstResponder];
            [self _showFaceView];
        }else {
            [self _hideFaceView];
            [_textView becomeFirstResponder];
        }
    }
}

#pragma mark - 表情处理
- (void)_showFaceView {
    
}

- (void)_hideFaceView {

}
- (void)_location{
    
    /*
     修改 info.plist 增加以下两项
     NSLocationWhenInUseUsageDescription  BOOL YES
     NSLocationAlwaysUsageDescription         string “提示描述”
     */
    
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        if (kVersion > 8.0) {
            //获取授权使用地理位置服务
            [_locationManager requestWhenInUseAuthorization];
        }
        
    }
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];//设置定位精确度
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
    
}

//代理 获取定位数据
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    //停止定位
    [_locationManager stopUpdatingLocation];
    //取得位置信息
    CLLocation *location = [locations lastObject];
    
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"经度%lf,纬度%lf",coordinate.longitude,coordinate.latitude);
    
    
    //地理位置反编码，通过坐标信息获取 位置详情
    
    //一 新浪位置反编码 接口说明  http://open.weibo.com/wiki/2/location/geo/geo_to_address
    
    NSString *coordinateStr = [NSString stringWithFormat:@"%f,%f",coordinate.longitude,coordinate.latitude];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:coordinateStr forKey:@"coordinate"];
    
    __weak SendViewController* weakSelf = self;
    
    //维度：28.2148, 经度：112.893
    [DataService requestAFUrl:geo_to_address httpMethod:@"GET" params:params data:nil block:^(id result) {
        NSLog(@"%@",result);
        
        __strong SendViewController *strongSelf = weakSelf;
        
        NSArray *geos = [result objectForKey:@"geos"];
        if (geos.count > 0) {
            NSDictionary *geo = [geos lastObject];
            
            NSString *addr = [geo objectForKey:@"address"];
            NSLog(@"%@",addr);
            
            strongSelf->_locationLabel.hidden = NO;
            strongSelf->_locationLabel.text = addr;
            
        }
        
    }];
    
    //二 iOS自己内置
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *place = [placemarks lastObject];
        NSLog(@"%@",place.name);
        
    }];
    
    
    
    
}


//添加图片
- (void)addImage {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    [actionSheet showInView:self.view];
    

}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    UIImagePickerControllerSourceType sourceType;
    if (buttonIndex == 0) {
        sourceType = UIImagePickerControllerSourceTypeCamera;
        //        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没有摄像头" message:nil delegate:nil
                                                  cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
    }else if(buttonIndex == 1){
        sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }else {
        return;
    }
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];

}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *meidaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([meidaType isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        _imgView.image = image;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 实现zoomImageViewDelegate 的代理方法
- (void)imageViewWillZoomIn:(ZoomImageView *)imageView {
    [_textView resignFirstResponder];
  
}

- (void)imageViewWillZoomOut:(ZoomImageView *)imageView {
    [_textView becomeFirstResponder];
}



@end
