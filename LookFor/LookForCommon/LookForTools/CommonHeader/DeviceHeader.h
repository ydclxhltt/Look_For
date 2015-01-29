//
//  DeviceHeader.h
//  SmallPig
//
//  Created by chenlei on 14/11/5.
//  Copyright (c) 2014年 chenlei. All rights reserved.
//

#ifndef SmallPig_DeviceHeader_h
#define SmallPig_DeviceHeader_h


#define MAIN_SCREEN_SIZE    [[UIScreen mainScreen]bounds].size

#define SCREEN_3_5_INCH     (SCREEN_HEIGHT < 568)       // 3.5寸Retina
#define SCREEN_4_INCH       (SCREEN_HEIGHT == 568)      // 4寸Retina
#define SCREEN_4_7_INCH     (SCREEN_HEIGHT == 667)      // 4.7寸Retina
#define SCREEN_5_5_INCH     (SCREEN_HEIGHT >= 736)      // 5.5寸Retina

//屏幕宽度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//屏幕高度
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

//适配缩放比例
#define CURRENT_SCALE SCREEN_WIDTH/320.0

//设备型号
#define DEVICE_MODEL [[UIDevice currentDevice] model]

//分辨率
#define DEVICE_RESOLUTION  [NSString stringWithFormat:@"%.0f*%.0f", SCREEN_WIDTH * [[UIScreen mainScreen] scale], SCREEN_HEIGHT * [[UIScreen mainScreen] scale]]

//系统版本
#define DEVICE_SYSTEM_VERSION  [[[UIDevice currentDevice] systemVersion] floatValue]

//地图bundle
#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]


#define LeftSpace       15
#define DefaultSpace    10

#endif
