//
//  NearByViewController.h
//  Weibo
//
//  Created by oahgnehzoul on 15/9/1.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface NearByViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate> {
    CLLocationManager *_locationManager;
    UITableView *_tableView;
}
@property (nonatomic,strong) NSMutableArray *dataArray;

@end
