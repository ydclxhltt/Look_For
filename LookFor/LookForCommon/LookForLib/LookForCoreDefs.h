//
//  QJCoreDefs.h
//  QuanJian
//
//  Created by chenmingguo on 14-8-17.
//  Copyright (c) 2014年 why. All rights reserved.
//

#define DBPath [[(NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)) lastObject]stringByAppendingPathComponent:dataBaseName]
#define dataBaseName @"LookFordb.sqlite"



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




