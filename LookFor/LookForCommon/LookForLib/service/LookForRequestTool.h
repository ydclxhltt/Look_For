//
//  LookForRequestTool.h
//  LookFor
//
//  Created by clei on 15/1/14.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LookForRequestTool : NSObject

/*
 * 获取好友列表请求
 *
 * @pram userID 用户ID
 */
+ (void)getFriendListRequestWithUserID:(NSString *)userID;

@end
