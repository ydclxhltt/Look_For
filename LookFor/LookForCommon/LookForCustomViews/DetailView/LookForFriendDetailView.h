//
//  LookForFriendDetailView.h
//  LookFor
//
//  Created by clei on 15/1/20.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForBaseDetailView.h"

@protocol FriendDetailViewGoThereDelegate;

@interface LookForFriendDetailView : LookForBaseDetailView

@property (nonatomic, assign) id<FriendDetailViewGoThereDelegate> delegate;
@property (nonatomic, assign) int index;
@property (nonatomic, assign) float distance;
@end

@protocol FriendDetailViewGoThereDelegate <NSObject>

@optional

- (void)friendDetailViewClickedGoThereWithIndex:(int)index;

- (void)friendDetailViewClickedClose;

@end