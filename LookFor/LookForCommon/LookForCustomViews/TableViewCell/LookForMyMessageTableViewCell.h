//
//  LookForMyMessageTableViewCell.h
//  LookFor
//
//  Created by chenmingguo on 15-1-27.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LookForMyMessageTableViewCell;

@protocol  LookForMyMessageTableViewCellDelegate <NSObject>

@optional

- (void)selectButton:(LookForMyMessageTableViewCell *)myMessageCell withIndex:(NSInteger)index;

@end


@interface LookForMyMessageTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *detailText;
@property (nonatomic, strong) NSString *sureText;
@property (nonatomic, strong) NSString *timeText;
@property (nonatomic, weak) id <LookForMyMessageTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSString *imageName;

@end
