//
//  LookForFriendListService.m
//  LookFor
//
//  Created by clei on 15/1/14.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "LookForFriendListService.h"


@implementation LookForFriendListService

static LookForFriendListService *_shareInstance;


+ (LookForFriendListService *)shareInstance
{
    if (_shareInstance != nil)
    {
        return _shareInstance;
    }
    
    @synchronized(self)
    {
        if (_shareInstance == nil)
        {
            _shareInstance = [[self alloc] init];
        }
    }
    return _shareInstance;
}


- (void)requestWithUserID:(NSString *)userID
{
    NSDictionary *bodyDic  = @{@"userId":userID};
    [self setBodyDictionaryData:bodyDic];
    self.urlString = FRIEND_LIST_URL;

}


- (void)requestSuccess:(NSDictionary *)responseDictionary
{
    NSLog(@"responseDictionary===%@",responseDictionary);
    [super requestSuccess:responseDictionary];
    LookFor_FriendList *friendListObj = [[LookFor_FriendList alloc] initWithDictionary:responseDictionary];
    if (friendListObj)
        [[NSNotificationCenter defaultCenter] postNotificationName:FRIEND_LIST_SUCESS object:friendListObj];
    else
        [[NSNotificationCenter defaultCenter] postNotificationName:FRIEND_LIST_FAILURE object:nil];
}


- (void)requestFail
{
    [super requestFail];
    //Network connection fail
    [[NSNotificationCenter defaultCenter] postNotificationName:FRIEND_LIST_FAILURE object:nil];
}

@end
