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
+ (void)request:(LookForBaseService *)baseService withRequestType:(RequestType)requestType
{
    LookForServiceSchedular *requestHandle = [LookForServiceSchedular shareInstance];
    if (RequestTypePost == requestType)
    {
        [requestHandle postService:baseService];
    }
    else if (RequestTypeGet == requestType)
    {
        [requestHandle getService:baseService];
    }
    
}

#pragma mark 登录服务器接口
+ (void)loginSystemRequest
{
    LookForLoginSystemService *loginSystemService = [[LookForLoginSystemService alloc] init];
    [loginSystemService loginSystemRequest];
    [LookForRequestTool request:loginSystemService withRequestType:RequestTypePost];
}

#pragma mark 注册
+ (void)registerWithMobile:(NSString *)mobile userPassword:(NSString *)password
{
    LookForRegisterService *registerService = [[LookForRegisterService alloc] init];
    [registerService requestWithMobile:mobile userPassword:password];
    [LookForRequestTool request:registerService withRequestType:RequestTypePost];
}

#pragma mark 修改昵称
+ (void)setNickName:(NSString *)name
{
    LookForNickNameService *nickNameService = [LookForNickNameService shareInstance];
    if ([nickNameService isRequesting])
        return;
    [nickNameService requestWithNickName:name];
    [LookForRequestTool request:nickNameService withRequestType:RequestTypePost];
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
    [LookForRequestTool request:friendListService withRequestType:RequestTypeGet];
}

#pragma mark 获取好友详情列表
+ (void)getFriendDetailListRequestWithUserID:(NSString *)userID allFriendID:(NSString *)friendID
{
    LookFor_FriendDetailListService *friendDetailListService = [LookFor_FriendDetailListService shareInstance];
    if ([friendDetailListService isRequesting])
        [friendDetailListService cancelRequest];
    [friendDetailListService requestWithUserID:userID allFriendID:friendID];
    [LookForRequestTool request:friendDetailListService withRequestType:RequestTypeGet];
}

#pragma mark 获取好友位置
+ (void)getFriendLocationRequestWithUserID:(NSString *)userID allFriendID:(NSString *)friendID
{
    LookFor_FriendDetailListService *friendDetailListService = [LookFor_FriendDetailListService shareInstance];
    if ([friendDetailListService isRequesting])
        return;
    [friendDetailListService requestWithUserID:userID allFriendID:friendID];
    [LookForRequestTool request:friendDetailListService withRequestType:RequestTypeGet];
}

@end
