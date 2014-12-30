//
//  LookForAppDelegate.h
//  LookFor
//
//  Created by chenmingguo on 14-12-29.
//  Copyright (c) 2014年 chenmingguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@class LookForViewController;

@interface LookForAppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LookForViewController *rootVC;
@property (nonatomic, strong) BMKMapManager *mapManager;
@property (strong, nonatomic) UIImageView *splashView;

@end
