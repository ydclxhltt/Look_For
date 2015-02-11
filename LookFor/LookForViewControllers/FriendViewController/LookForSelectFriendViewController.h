//
//  LookForSelectFriendViewController.h
//  LookFor
//
//  Created by chenmingguo on 15-1-13.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "BasicViewController.h"

@protocol LookForSelectFriendViewControllerDelegate <NSObject>

@optional
//临时使用
- (void)selectFriendNames:(NSString *)names;

@end

@interface LookForSelectFriendViewController : BasicViewController {

}

@property (nonatomic, weak) id<LookForSelectFriendViewControllerDelegate> delegate;

- (id)initWithTitle:(NSString *)title;
@end
