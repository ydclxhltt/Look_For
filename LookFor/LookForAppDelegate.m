//
//  LookForAppDelegate.m
//  LookFor
//
//  Created by chenmingguo on 14-12-29.
//  Copyright (c) 2014年 chenmingguo. All rights reserved.
//

#import "LookForAppDelegate.h"
#import "HomeViewController.h"
#import "LookForGuideHelpViewController.h"
#import "LookForLoginViewController.h"


@interface LookForAppDelegate()<BMKGeneralDelegate>
{
    BMKMapManager *mapManager;
    UIImageView *splashView;
    UINavigationController *rootNavVC;
}
@property(nonatomic, strong) NSString *tokenString;
@end

@implementation LookForAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    //注册远程通知
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    else
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];
    
    //注册百度地图
    mapManager = [[BMKMapManager alloc] init];
    [mapManager start:BAIDU_MAP_KEY generalDelegate:self];
    
    //初始化数据
    self.tokenString = @"";
    
    //添加主视图
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![[defaults objectForKey:@"FirstLogion"] boolValue]) {
        [defaults setObject:[NSNumber numberWithBool:YES] forKey:@"FirstLogion"];
        LookForGuideHelpViewController *help = [[LookForGuideHelpViewController alloc] init];
        self.window.rootViewController =  help;
    } else {
//        LookForLoginViewController *vc = [[LookForLoginViewController alloc] init];
//        rootNavVC = [[UINavigationController alloc] initWithRootViewController:vc];
//        self.window.rootViewController = rootNavVC;

        [self addMainView];
    }
    
    //添加启动页
   // [self addSplashView];
    
    [DeviceTool getSSIDInfo];
    [DeviceTool getCarrierInfo];
    [DeviceTool getSignalStrength];
    [DeviceTool getBatteryLevel];
    [DeviceTool getAccurateBatteryLevel];
    
    return YES;
}


#pragma mark 添加主视图
- (void)addMainView
{
    HomeViewController *rootViewController = [[HomeViewController alloc] init];
    rootNavVC = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    self.window.rootViewController = rootNavVC;
}

#pragma mark 添加启动页
- (void)addSplashView
{
    NSString *imageName = (SCREEN_4_INCH) ? @"Default-568h" : @"Default";
    UIImage *image = [UIImage imageNamed:imageName];
    splashView = [CreateViewTool createImageViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) placeholderImage:image];
    [self.window addSubview:splashView];
    
    [UIView animateWithDuration:1.0 animations:^
    {
        splashView.alpha = 0.0;
        [splashView removeFromSuperview];
    }];
}


#pragma mark sendToken
- (void)sendToken
{
    
}



#pragma mark 百度SDK启动地图认证Delegate
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError)
    {
        NSLog(@"联网成功");
    }
    else
    {
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError)
    {
        NSLog(@"授权成功");
    }
    else
    {
        NSLog(@"onGetPermissionState %d",iError);
    }
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    self.tokenString = [[[[NSString stringWithFormat:@"%@",deviceToken]stringByReplacingOccurrencesOfString:@"<"withString:@""]
                         stringByReplacingOccurrencesOfString:@">" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"deviceToken: %@====tokenString=====%@", deviceToken,self.tokenString.description);
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    application.applicationIconBadgeNumber = 0;
    /*这里需要处理推送来的消息*/
    //NSDictionary *auserInfo = [userInfo objectForKey:@"aps"];
    //NSLog(@"userInfo====%@",auserInfo);
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"error====%@",error);
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     [BMKMapView willBackGround];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [BMKMapView didForeGround];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
     [mapManager stop];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
