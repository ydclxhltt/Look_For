//
//  LookForLoginSystemService.m
//  LookFor
//
//  Created by chenlei on 15/1/25.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForLoginSystemService.h"

@implementation LookForLoginSystemService


- (void)loginSystemRequest
{
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    userID = (userID) ? userID : @"";
    NSDictionary *bodyDic = @{@"userId":userID,@"appVersion":PRODUCT_VERSION,@"platform":APPLICATION_PLATFORM,@"systemVersion":@(DEVICE_SYSTEM_VERSION),@"deviceModel":DEVICE_MODEL};
    [self setBodyDictionary:bodyDic];
    self.urlString = LOGIN_SYSTEM_URL;
}

- (void)requestSuccess:(NSDictionary *)responseDictionary
{
    NSLog(@"responseDictionary===%@",responseDictionary);
    NSArray *array = responseDictionary[@"response"][@"body"][@"items"];
    if (array && [array count] > 0)
    {
        NSDictionary *dic  = array[0];
        [[LookFor_Application shareInstance] setToken:dic[@"token"]];
        [UserDefaults setObject:dic[@"userId"] forKey:@"userID"];
        [self sendNoticationWithName:LOGIN_SYSTEM_SUCESS object:nil];
    }
    else
    {
        [self requestFail];
    }

}

- (void)requestFail
{
    [self sendNoticationWithName:LOGIN_SYSTEM_FAIL object:nil];
}

@end
