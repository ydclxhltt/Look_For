//
//  LookFor_FriendDetailListService.m
//  LookFor
//
//  Created by clei on 15/1/16.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookFor_FriendDetailListService.h"


@implementation LookFor_FriendDetailListService


- (instancetype)initWithUserID:(NSString *)userID  allFriendID:(NSString *)friendID
{
    self = [super init];
    if (self)
    {
        NSDictionary *bodyDic  = @{@"userId":userID,@"friendId":friendID};
        [self setBodyDictionaryData:bodyDic];
        self.urlString = FRIEND_DETAIL_URL;
    }
    return self;
}

- (void)requestSuccess:(NSDictionary *)responseDictionary
{
    NSLog(@"responseDictionary===%@",responseDictionary);
    LookFor_FriendDetailList *friendDetailListObj = [[LookFor_FriendDetailList alloc] initWithDictionary:responseDictionary];
    NSLog(@"friendListObject===%@",((LookFor_FriendDetail *)friendDetailListObj.lbsList[0]).nickName);
}


- (void)requestFail
{
    //Network connection fail
}

@end
