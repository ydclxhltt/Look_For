//
//  LookForRightSelectTableViewCell.h
//  LookFor
//
//  Created by chenmingguo on 15-1-27.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookForRightSelectTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, strong) NSString *titleText;

- (void)setSelectImage:(NSString *)imageName;

@end
