//
//  ELResponse.h
//  ELWork
//
//  Created by chenmingguo on 14-1-23.
//  Copyright (c) 2014 Smart Group. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 data sync response properties defination
 */
typedef enum
{
	LookFor_ResponseSuccess = 0,
	LookFor_ResponseConnectFail = -1001,
    LookFor_ResponseError = -1002,
    LookFor_ResponseParseFail = -1003,
    LookFor_ResponseIsOffLine = -1004,
} LookForResponceCode;

@interface LookForResponse : NSObject

@property (nonatomic, assign) LookForResponceCode statusCode;
@property (nonatomic, strong) NSString *statusMessage;

@end
