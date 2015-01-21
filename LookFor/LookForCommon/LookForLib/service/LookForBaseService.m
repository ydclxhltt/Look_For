//
//  FOMABaseService.m
//  AFNetworking iOS Example
//
//  Created by mawenqiu on 14-6-10.
//  Copyright (c) 2014 SMARTGROUP. All rights reserved.
//

#import "LookForBaseService.h"

@implementation LookForBaseService
@synthesize urlString;
@synthesize bodyDictionary;
@synthesize bodyString;

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {

    }
    return self;
}

- (void)setBodyDictionaryData:(NSMutableDictionary *)bodyDictionaryData
{
    self.bodyDictionary = bodyDictionaryData;
}


- (void)requestSuccess:(NSDictionary *)responseDictionary
{
    self.operation = nil;
    self.lastRequestDate = [NSDate date];
}

- (void)requestFail
{
    self.operation = nil;
}


- (BOOL)isCanRequest
{
    if (!self.lastRequestDate)
    {
        return YES;
    }
    float currentTime = [[NSDate date] timeIntervalSinceDate:self.lastRequestDate];
    if (currentTime >= REQUEST_TIME_DELAY)
    {
        return YES;
    }
    return NO;
}

- (BOOL)isRequesting
{
    if (self.operation)
    {
        return YES;
    }
    return NO;
}

- (void)cancelRequest
{
    [self.operation cancel];
    self.operation = nil;
}


@end
