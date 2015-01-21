//
//  FOMAServiceSchedular.m
//  AFNetworking iOS Example
//
//  Created by mawenqiu on 14-6-10.
//  Copyright (c) 2014 SMARTGROUP. All rights reserved.
//add service management

#import "LookForServiceSchedular.h"
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
        _operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [_operationManager.requestSerializer setTimeoutInterval:REQUEST_TIMEOUT];
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


- (void)postService:(LookForBaseService *)baseService
{
    
    baseService.operation = [_operationManager GET:baseService.urlString
                                         parameters:baseService.bodyDictionary
                                            success:^(AFHTTPRequestOperation *operation, id responseObject)
                             {
                                 if ([responseObject isKindOfClass:[NSDictionary class]])
                                 {
                                     NSDictionary *dic = (NSDictionary *)responseObject;
                                     [baseService requestSuccess:dic];
                                 }
                                 else
                                 {
                                     //返回的为数组（暂定失败）
                                     [baseService requestFail];
                                 }
                             }
                                            failure:^(AFHTTPRequestOperation *operation, NSError *error)
                             {
                                 NSLog(@"error===%@",error);
                                 [baseService requestFail];
                             }];
}


//- (void)postService:(LookForBaseService *)baseService
//{
//    
//    baseService.operation = [_operationManager POST:baseService.urlString
//                 parameters:baseService.bodyDictionary
//    success:^(AFHTTPRequestOperation *operation, id responseObject)
//    {
//        if ([responseObject isKindOfClass:[NSDictionary class]])
//        {
//            NSDictionary *dic = (NSDictionary *)responseObject;
//            [baseService requestSuccess:dic];
//        }
//        else
//        {
//            //返回的为数组（暂定失败）
//            [baseService requestFail];
//        }
//    }
//    failure:^(AFHTTPRequestOperation *operation, NSError *error)
//    {
//        NSLog(@"error===%@",error);
//        [baseService requestFail];
//    }];
//}

- (void)test {
    //上传图片
    AFHTTPRequestOperation *op =  [_operationManager POST:nil parameters:nil
                                constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                    //本地图片路径
                                    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"头像1.png" withExtension:nil];
                                    
                                    // 要上传保存在服务器中的名称
                                    // 使用时间来作为文件名 2014-04-30 14:20:57.png
                                    // 让不同的用户信息,保存在不同目录中
                                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                    // 设置日期格式
                                    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                                    NSString *fileName = [formatter stringFromDate:[NSDate date]];
                                    
                                    [formData appendPartWithFileURL:fileURL name:@"uploadFile" fileName:fileName mimeType:@"image/png" error:NULL];
                                } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                    
                                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                    
                                }];
    
    //添加进度
    [op setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
    }];
    
    
}

@end
