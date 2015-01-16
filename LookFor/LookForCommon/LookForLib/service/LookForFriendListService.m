//
//  LookForFriendListService.m
//  LookFor
//
//  Created by clei on 15/1/14.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "LookForFriendListService.h"


@implementation LookForFriendListService


- (instancetype)initWithUserID:(NSString *)userID
{
    self = [super init];
    if (self)
    {
        NSDictionary *bodyDic  = @{@"userId":userID};
        [self setBodyDictionaryData:bodyDic];
        self.urlString = FRIEND_LIST_URL;
    }
    return self;
}

- (void)requestSuccess:(NSDictionary *)responseDictionary
{
    LookFor_FriendList *friendListObj = [[LookFor_FriendList alloc] initWithDictionary:responseDictionary];
    if (friendListObj)
        [[NSNotificationCenter defaultCenter] postNotificationName:FRIEND_LIST_SUCESS object:friendListObj];
    else
        [[NSNotificationCenter defaultCenter] postNotificationName:FRIEND_LIST_FAILURE object:nil];
}


- (void)requestFail
{
    //Network connection fail
    [[NSNotificationCenter defaultCenter] postNotificationName:FRIEND_LIST_FAILURE object:nil];
}

@end
