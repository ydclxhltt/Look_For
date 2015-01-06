//
//  LookForAppDelegate.m
//  LookFor
//
//  Created by chenmingguo on 14-12-29.
//  Copyright (c) 2014年 chenmingguo. All rights reserved.
//

#import "LookForAppDelegate.h"
#import "LocationServiceViewController.h"

@implementation LookForAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    self.mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"yVYTBThsX0n1xDWjtMqnQz9e" generalDelegate:self];
    
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    LocationServiceViewController *rootVC = [[LocationServiceViewController alloc] init];
    
    self.rootNavigation = [[UINavigationController alloc] initWithRootViewController:rootVC];
    self.window.rootViewController = self.rootNavigation;
    
    CGFloat animateHeight = 310;

    if (iPhone5) {
        _splashView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
        [_splashView setImage:[UIImage imageNamed:@"Default-568h"]];
        animateHeight = 310;
    }
    else
    {
        _splashView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        [_splashView setImage:[UIImage imageNamed:@"Default"]];
        animateHeight = 266;
    }
    
    
    
    [self.window addSubview:_splashView];
    [self.window bringSubviewToFront:_splashView];
    
    UIImageView *lightpoint = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icare_iphone_lightpoint"]];
    //    lightpoint.layer.shadowColor = [UIColor whiteColor].CGColor;
    
    UIImageView *lightline = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icare_iphone_lightline"]];
    
    
    [lightline setCenter:CGPointMake(160, animateHeight)];
    [lightline setFrame:CGRectMake(lightline.frame.origin.x, lightline.frame.origin.y, 0, 1)];
    
    [lightpoint setCenter:CGPointMake(180, animateHeight)];
    lightpoint.hidden= YES;
    [_splashView addSubview:lightpoint];
    
    [_splashView addSubview:lightline];
    [UIView animateWithDuration:0.0
                          delay:0.0
                        options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         //                         [lightpoint setCenter:CGPointMake(233, 310)];
                         [lightline setFrame:CGRectMake(lightline.frame.origin.x, lightline.frame.origin.y, 188, 1)];
                     }
                     completion:^(BOOL finished) {
                         lightpoint.hidden= NO;
                         [UIView animateWithDuration:0.4
                                               delay:0.0
                                             options:UIViewAnimationOptionAllowAnimatedContent
                                          animations:^{
                                              
                                              [lightpoint setCenter:CGPointMake(233, animateHeight)];
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [_splashView removeFromSuperview];
                                          }
                          
                          ];
                     }
     
     ];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

@end
