//
//  ViewController.m
//  LocTest
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 qiqi. All rights reserved.
//

#import "ViewController.h"
#import "RTLocationTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[RTLocationTool shareLocationTool] getLocation];
    [[RTLocationTool shareLocationTool] returnObject:^(RTLocationObject *locObject){
        NSLog(@"sendLocByBlock---\n-%@-%@-%@",locObject.xLoc,locObject.yLoc,locObject.error);
        if(locObject.error != 0){
            NSLog(@"sendLocByBlock error--%@",locObject.error);
        }else{
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
