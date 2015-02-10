//
//  LookForSaveTradeTableViewCell.h
//  LookFor
//
//  Created by chenmingguo on 15-1-9.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookForSaveTradeTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *detailText;

//设置头标题
- (void)setHeadImage:(NSString *)imageName;

- (void)setRightText:(NSString *)text withColor:(UIColor *)color;
- (void)setRightImage:(UIImage *)image;
@end
