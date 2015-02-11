//
//  LookForRegisterService.h
//  LookFor
//
//  Created by chenlei on 15/1/25.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForBaseService.h"

#define REGISTER_SUCESS     @"REGISTER_SUCESS"
#define REGISTER_FAIL       @"REGISTER_FAIL"

@interface LookForRegisterService : LookForBaseService

- (void)requestWithMobile:(NSString *)mobile userPassword:(NSString *)password;

@end
