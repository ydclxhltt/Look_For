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
    [self saveDate];
}

- (void)requestFail
{
    
}


- (void)saveDate
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:[NSDate date] forKey:self.dateKey];
}

+ (BOOL)isCanRequestForKey:(NSString *)key
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDate *lastDate = [userDefault objectForKey:key];
    if (!lastDate)
    {
        return YES;
    }
    float currentTime = [[NSDate date] timeIntervalSinceDate:lastDate];
    if (currentTime >= REQUEST_TIME_DELAY)
    {
        return YES;
    }
    return NO;
}

@end
