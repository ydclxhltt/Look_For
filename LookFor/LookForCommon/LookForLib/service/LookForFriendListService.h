//
//  LookForFriendListService.h
//  LookFor
//
//  Created by clei on 15/1/14.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "LookForBaseService.h"
#import "LookFor_FriendList.h"

#define FRIEND_LIST_SUCESS   @"FRIEND_LIST_SUCESS"
#define FRIEND_LIST_FAILURE  @"FRIEND_LIST_FAILURE"

@interface LookForFriendListService : LookForBaseService

/*
 *  初始化获取好友列表的service
 *
 *  @pram userID    用户ID
 */
- (void)requestWithUserID:(NSString *)userID;

/*
 *  获取单例
 */
+ (LookForFriendListService *)shareInstance;

@end
