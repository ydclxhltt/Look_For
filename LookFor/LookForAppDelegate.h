//
//  LookForAppDelegate.h
//  LookFor
//
//  Created by chenmingguo on 14-12-29.
//  Copyright (c) 2014年 chenmingguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@class HomeViewController;

@interface LookForAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)addMainView;

@end

#define APP_DELEGATE ((LookForAppDelegate *)[UIApplication sharedApplication].delegate)
