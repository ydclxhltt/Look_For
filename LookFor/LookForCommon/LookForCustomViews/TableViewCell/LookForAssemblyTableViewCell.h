//
//  LookForAssemblyTableViewCell.h
//  LookFor
//
//  Created by chenmingguo on 15-1-18.
//  Copyright (c) 2015年 LookFor. All rights reserved.
// 集结号，和圈圈公用

#import <UIKit/UIKit.h>

@interface LookForAssemblyTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *detailText;
@property (nonatomic, strong) NSString *timeText;
@property (nonatomic, strong) UIImage  *headImage;

@property (nonatomic, strong) UISwitch *switchView;

- (void)showSwitch;
@end
