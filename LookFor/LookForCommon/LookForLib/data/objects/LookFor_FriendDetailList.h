//
//  LookFor_FriendDetail.h
//  LookFor
//
//  Created by clei on 15/1/16.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookFor_FriendList.h"
#import "LookForObjectModel.h"

@interface LookFor_FriendDetail : LookFor_Friend
@property (nonatomic, assign) float velocity;
@property (nonatomic, assign) float direction;
@property (nonatomic, assign) float battery;
@property (nonatomic, assign) float signal;
@property (nonatomic, assign) int lattice;
@end


@interface LookFor_FriendDetailList : LookForObjectModel
@property (nonatomic, strong) LookFor_ResponseMessage *responseMessage;
@property (nonatomic, strong) NSMutableArray *lbsList;
@end
