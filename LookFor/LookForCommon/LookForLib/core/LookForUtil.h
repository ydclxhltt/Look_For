//
//  FOMAUtil.h
//  FOMA_Iphone
//
//  Created by chenmingguo on 14-6-16.
//  Copyright (c) 2014 SMARTGROUP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LookForUtil : NSObject

#pragma mark -time

//request current datetime
+ (double)LookForCurrentTime;

//request current datetime as string
+ (NSString*)LookForCurGetTimeString;
+ (NSString*)LookForCurGetDateString;
+ (NSString*)LookForGetDefaultTimeString;
+ (NSString*)LookForDateToString:(NSDate*)date;
+ (NSString*)LookForDateToShortString:(NSDate*)date;
+ (NSString*)LookForDateOffset;
+ (NSString*)LookForOffsetWithDate:(NSDate*)date;
+ (NSString*)LookForDateTimeToString:(NSDate*)date;
+ (NSDate*)LookForStringToDate:(NSString*)string;
+ (NSString*)LookForGetDeviceId;
+ (BOOL)isRelogin;
+ (void)LookForAlertViewIsOk:(NSString*)text;
+ (CGSize)stringSizeWithFont:(UIFont*)font withSize:(CGSize)size withString:(NSString *)string;

@end
