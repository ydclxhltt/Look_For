//
//  FOMAIMP.m
//  AFNetworking iOS Example
//
//  Created by chenmingguo on 14-6-11.
//  Copyright (c) 2014 SMARTGROUP. All rights reserved.
//

#import "LookForIMP.h"
#import "LookForServiceSchedular.h"
#import "DBManager.h"
#import "LookForConfig.h"
#import "LookForLoginService.h"


static LookForIMP *_shareInstance = nil;

@interface LookForIMP ()

@property (nonatomic, strong) LookForServiceSchedular *schedular;
@end


@implementation LookForIMP
- (id)init {
    self = [super init];
    if (self) {
        _schedular = [LookForServiceSchedular shareInstance];
        [[DBManager sharedInstance] buildDB:DBPath];
        [LookForConfig shareInstance];
        
        [[DBManager sharedInstance] selectUser:[[NSUserDefaults standardUserDefaults] valueForKey:LOGINNAMEKEY]];
    }
    return self;
}

+ (LookForIMP *)shareInstance {
    if (_shareInstance != nil) {
        return _shareInstance;
    }
    
    @synchronized(self) {
        if (_shareInstance == nil) {
            _shareInstance = [[self alloc] init];
        }
    }
    return _shareInstance;
}


- (void)login:(NSString *)passWord
     withName:(NSString *)name {
    LookForLoginService *syn = [[LookForLoginService alloc] init];
    BOOL isSyn = [syn login:passWord withName:name];
    if (isSyn) {
        [_schedular postService:syn];
    }
}

@end
