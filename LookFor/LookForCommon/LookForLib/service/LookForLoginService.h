//
//  LookForLoginService.h
//  QuanJianApp
//
//  Created by chenmingguo on 14-8-24.
//  Copyright (c) 2014年 why. All rights reserved.
//

#import "LookForBaseService.h"

#define LOGIN_SUECESS   @"LOGIN_SUECESS"
#define LOGIN_FAIL      @"LOGIN_FAIL"


@interface LookForLoginService : LookForBaseService

- (void)login:(NSString *)password withMobile:(NSString *)mobile;
@end
