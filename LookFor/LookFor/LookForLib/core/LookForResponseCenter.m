//
//  ELResponseCenter.m
//  ELWork
//
//  Created by chenmingguo on 14-1-23.
//  Copyright (c) 2014 SMARTGROUP. All rights reserved.
//

#import "LookForResponseCenter.h"
static NSString *LookFor_ResponseConnectFailMessage = @"Network is not stable, please try again";
static NSString *LookFor_ResponseParseFailMessage = @"parse response data failed!";
static NSString *LookFor_ResponceIsOffLineMessage = @"please make sure login now";

@implementation LookForResponseCenter
+ (LookForResponse *)normalResponse {
    LookForResponse *response = [[LookForResponse alloc] init];
    
    response.statusCode = LookFor_ResponseSuccess;
    
    return response;
}


+ (LookForResponse *)errorResponseWithStateCode:(LookForResponceCode)aState stateMessage:(NSString *)aStateMessage {
    LookForResponse *response = [[LookForResponse alloc] init];
    
    switch (aState)
    {
        case LookFor_ResponseSuccess:
        {
            response.statusCode = LookFor_ResponseSuccess;
        }
            break;
        case LookFor_ResponseConnectFail:
		{
            response.statusCode = LookFor_ResponseConnectFail;
            response.statusMessage = LookFor_ResponseConnectFailMessage;
		}
            break;
            
        case LookFor_ResponseParseFail:
		{
            response.statusCode = LookFor_ResponseParseFail;
            response.statusMessage = LookFor_ResponseParseFailMessage;
		}
            break;
        case LookFor_ResponseIsOffLine:
        {
            response.statusCode = LookFor_ResponseIsOffLine;
            response.statusMessage = LookFor_ResponceIsOffLineMessage;
        }
            break;
        default:
            response.statusCode = aState;
            response.statusMessage = aStateMessage;
            break;
    }
    
    return response;

}

@end
