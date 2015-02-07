//
//  LookForNickNameService.h
//  LookFor
//
//  Created by chenlei on 15/2/5.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForBaseService.h"

#define SET_NICKNAME_SUCESS @"SET_NICKNAME_SUCESS"
#define SET_NICKNAME_FAIL   @"SET_NICKNAME_FAIL"

@interface LookForNickNameService : LookForBaseService

/*
 *  初始化
 */
+ (LookForNickNameService *)shareInstance;

/*
 *  设置昵称
 *
 *  @pram nickName 昵称
 */
- (void)requestWithNickName:(NSString *)nickName;

@end
