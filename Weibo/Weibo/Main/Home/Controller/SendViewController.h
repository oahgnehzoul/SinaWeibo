//
//  SendViewController.h
//  Weibo
//
//  Created by oahgnehzoul on 15/8/30.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ZoomImageView.h"
#import <CoreLocation/CoreLocation.h>

@interface SendViewController :BaseViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,zoomImageViewDelegate,CLLocationManagerDelegate>

{
    CLLocationManager *_locationManager;
}

@end
