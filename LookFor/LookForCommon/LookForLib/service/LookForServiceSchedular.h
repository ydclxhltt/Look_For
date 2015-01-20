//
//  FOMAServiceSchedular.h
//  AFNetworking iOS Example
//
//  Created by mawenqiu on 14-6-10.
//  Copyright (c) 2014 SMARTGROUP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "LookForBaseService.h"
@interface LookForServiceSchedular : NSObject

+ (LookForServiceSchedular *)shareInstance;

- (void)postService:(LookForBaseService *)baseService;
@end
