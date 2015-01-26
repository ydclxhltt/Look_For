//
//  LookFor_FriendDetail.m
//  LookFor
//
//  Created by clei on 15/1/16.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookFor_FriendDetailList.h"


@implementation LookFor_FriendDetail

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

@end


@implementation LookFor_FriendDetailList

- (instancetype)initWithDictionary:(NSDictionary *)dicionary
{
    self = [super initWithDictionary:dicionary];
    if (self)
    {
        self.responseMessage = [[LookFor_ResponseMessage alloc] initWithDictionary:dicionary];
        
        NSArray *lsbListArray = dicionary[@"response"][@"body"][@"items"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *friendDetailDic in lsbListArray)
        {
            LookFor_FriendDetail *friendDetail = [[LookFor_FriendDetail alloc] initWithDictionary:friendDetailDic];
            if (friendDetail)
                [array addObject:friendDetail];
        }
        self.lbsList = [NSMutableArray arrayWithArray:array];
    }
    return self;
}

@end
