//
//  FOMABaseService.h
//  AFNetworking iOS Example
//
//  Created by mawenqiu on 14-6-10.
//  Copyright (c) 2014 SMARTGROUP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LookForResponse.h"
#import "LookForResponseCenter.h"
#import "LookForCoreDefs.h"
#import "LookForDataConvert.h"
#import "LookForObjectModel.h"
#import "DBManager.h"
#import "AFNetworkReachabilityManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "LookForConfig.h"
#import "LookForContentService.h"
#import "RequestUrlDefs.h"

#define LoginAction             @"loginAction"
#define GetCatalogAction        @"getCatalogAction"
#define GetCatalogDetailAction  @"getCatalogDetailAction"
#define GETINFOLISTACTION       @"getInfoListAction"
#define GETCITYLISTACTION       @"getCityListAction"
#define GETANSWERLISTACTION     @"getAnswerListAction"
#define QUESTIONACTION          @"questionAction"

#define REQUEST_TIME_DELAY      15.0
#define REQUEST_TIMEOUT         15.0

@interface LookForBaseService : NSObject

@property (nonatomic, strong) AFHTTPRequestOperation *operation;
@property (nonatomic, strong) NSDate *lastRequestDate;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSDictionary *bodyDictionary;
@property (nonatomic, strong) NSString *bodyString;

- (void)setBodyDictionaryData:(NSDictionary *)bodyDictionaryData;
//override the requestSuccess function
- (void)requestSuccess:(NSDictionary *)responseDictionary;
- (void)requestFail;

/*
 *  判断是否发请求，15.0内不重复发
 */
- (BOOL)isCanRequest;

/*
 *  判断是否正在请求
 */
- (BOOL)isRequesting;

/*
 *  取消请求
 */
- (void)cancelRequest;

/*
 *  发送通知方法
 *
 *  @pram name    通知名子
 *  @pram object  携带的对象
 */
- (void)sendNoticationWithName:(NSString *)name  object:(id)object;

@end
