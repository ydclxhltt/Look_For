//
//  CommonHeader.h
//  SmallPig
//
//  Created by clei on 14/11/5.
//  Copyright (c) 2014年 chenlei. All rights reserved.
//

#ifndef SmallPig_CommonHeader_h
#define SmallPig_CommonHeader_h

#import "ProductInfoHeader.h"
#import "DeviceHeader.h"

//百度地图
#define BAIDU_MAP_KEY               @"yVYTBThsX0n1xDWjtMqnQz9e"
#define DISTABCEFILTER              15.0

//SMS
#define SMS_APP_KEY                 @"518ec8a6aa30"
#define SMS_APP_SECRET              @"23f82461e51ac52d992af8117fe5d331"

//导航条高度
#define NAV_HEIGHT                  64.0

//tabbar高度
#define TABBAR_HEIGHT               49.0

//阴影高度
#define SHADOW_HEIGHT               10.0

//阴影模糊度
#define SHADOW_OPACITY              .2

//设置字体大小
#define FONT(f)                     [UIFont systemFontOfSize:f]

//设置加粗字体大小
#define BOLD_FONT(f)                [UIFont boldSystemFontOfSize:f]

//设置RGB
#define RGBA(R,G,B,AL)              [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:AL]

#define RGB(R,G,B)                  [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

//界面背景颜色
#define  BASIC_VIEW_BG_COLOR        RGB(242.0,242.0,244.0)

//主色调
#define  APP_MAIN_COLOR             RGB(34.0,204.0,204.0)

//tabbar背景颜色
#define  TABBAR_BG_COLOR            RGB(12.0,97.0,152.0)

//弹出层背景颜色
#define  LAYER_BG_COLOR             RGBA(255.0,255.0,255.0,.8)

//弹出层阴影颜色
#define  LAYER_SHADOW_COLOR         RGBA(0.0,0.0,0.0,.5)



#define SeparatorLineColor          [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]
#define kTableViewGrayColor         [UIColor colorWithWhite:239.0/255.0 alpha:1.0f]

//获取十六进制的颜色
#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define TitleColor                  UIColorFromRGB(0x404041)
#define DetailColor                 UIColorFromRGB(0x595757)


//用户注册登录等相关tip
#define MOBILE_NULL                 @"手机号不能为空"
#define MOBILE_ERROR                @"请输入正确的手机号"
#define PASSWORD_NULL               @"密码不能为空"
#define CODE_NULL                   @"请输入验证码"
#define CODE_ERROR                  @"验证码错误"


#endif
