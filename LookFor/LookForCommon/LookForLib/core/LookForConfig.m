//
//  FOMAConfig.m
//  FOMA_Iphone
//
//  Created by chenmingguo on 14-6-26.
//  Copyright (c) 2014 SMARTGROUP. All rights reserved.
//

#import "LookForConfig.h"

static LookForConfig *_shareInstace = nil;

@interface LookForConfig ()
@property (nonatomic, assign) AFNetworkReachabilityStatus curStatus;
@end

@implementation LookForConfig
@synthesize curStatus;

- (id)init {
    self = [super init];
    if (self) {
        [self loadData];
    }
    return self;
}

+ (LookForConfig *)shareInstance {
    if (_shareInstace != nil) {
        return _shareInstace;
    }
    
    @synchronized(self){
        if (_shareInstace == nil) {
            _shareInstace = [[self alloc] init];
        }
    }
    
    return _shareInstace;
}


- (void)loadData {
    
    AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [afNetworkReachabilityManager startMonitoring];
    
    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        curStatus = status;
    }];

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:AFNetworkingReachabilityDidChangeNotification
                                               object:nil];
}


- (void)reachabilityChanged:(NSNotification *)aNote {
    curStatus = (AFNetworkReachabilityStatus)[[aNote.userInfo objectForKey:@"AFNetworkingReachabilityNotificationStatusItem"]integerValue];
}

- (AFNetworkReachabilityStatus)getNetWorkStatus {
    return curStatus;
}
@end
