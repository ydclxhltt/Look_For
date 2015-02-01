//
//  LookForApplyTableViewCell.h
//  LookFor
//
//  Created by chenmingguo on 15-1-29.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookForApplyTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *typeText;       //右边状态
@property (nonatomic, strong) NSString *timeText;       //时间
@property (nonatomic, strong) NSString *nameText;       //姓名
@property (nonatomic, strong) NSString *messageText;    //申请原因

@end
