//
//  LookForLoginSystemService.h
//  LookFor
//
//  Created by chenlei on 15/1/25.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForBaseService.h"

#define LOGIN_SYSTEM_SUCESS @"LOGIN_SYSTEM_SUCESS"
#define LOGIN_SYSTEM_FAIL   @"LOGIN_SYSTEM_FAIL"

@interface LookForLoginSystemService : LookForBaseService

/*
 *  初始化获取好友列表的service
 *
 *  @pram userID    用户ID
 */
- (void)loginSystemRequest;

@end
