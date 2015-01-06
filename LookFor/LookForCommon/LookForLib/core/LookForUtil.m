//
//  FOMAUtil.m
//  FOMA_Iphone
//
//  Created by chenmingguo on 14-6-16.
//  Copyright (c) 2014 SMARTGROUP. All rights reserved.
//

#import "LookForUtil.h"
//#import "UIDevice+IdentifierAddition.h"

@implementation LookForUtil

#pragma mark - time

+ (double)LookForCurrentTime
{
    return (double)[[NSDate date] timeIntervalSince1970];
}

+ (NSString*)LookForCurGetTimeString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    NSDate *date = [NSDate date];
    return [formatter stringFromDate:date];
}

+ (NSString*)LookForCurGetDateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSDate *date = [NSDate date];
    return [formatter stringFromDate:date];
}

+ (NSString*)LookForDateTimeToString:(NSDate*)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"HH:mm"];
    return [formatter stringFromDate:date];
}

+ (NSString*)LookForGetDefaultTimeString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
    
    return [formatter stringFromDate:date];
}

+ (NSString*)LookForDateToString:(NSDate*)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    return [formatter stringFromDate:date];
    
}

+ (NSString*)LookForDateToShortString:(NSDate*)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    return [formatter stringFromDate:date];
    
}


+ (NSDate*)LookForStringToDate:(NSString*)string
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    return [formatter dateFromString:string];
    
}

+ (NSString*)LookForOffsetWithDate:(NSDate*)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    //NSDate *date = [NSDate date];
    int64_t nowTime = [date timeIntervalSince1970];
    
    NSString* dayStr = [formatter stringFromDate:date];
    NSDate *day = [formatter dateFromString:dayStr];
    int64_t dayTime = [day timeIntervalSince1970];
    
    int64_t ddd = nowTime - dayTime;
    double time = ddd / 60;
    
    return [NSString stringWithFormat:@"%f",time];
}

+ (NSString*)LookForDateOffset
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    NSDate *date = [NSDate date];
    int64_t nowTime = [date timeIntervalSince1970];
    
    NSString* dayStr = [formatter stringFromDate:date];
    NSDate *day = [formatter dateFromString:dayStr];
    int64_t dayTime = [day timeIntervalSince1970];
    
    int64_t ddd = nowTime - dayTime;
    double time = ddd / 60;
    
    return [NSString stringWithFormat:@"%f",time];
}

+ (void)LookForAlertViewIsOk:(NSString*)text
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
/*
+ (NSString*)LookForGetDeviceId
{
    return [[UIDevice currentDevice] uniqueDeviceIdentifier];
}

+ (BOOL)isRelogin
{
    //NSLog(@"=%@=",APPDELEGATE.leaveTime);

    NSDate* now = [NSDate date];
    NSTimeInterval interval = [now timeIntervalSinceDate:APPDELEGATE.leaveTime];
    APPDELEGATE.leaveTime = nil;
    
    // defaults.Security + defaults.UOM
    NSString *security = [User shareInstance].defaultConfig.security;
    NSString *uomStr = [User shareInstance].defaultConfig.uom;
    double range;
    
    if ([uomStr isEqualToString:@"Days"])
    {
        range = [security doubleValue] * 24 * 60 * 60;
    }
    else if ([uomStr isEqualToString:@"Hours"])
    {
        range = [security doubleValue] * 60 * 60;
    }
    else if ([uomStr isEqualToString:@"Minutes"])
    {
        range = [security doubleValue] * 60;
    }
    else
    {
        range = [security doubleValue] * 24 * 60 * 60;
    }
    
    if (interval >= range)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
*/
@end
