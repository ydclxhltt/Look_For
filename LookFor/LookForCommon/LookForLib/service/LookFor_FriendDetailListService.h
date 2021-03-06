//
//  LookFor_FriendDetailListService.h
//  LookFor
//
//  Created by clei on 15/1/16.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForBaseService.h"
#import "LookFor_FriendDetailList.h"

#define FRIENDDETAIL_LIST_SUCESS   @"FRIENDDETAIL_LIST_SUCESS"
#define FRIENDDETAIL_LIST_FAILURE  @"FRIENDDETAIL_LIST_FAILURE"

@interface LookFor_FriendDetailListService : LookForBaseService

/*
 *  初始化获取好友详情的service
 *
 *  @pram userID    用户ID
 *  @pram friendID  好友ID集合(中间","隔开)
 */
- (void)requestWithUserID:(NSString *)userID  allFriendID:(NSString *)friendID;

/*
 *  获取单例
 */
+ (LookFor_FriendDetailListService *)shareInstance;

@end
