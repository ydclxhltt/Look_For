//
//  ProductInfoHeader.h
//  SmallPig
//
//  Created by clei on 14-10-20.
//  Copyright (c) 2014年 chenlei. All rights reserved.
//

#ifndef SmallPig_ProductInfoHeader_h
#define SmallPig_ProductInfoHeader_h

//产品名
#define PRODUCT_NAME            @""

//产品版本号
#define PRODUCT_VERSION         @"1.0.0"
#define INT_VERSION             100

//平台//
#define APPLICATION_PLATFORM    @"IOS"


#define  UserDefaults   [NSUserDefaults standardUserDefaults]


typedef enum{
    ModifyPassWordType = 0,   //修改密码
    ModifyForgetPassType ,    //忘记密码
    ModifyPhoneType
}ModifyType;


#define LBSMapTypeKey           @"LBSMapTypeKey"  //
typedef enum {
    LBSMapTypeStandard   = 1,               ///< 标准地图
    LBSMapTypeSatellite  = 2,               ///< 卫星地图
}LBSMapType;




#endif
