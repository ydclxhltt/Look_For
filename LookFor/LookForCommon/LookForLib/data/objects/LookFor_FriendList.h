//
//  LookFor_FriendList.h
//  LookFor
//
//  Created by clei on 15/1/14.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "LookForObjectModel.h"

@interface LookFor_FriendList : LookForObjectModel

@property (nonatomic, strong) LookFor_ResponseMessage *responseMessage;
@property (nonatomic, strong) NSMutableArray *friendList;

@end

@interface LookFor_Friend : LookForObjectModel

@property (nonatomic, strong) NSString *friendID;
@property (nonatomic, strong) NSString *mobilNumber;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger permission;
@property (nonatomic, strong) NSString *portrait;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, assign) float longitude;
@property (nonatomic, assign) float latitude;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, strong) NSString *commentName;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, strong) NSString *lastAddress;

@end