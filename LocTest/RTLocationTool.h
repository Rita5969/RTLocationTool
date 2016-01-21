//
//  RTLocationTool.h
//  RiverCondition
//
//  Created by Rita on 15/11/30.
//  Copyright © 2015年 rita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

#import "RTLocationObject.h"

typedef void (^ReturnObjectBlock)(RTLocationObject *location);

@interface RTLocationTool : NSObject<CLLocationManagerDelegate>

@property (nonatomic, copy) ReturnObjectBlock returnObjectBlock;
@property (nonatomic, retain) RTLocationObject *loc;
@property (nonatomic, retain) CLLocationManager  *locationManager;

-(void)getLocation;
-(void)startLocation;

-(void)stopLocation;

-(void)returnObject:(ReturnObjectBlock)block;
+(instancetype)shareLocationTool;

@end
