//
//  ELResponse.m
//  ELWork
//
//  Created by chenmingguo on 14-1-23.
//  Copyright (c) 2014 Smart Group. All rights reserved.
//

#import "LookForResponse.h"

@implementation LookForResponse

@synthesize statusCode;
@synthesize statusMessage;

- (id)init {
    self = [super init];
    if (self) {
        statusMessage = nil;
        statusCode = 0;
    }
    return self;
}

@end
