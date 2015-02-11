//
//  LookForRegisterService.m
//  LookFor
//
//  Created by chenlei on 15/1/25.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForRegisterService.h"

@implementation LookForRegisterService

- (void)requestWithMobile:(NSString *)mobile userPassword:(NSString *)password
{
    mobile = (mobile) ? mobile : @"";
    password = (password) ? password : @"";
    NSDictionary *bodyDic = @{@"mobile":mobile,@"password":password};
    [self setBodyDictionary:bodyDic];
    self.urlString = REGISTER_URL;
}


- (void)requestFail
{
    [self sendNoticationWithName:REGISTER_FAIL object:nil];
}


- (void)requestSuccess:(NSDictionary *)responseDictionary
{
    NSLog(@"responseDictionary===%@",responseDictionary);
    NSArray *array = responseDictionary[@"response"][@"body"][@"items"];
    NSDictionary *dic = array[0];
    [LookFor_Application shareInstance].token = dic[@"token"];
    [self sendNoticationWithName:REGISTER_SUCESS object:nil];
}


@end
