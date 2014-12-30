//
//  LookForLoginService.h
//  QuanJianApp
//
//  Created by chenmingguo on 14-8-24.
//  Copyright (c) 2014年 why. All rights reserved.
//

#import "LookForBaseService.h"

@interface LookForLoginService : LookForBaseService

- (BOOL)login:(NSString *)passWord
     withName:(NSString *)name;
@end
