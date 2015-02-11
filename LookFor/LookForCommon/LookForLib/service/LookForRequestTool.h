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
#import "LookForLoginSystemService.h"
#import "LookForRegisterService.h"
#import "LookForNickNameService.h"
#import "LookForLoginService.h"

typedef enum : NSUInteger
{
    RequestTypePost,
    RequestTypeGet,
} RequestType;

@interface LookForRequestTool : NSObject

/*
 * 系统登录服务器
 *
 */
+ (void)loginSystemRequest;

/*
 * 注册
 *
 * @pram mobile   手机号
 * @pram password 密码
 */
+ (void)registerWithMobile:(NSString *)mobile userPassword:(NSString *)password;

/*
 * 登录
 *
 * @pram mobile   手机号
 * @pram password 密码
 */
+ (void)loginWithMobile:(NSString *)mobile userPassword:(NSString *)password;

/*
 * 设置昵称
 *
 * @pram name 用户昵称
 */
+ (void)setNickName:(NSString *)name;

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
+ (void)getFriendDetailListRequestWithUserID:(NSString *)userID allFriendID:(NSString *)friendID;


@end
