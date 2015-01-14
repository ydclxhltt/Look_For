

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

- (BOOL)login:(NSString *)passWord
     withName:(NSString *)name {
    
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [body setValue:name forKey:LOGINNAMEKEY];
    [body setValue:passWord forKey:PASSWORDKEY];
    [body setValue:LoginAction forKey:ACTIONKEY];
    
    [self setBodyDictionaryData:body];
    //self.urlString = [NSString stringWithFormat:@"%@",API_HOST];
    return YES;
}


- (void)requestSuccess:(NSDictionary *)responseDictionary {
    LookForResponse * response = nil;

    NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] init];
    if (![[responseDictionary objectForKey:CODEKEY] isEqualToString:@"0"]) {
        //fail
        response = [LookForResponseCenter errorResponseWithStateCode:LookFor_ResponseConnectFail stateMessage:[responseDictionary objectForKey:REASONKEY]];
        [resultDic setObject:response forKey:RESPONSEKEY];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationLogin object:nil userInfo:resultDic];
    } else {
        //success
        // [[DBManager sharedInstance] clearAllData];
        response = [LookForResponseCenter normalResponse];
        [resultDic setObject:response forKey:RESPONSEKEY];
        
        [LooKForDataConvert UserConvert:[responseDictionary valueForKey:USERINFOKEY]];
        
        //[[NSUserDefaults standardUserDefaults] setValue:[LookFor_FriendInfo shareInstance].loginName forKey:LOGINNAMEKEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationLogin object:nil userInfo:resultDic];
        
    }
    
}


- (void)requestFail {
    //Network connection fail
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    LookForResponse *response = [LookForResponseCenter errorResponseWithStateCode:LookFor_ResponseConnectFail stateMessage:nil];
    [resultDic setObject:response forKey:RESPONSEKEY];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationLogin object:nil userInfo:resultDic];
}
@end
