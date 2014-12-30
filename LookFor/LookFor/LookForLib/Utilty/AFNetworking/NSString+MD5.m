//
//  NSString+MD5.m
//  FOMA_Iphone
//
//  Created by mawenqiu on 14-7-10.
//  Copyright (c) 2014 SMARTGROUP. All rights reserved.
//

#import "NSString+MD5.h"

@implementation NSString (MD5)

-(NSString *) md5HexDigest
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}
-(NSString *) imageType
{
    NSString * imageTypeStr = @"";

    NSMutableArray *arr = (NSMutableArray *)[self componentsSeparatedByString:@"."];
    if (arr) {
        imageTypeStr = [arr objectAtIndex:arr.count-1];
    }
    return imageTypeStr;
}
-(NSString *) imageFullName
{
    NSString * imageFullNameStr = @"";
    
    NSMutableArray *arr = (NSMutableArray *)[self componentsSeparatedByString:@"/"];
    if (arr) {
        imageFullNameStr = [arr objectAtIndex:arr.count-1];
    }
    return imageFullNameStr;
}
-(NSString *) imageName
{
    NSString * imageNameStr = @"";
    NSString * imageFullNameStr = @"";
    
    NSMutableArray *arr = (NSMutableArray *)[self componentsSeparatedByString:@"/"];
    if (arr) {
        imageFullNameStr = [arr objectAtIndex:arr.count-1];
        NSMutableArray *arrTemp = (NSMutableArray *)[imageFullNameStr componentsSeparatedByString:@"."];
        imageNameStr = [arrTemp objectAtIndex:0];
    }
    return imageNameStr;
}
@end
