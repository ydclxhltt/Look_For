//
//  LookForRequestTool.m
//  LookFor
//
//  Created by clei on 15/1/14.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "LookForRequestTool.h"

@implementation LookForRequestTool

#pragma mark 发送请求
+ (void)request:(LookForBaseService *)baseService
{
    LookForServiceSchedular *requestHandle = [LookForServiceSchedular shareInstance];
    [requestHandle postService:baseService];
}

#pragma mark 获取好友列表
+ (void)getFriendListRequestWithUserID:(NSString *)userID
{
    if (![LookForFriendListService isCanRequestForKey:FRIEND_LIST_TIME])
        return;
    LookForFriendListService *friendListService = [[LookForFriendListService alloc] initWithUserID:userID];
    [LookForRequestTool request:friendListService];
}

#pragma mark 获取好友详情列表
+ (void)getFriendListRequestWithUserID:(NSString *)userID allFriendID:(NSString *)friendID
{
    if (![LookFor_FriendDetailListService isCanRequestForKey:FRIENDDETAIL_LIST_TIME])
        return;
    LookFor_FriendDetailListService *friendDetailListService = [[LookFor_FriendDetailListService alloc]initWithUserID:userID allFriendID:friendID];
    [LookForRequestTool request:friendDetailListService];
}

@end
