//
//  LookForModifyUserTableViewCell.h
//  LookFor
//
//  Created by chenmingguo on 15-1-23.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  LookForModifyUserTableViewCellDelegate<NSObject>

@optional
- (NSInteger)selectIndex:(NSInteger)index;

@end

@interface LookForModifyUserTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *detailText;

@property (nonatomic, weak) id <LookForModifyUserTableViewCellDelegate> delegate;

- (void)isSexSelect:(BOOL)isSex;

@end
