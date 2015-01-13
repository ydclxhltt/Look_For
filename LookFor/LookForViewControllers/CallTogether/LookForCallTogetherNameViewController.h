//
//  LookForCallTogetherNameViewController.h
//  LookFor
//
//  Created by chenmingguo on 15-1-13.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "BasicViewController.h"

@protocol LookForCallTogetherNameViewControllerDelegate <NSObject>

@optional
- (void)callTogetherName:(NSString *)name;

@end


@interface LookForCallTogetherNameViewController : BasicViewController

@property (nonatomic, weak) id<LookForCallTogetherNameViewControllerDelegate> delegate;
@end
