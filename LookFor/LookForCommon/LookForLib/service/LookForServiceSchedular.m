//
//  FOMAServiceSchedular.m
//  AFNetworking iOS Example
//
//  Created by mawenqiu on 14-6-10.
//  Copyright (c) 2014 SMARTGROUP. All rights reserved.
//add service management

#import "LookForServiceSchedular.h"
#import "AFHTTPRequestOperationManager.h"
static LookForServiceSchedular *_shareInstance = nil;

@interface LookForServiceSchedular ()
{

}
@property (nonatomic,strong) AFHTTPRequestOperationManager *operationManager;
@end


@implementation LookForServiceSchedular
- (instancetype)init {
    self = [super init];
    if (self) {
        _operationManager = [AFHTTPRequestOperationManager manager];
       // _operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    }
    return self;
}


+ (LookForServiceSchedular *)shareInstance {
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


- (void)postService:(LookForBaseService *)baseService {
    
    [_operationManager POST:baseService.urlString
                 parameters:baseService.bodyDictionary
                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSDictionary *dic = (NSDictionary *)responseObject;
                        [baseService requestSuccess:dic];
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        [baseService requestFail];
                    }];
}

@end
