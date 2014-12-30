//
//  QJCoreDefs.h
//  QuanJian
//
//  Created by chenmingguo on 14-8-17.
//  Copyright (c) 2014年 why. All rights reserved.
//

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)

#define DBPath [[(NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)) lastObject]stringByAppendingPathComponent:dataBaseName]
#define dataBaseName @"LookFordb.sqlite"


#define UISCREEN            [[UIScreen mainScreen] bounds]
#define SCREEN_HEIGHT       (UISCREEN.size.height)
#define SCREEN_3_5_INCH     (SCREEN_HEIGHT < 568)       // 3.5寸Retina
#define SCREEN_4_INCH       (SCREEN_HEIGHT == 568)      // 4寸Retina
#define SCREEN_4_7_INCH     (SCREEN_HEIGHT == 667)      // 4.7寸Retina
#define SCREEN_5_5_INCH     (SCREEN_HEIGHT >= 736)      // 5.5寸Retina

#define MAIN_SCREEN_SIZE                        [[UIScreen mainScreen]bounds].size



#define API_HOST                  @"http://118.26.72.210:8481/"

#pragma mark -Notification
#define  KNotificationSyn               @"KNotificationSyn"
#define  KNotificationLogin             @"NotificationLogin"                    //登录通知
#define  KNotificationGetCatalog        @"NotificationGetCatalog"               //获取目录
#define  KNotificationGetCatalogDetail  @"NotificationGetCatalogDetail"         //获取目录详情
#define  KNotificationGetInfoList       @"NotificationGetInfoList"              //获取信息列表
#define  KNotificationGetCityHospital   @"NotificationGetCityHospital"          //获取城市医院
#define  KNotificationGetAnswerList     @"NotificationGetAnswerList"            //获取问题列表
#define  KNotificationQuestion          @"NotificationQuestion"                 //提问



#pragma mark param
#define ACTIONKEY               @"action"
#define CODEKEY                 @"resultCode"
#define DEFAULTCODE             @"defaultCode"
#define RESPONSEKEY             @"response"
#define REASONKEY               @"reason"
#define USERINFOKEY             @"userInfo"
#define LOGINNAMEKEY            @"loginName"
#define PASSWORDKEY             @"passWord"
#define USERIDKEY               @"userId"
#define SEXKEY                  @"sex"
#define NICKNAMEKEY             @"nickName"
#define EMAILKEY                @"email"
#define HEADIMAGEURLKEY         @"headImageUrl"
#define LEVELKEY                @"level"
#define PHONEKEY                @"phone"
#define PARENTIDKEY             @"parentId"
#define CATALOGIDKYE            @"catalogId"
#define CATALOGNAMEKEY          @"catalogName"
#define INFOURLKEY              @"infoUrl"
#define TYPEKEY                 @"type"
#define CATALOGLISTKEY          @"catalogList"
#define CATALOGDESKEY           @"catalogDescription"
#define IMAGEURLKEY             @"imageUrl"
#define CATALOGINFOKEY          @"catalogInfo"
#define INFOLISTKEY             @"infoList"
#define INFOIDKEY               @"infoId"
#define TITLEKEY                @"title"
#define SUBTITLEKEY             @"subTitle"
#define CREATEDATEKEY           @"createDate"
#define OTHERKEY                @"other"
#define PAGESIZEKEY             @"pageSize"
#define PAGEINDEXKEY            @"pageIndex"
#define CITYLISTKEY             @"cityList"
#define CITYIDKEY               @"cityId"
#define HOSPITALLISTKEY         @"hospitalList"
#define HOSPITALIDKEY           @"hospitalId"
#define HOSPITALNAMEKEY         @"hospitalName"
#define HOSPITALCODKEY          @"hospitalCode"
#define ADDRESSKEY              @"address"
#define CONACTNAMEKEY           @"conactName"
#define TELKEY                  @"tel"
#define ANSWERLISTKEY           @"answerList"
#define PUBLISHDATEKEY          @"publishDate"
#define QUESTIONCONTENTKEY      @"questionContent"
#define TIMEKEY                 @"time"




