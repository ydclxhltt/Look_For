//
//  LookForFriendListService.m
//  LookFor
//
//  Created by clei on 15/1/14.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "LookForFriendListService.h"
#import "LookFor_FriendList.h"

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
    NSLog(@"responseDictionary===%@",responseDictionary);
    LookFor_FriendList *friendListObj = [[LookFor_FriendList alloc] initWithDictionary:responseDictionary];
    NSLog(@"friendListObject===%@",((LookFor_Friend *)friendListObj.friendList[1]).nickName);
}


- (void)requestFail
{
    //Network connection fail
}

@end
