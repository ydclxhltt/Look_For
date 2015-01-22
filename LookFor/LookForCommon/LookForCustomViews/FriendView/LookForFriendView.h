//
//  LookForFriendView.h
//  LookFor
//
//  Created by clei on 15/1/22.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FriendViewDelegate;


@interface LookForFriendView : UIView

@property (nonatomic, assign) id<FriendViewDelegate> delegate;
@property (nonatomic, strong) NSArray *dataArray;

/*
 *  初始化
 *  @pram frame  frame
 *  @pram view   父视图
 */
- (instancetype)initWithFrame:(CGRect)frame addToView:(UIView *)view;

/*
 *  显示
 */
- (void)dismiss;

/*
 *  隐藏
 */
- (void)show;
@end


@protocol FriendViewDelegate <NSObject>

@optional

//点击好友头像
- (void)friendViewClickedItemIndex:(int)index;

//视图消失
- (void)friendViewDismissed;


@end