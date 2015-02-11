

//
//  LookForLoginService.m
//  QuanJianApp
//
//  Created by chenmingguo on 14-8-24.
//  Copyright (c) 2014年 why. All rights reserved.
//

#import "LookForLoginService.h"

@implementation LookForLoginService
- (id)init {
    self =[super init];
    if (self) {
        
    }
    return self;
}

- (void)login:(NSString *)password withMobile:(NSString *)mobile
{
    
    NSDictionary *bodyDic = @{@"mobile":mobile,@"password":password};
    self.bodyDictionary = bodyDic;
    self.urlString = LOGIN_URL;
   
}


- (void)requestSuccess:(NSDictionary *)responseDictionary
{
    NSArray *array = responseDictionary[@"response"][@"body"][@"items"];
    if (array && [array count] > 0)
    {
        NSDictionary *dic = array[0];
        [UserDefaults setObject:dic[@"nickName"] forKey:@"nickName"];
        [UserDefaults setObject:dic[@"mobile"] forKey:@"mobile"];
        [UserDefaults setObject:dic[@"userId"] forKey:@"userID"];
        [LookFor_Application shareInstance].token = dic[@"token"];
        [self sendNoticationWithName:LOGIN_SUECESS object:nil];
    }
    else
    {
        [self requestFail];
    }
}


- (void)requestFail
{
    [self sendNoticationWithName:LOGIN_FAIL object:nil];
}
@end
