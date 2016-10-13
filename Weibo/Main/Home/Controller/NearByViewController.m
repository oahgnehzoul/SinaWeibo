//
//  NearByViewController.m
//  Weibo
//
//  Created by oahgnehzoul on 15/9/1.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "NearByViewController.h"
#import "NearModel.h"
#import "DataService.h"
#import "ThemeButton.h"
#import "MMDrawerController.h"
@interface NearByViewController ()

@end

@implementation NearByViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigation];
   
    _locationManager = [[CLLocationManager alloc] init];
    if (kVersion >= 8.0) {
        // 请求允许定位
        [_locationManager requestWhenInUseAuthorization];
    }
    // 设置请求的准确度
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    _locationManager.delegate = self;
    // 开始定位
    [_locationManager startUpdatingLocation];
     [self _createTableView];

}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"附近商圈";
    }
    return self;
}
#pragma mark - 添加导航栏
- (void)addNavigation {
    ThemeButton *closeBtn = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    closeBtn.nomalImageName = @"button_icon_close.png";
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];

    
}

- (void)closeAction {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([window.rootViewController isKindOfClass:[MMDrawerController class]]) {
        MMDrawerController *mmDrawer = (MMDrawerController *)window.rootViewController;
        
        [mmDrawer closeDrawerAnimated:YES completion:NULL];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)_createTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)_loadNearByDataWithlon:(NSString *)lon lat:(NSString *)lat {
    

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:lon forKey:@"long"];
    [params setValue:lat forKey:@"lat"];
    [params setObject:@50 forKey:@"count"];
    [DataService requestUrl:near_by httpMethod:@"GET" params:params block:^(id result) {
        _dataArray = [[NSMutableArray alloc] init];
        NSArray *pois = result[@"pois"];
        for (NSDictionary *dic in pois) {
            NearModel *model = [[NearModel alloc] initWithDataDic:dic];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];

    }];
   
    
    
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // 停止定位
    [manager stopUpdatingLocation];
    
    // 获取当前请求的位置
    CLLocation *location = [locations lastObject];
    
    NSString *lon = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    NSString *lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    // 开始加载网络
    [self _loadNearByDataWithlon:lon lat:lat];
}


#pragma mark - UItableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NearModel *model = self.dataArray[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    cell.textLabel.text = model.title;
    return cell;
}



@end
