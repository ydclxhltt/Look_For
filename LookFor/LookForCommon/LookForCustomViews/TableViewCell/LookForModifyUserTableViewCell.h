//
//  LookForModifyUserTableViewCell.h
//  LookFor
//
//  Created by chenmingguo on 15-1-23.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LookForModifyUserTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *detailText;
@property (nonatomic, strong) NSString *sexText;


- (void)setSexText:(NSString *)sexText withImageView:(NSString *)imageName;
@end
