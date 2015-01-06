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
#import "LookForContentModel.h"
#import "DBManager.h"
#import "AFNetworkReachabilityManager.h"
#import "LookForConfig.h"
#import "LookForContentService.h"

#define LoginAction             @"loginAction"
#define GetCatalogAction        @"getCatalogAction"
#define GetCatalogDetailAction  @"getCatalogDetailAction"
#define GETINFOLISTACTION       @"getInfoListAction"
#define GETCITYLISTACTION       @"getCityListAction"
#define GETANSWERLISTACTION     @"getAnswerListAction"
#define QUESTIONACTION          @"questionAction"

@interface LookForBaseService : NSObject

@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSMutableDictionary *bodyDictionary;
@property (nonatomic, strong) NSString *bodyString;

- (void)setBodyDictionaryData:(NSMutableDictionary *)bodyDictionaryData;

//override the requestSuccess function
- (void)requestSuccess:(NSDictionary *)responseDictionary;
- (void)requestFail;
@end
