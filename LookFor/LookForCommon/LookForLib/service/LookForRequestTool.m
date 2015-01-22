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
    LookForFriendListService *friendListService = [LookForFriendListService shareInstance];
    if (![friendListService isCanRequest])
        return;
    if ([friendListService isRequesting])
        return;
    [friendListService requestWithUserID:userID];
    [LookForRequestTool request:friendListService];
}

#pragma mark 获取好友详情列表
+ (void)getFriendDetailListRequestWithUserID:(NSString *)userID allFriendID:(NSString *)friendID
{
    LookFor_FriendDetailListService *friendDetailListService = [LookFor_FriendDetailListService shareInstance];
    if ([friendDetailListService isRequesting])
        [friendDetailListService cancelRequest];
    [friendDetailListService requestWithUserID:userID allFriendID:friendID];
    [LookForRequestTool request:friendDetailListService];
}

#pragma mark 获取好友位置
+ (void)getFriendLocationRequestWithUserID:(NSString *)userID allFriendID:(NSString *)friendID
{
    LookFor_FriendDetailListService *friendDetailListService = [LookFor_FriendDetailListService shareInstance];
    if ([friendDetailListService isRequesting])
        return;
    [friendDetailListService requestWithUserID:userID allFriendID:friendID];
    [LookForRequestTool request:friendDetailListService];
}

@end
