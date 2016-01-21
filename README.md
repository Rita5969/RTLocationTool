
#RTLocationTool  
easier locationManager for iOS app
封装了原生的GPS定位，简洁的返回了当前坐标，或是未定位的报错信息
-------------

> 欢迎使用提议

###使用方法
1、将RTLocationObject和RTLocationTool引入项目  
2、在需要获取坐标的位置添加代码即可从block获取坐标
```Objc
[[RTLocationTool shareLocationTool] getLocation];
[[RTLocationTool shareLocationTool] returnObject:^(RTLocationObject *locObject){
        NSLog(@"sendLocByBlock---\n-%@-%@-%@",locObject.xLoc,locObject.yLoc,locObject.error);
        if(locObject.error != 0){
            NSLog(@"sendLocByBlock error--%@",locObject.error);
        }else{
        }
    }];
```


