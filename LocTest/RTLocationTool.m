//
//  RTLocationTool.m
//  RiverCondition
//
//  Created by Rita on 15/11/30.
//  Copyright © 2015年 rita. All rights reserved.
//

#import "RTLocationTool.h"
#define IsIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0 ? YES : NO)


@implementation RTLocationTool
@synthesize loc,returnObjectBlock;

#pragma mark - Init
-(id)init{
    self = [super init];
    if (self) {
        loc = [[RTLocationObject alloc]init];
    }
    return self;
}

+(instancetype)shareLocationTool{
    static RTLocationTool *location = nil;
    @synchronized(self) {
        if (location == nil) {
            
            location = [[RTLocationTool alloc]init];
//            loc = [[LocationObject alloc]init];
        }
    }
    return location;
}

-(void)getLocation {
    NSLog(@"startLocation---");
    //获取定位信息获取
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"startLocation--1-");
        if (_locationManager==nil) {
            NSLog(@"startLocation--2-");
            _locationManager = [[CLLocationManager alloc] init];
            // 设置定位精度，十米，百米，最好
            [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
//            _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
//            _locationManager.allowsBackgroundLocationUpdates = YES;
//            _locationManager.pausesLocationUpdatesAutomatically = NO;
            _locationManager.delegate = self;
        }
        if (IsIOS8) {
            NSLog(@"startLocation--3-");
            if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                [_locationManager requestAlwaysAuthorization];
            }
        }
        NSLog(@"startLocation--4-");
        // 开始时时定位
        [_locationManager startUpdatingLocation];
    }
    else
    {
        NSLog(@"startLocation--5-");
        NSLog(@"%@",@"定位功能不可用，请到设置->隐私->定位服务打开");
    }
}

-(void)startLocation{
    [_locationManager startUpdatingLocation];
}

-(void)stopLocation{
    [_locationManager stopUpdatingLocation];
}


// 6.0 以上调用这个函数
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"startLocation--6-");
    CLLocationCoordinate2D newCoordinate = newLocation.coordinate;
    NSLog(@"经度：%f,纬度：%f",newCoordinate.longitude,newCoordinate.latitude);
    self.loc.xLoc = [NSString stringWithFormat:@"%f",newCoordinate.longitude];
    self.loc.yLoc = [NSString stringWithFormat:@"%f",newCoordinate.latitude];
    
    [self sendLocByBlock];
    //    [[ReportGPSRequest shareInstance] reportGPS:[Global getServerURL:[Global getServerIP] resource:@"UserInfo" method:@"ReportGPS"] dic:[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",newCoordinate.longitude],@"Lon",[NSString stringWithFormat:@"%f",newCoordinate.latitude],@"Lat", nil]];
    
    [manager stopUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"locationManagererror%@",error);
    if (error != nil) {
        self.loc.error = error;
        [self sendLocByBlock];
    }
    
    if ([error code] == kCLErrorDenied)
    {
        //访问被拒绝
        NSLog(@"locationManagererror1%@",error);
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
        NSLog(@"locationManagererror2%@",error);
    }
}

-(void)returnObject:(ReturnObjectBlock)block{
//    [self getLocation];
    self.returnObjectBlock = block;
}

-(void)sendLocByBlock{
    NSLog(@"sendLocByBlock---\n-%@-%@-%@",self.loc.xLoc,self.loc.yLoc,self.loc.error);
    if (self.returnObjectBlock != nil) {
        self.returnObjectBlock(self.loc);
    }
}


@end
