//
//  FOMAConfig.h
//  FOMA_Iphone
//
//  Created by chenmingguo on 14-6-26.
//  Copyright (c) 2014 SMARTGROUP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"

@interface LookForConfig : NSObject

+ (LookForConfig *)shareInstance;

- (AFNetworkReachabilityStatus)getNetWorkStatus;
@end
