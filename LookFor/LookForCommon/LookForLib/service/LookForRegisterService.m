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
    
}


- (void)requestSuccess:(NSDictionary *)responseDictionary
{
    NSLog(@"responseDictionary===%@",responseDictionary);
}


@end
