//
//  LookFor_FriendList.m
//  LookFor
//
//  Created by clei on 15/1/14.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "LookFor_FriendList.h"

#pragma mark 好友列表
@implementation LookFor_FriendList

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary*) dicionary
{
    self = [super initWithDictionary:dicionary];
    if (self)
    {
        self.responseMessage = [[LookFor_ResponseMessage alloc] initWithDictionary:dicionary];
        
        NSArray *friendListArray = dicionary[@"response"][@"body"][@"items"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *friendDic in friendListArray)
        {
            LookFor_Friend *friend = [[LookFor_Friend alloc] initWithDictionary:friendDic];
            if (friend)
                [array addObject:friend];
        }
        self.friendList = array;
    }
    return self;
}

@end


#pragma mark 好友列表信息
@implementation LookFor_Friend

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}
@end