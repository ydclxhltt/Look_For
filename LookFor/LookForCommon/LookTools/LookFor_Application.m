//
//  LookFor_Application.m
//  LookFor
//
//  Created by chenlei on 15/1/7.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "LookFor_Application.h"

@implementation LookFor_Application

static LookFor_Application *_shareInstace = nil;


- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        
    }
    return self;
}

+ (instancetype)shareInstance
{
    if (_shareInstace != nil)
    {
        return _shareInstace;
    }
    @synchronized(self)
    {
        if (_shareInstace == nil)
        {
            _shareInstace = [[self alloc] init];
        }
    }
    return _shareInstace;
}

@end
