//
//  LookForRequestTool.h
//  LookFor
//
//  Created by clei on 15/1/14.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LookForServiceSchedular.h"
#import "LookForFriendListService.h"
#import "LookFor_FriendDetailListService.h"

@interface LookForRequestTool : NSObject

/*
 * 获取好友列表请求
 *
 * @pram userID 用户ID
 */
+ (void)getFriendListRequestWithUserID:(NSString *)userID;

/*
 * 获取好友详情列表请求
 *
 * @pram userID     用户ID
 * @pram friendID   所有好友ID
 */
+ (void)getFriendListRequestWithUserID:(NSString *)userID allFriendID:(NSString *)friendID;


@end
