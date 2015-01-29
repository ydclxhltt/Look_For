//
//  LookForRightSelectTableViewCell.h
//  LookFor
//
//  Created by chenmingguo on 15-1-27.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LookForRightSelectTableViewCell;

@protocol LookForRightSelectTableViewCellDelegate <NSObject>

@optional
- (void)deleteItem:(LookForRightSelectTableViewCell*)cell;

@end


@interface LookForRightSelectTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *deleteImageName;
@property (nonatomic, weak) id<LookForRightSelectTableViewCellDelegate> delegate;

@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, strong) NSString *titleText;

- (void)setSelectImage:(NSString *)imageName;

@end
