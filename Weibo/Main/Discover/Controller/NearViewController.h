//
//  NearViewController.h
//  Weibo
//
//  Created by oahgnehzoul on 15/9/4.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface NearViewController : BaseViewController<CLLocationManagerDelegate,MKMapViewDelegate>{
    
    CLLocationManager *_locationManager;
    MKMapView *_mapView;
    
}


@end
