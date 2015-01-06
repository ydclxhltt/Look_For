//
//  ELResponseCenter.h
//  ELWork
//
//  Created by chenmingguo on 14-1-23.
//  Copyright (c) 2014 SMARTGROUP. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "LookForResponse.h"

@interface LookForResponseCenter : NSObject

+ (LookForResponse *)normalResponse;


+ (LookForResponse *)errorResponseWithStateCode:(LookForResponceCode)aState stateMessage:(NSString *)aStateMessage;


@end
