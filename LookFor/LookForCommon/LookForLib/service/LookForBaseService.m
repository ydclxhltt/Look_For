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

- (void)setBodyDictionaryData:(NSMutableDictionary *)bodyDictionaryData {
//    
//    NSError *error = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bodyDictionaryData
//                                                       options:NSJSONWritingPrettyPrinted
//                                                         error:&error];
//    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    self.bodyString = [NSString stringWithFormat:@"<input hiddel id=\"JsonEncoded\"  value= \"%@\"/>",jsonString];
//   [self.bodyDictionary setValue:self.bodyString forKey:@"req"];
    self.bodyDictionary = bodyDictionaryData;
    
}


- (void)requestSuccess:(NSDictionary *)responseDictionary {

}

- (void)requestFail {

}

@end
