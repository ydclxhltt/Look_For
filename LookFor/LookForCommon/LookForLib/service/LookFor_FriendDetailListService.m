//
//  LookFor_FriendDetailListService.m
//  LookFor
//
//  Created by clei on 15/1/16.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookFor_FriendDetailListService.h"


@implementation LookFor_FriendDetailListService



static LookFor_FriendDetailListService *_shareInstance;


+ (LookFor_FriendDetailListService *)shareInstance
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

- (void)requestWithUserID:(NSString *)userID  allFriendID:(NSString *)friendID
{
    NSDictionary *bodyDic  = @{@"userId":userID,@"friendId":friendID};
    [self setBodyDictionaryData:bodyDic];
    self.urlString = FRIEND_DETAIL_URL;
}

- (void)requestSuccess:(NSDictionary *)responseDictionary
{
    [super requestSuccess:responseDictionary];
    NSLog(@"responseDictionary===%@",responseDictionary);
    LookFor_FriendDetailList *friendDetailListObj = [[LookFor_FriendDetailList alloc] initWithDictionary:responseDictionary];
    if (friendDetailListObj)
        [[NSNotificationCenter defaultCenter] postNotificationName:FRIENDDETAIL_LIST_SUCESS object:friendDetailListObj];
    else
        [[NSNotificationCenter defaultCenter] postNotificationName:FRIENDDETAIL_LIST_FAILURE object:nil];
}


- (void)requestFail
{
    [super requestFail];
    [[NSNotificationCenter defaultCenter] postNotificationName:FRIENDDETAIL_LIST_FAILURE object:nil];
    //Network connection fail
}

@end
