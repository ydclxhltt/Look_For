//
//  LookForRequestTool.m
//  LookFor
//
//  Created by clei on 15/1/14.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "LookForRequestTool.h"
#import "LookForServiceSchedular.h"
#import "LookForFriendListService.h"
@implementation LookForRequestTool


+ (void)request:(LookForBaseService *)baseService
{
    LookForServiceSchedular *requestHandle = [LookForServiceSchedular shareInstance];
    [requestHandle postService:baseService];
}

#pragma mark 获取好友列表
+ (void)getFriendListRequestWithUserID:(NSString *)userID
{
    LookForFriendListService *friendListService = [[LookForFriendListService alloc] initWithUserID:userID];
    [LookForRequestTool request:friendListService];
}

@end
