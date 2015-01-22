//
//  LookForSelectFriendTableViewCell.h
//  LookFor
//
//  Created by chenmingguo on 15-1-13.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookForSelectFriendTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL friendSelected;
@property (nonatomic, strong) NSString *nameText;

- (void)setHeadImage:(NSString *)imageName;
@end
