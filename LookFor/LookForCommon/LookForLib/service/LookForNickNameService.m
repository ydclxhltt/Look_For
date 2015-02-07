//
//  LookForNickNameService.m
//  LookFor
//
//  Created by chenlei on 15/2/5.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForNickNameService.h"

@implementation LookForNickNameService


static LookForNickNameService *_shareInstance;


+ (LookForNickNameService *)shareInstance
{
    if (_shareInstance != nil)
    {
        return _shareInstance;
    }
    
    @synchronized(self)
    {
        if (_shareInstance == nil)
        {
            _shareInstance = [[self alloc] init];
        }
    }
    return _shareInstance;
}


- (void)requestWithNickName:(NSString *)nickName
{
    nickName = (nickName) ? nickName : @"";
    self.bodyDictionary = @{@"nickName":nickName};
    self.urlString = SET_NICKNAME_URL;
}

- (void)requestSuccess:(NSDictionary *)responseDictionary
{
    NSLog(@"nickNameResponseDictionary==%@",responseDictionary);
    NSArray *array = responseDictionary[@"response"][@"body"][@"items"];
    if (array && [array count] > 0)
    {
        NSDictionary *dic = array[0];
        NSString *nickName = dic[@"nickName"];
        nickName = (nickName) ? nickName : @"";
        [UserDefaults setObject:nickName forKey:@"nickName"];
        [self sendNoticationWithName:SET_NICKNAME_SUCESS object:nil];
    }
    else
    {
        [self requestFail];
    }
}

- (void)requestFail
{
    [self sendNoticationWithName:SET_NICKNAME_FAIL object:nil];
}
@end
