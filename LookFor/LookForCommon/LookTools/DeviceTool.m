//
//  DeviceTool.m
//  LookFor
//
//  Created by clei on 15/1/15.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "DeviceTool.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTSubscriberInfo.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
 #import <dlfcn.h>
#import "IOPSKeys.h"
#import "IOPowerSources.h"

@implementation DeviceTool

#pragma mark 获取信号强度
+ (int) getSignalStrength
{
    int result = CTGetSignalStrength();
    NSLog(@"result====%d",result);
    return result;
}

#pragma mark wifi
+ (id)getSSIDInfo
{
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    
    NSLog(@"Supported interfaces: %@", ifs);
    
    id info = nil;
    
    for (NSString *ifnam in ifs)
    {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        
        NSLog(@"%@ => %@", ifnam, info );  //单个数据info[@"SSID"]; info[@"BSSID"];
        
        if (info && [info count])
            break;
    }
    NSLog(@"=====%@",info);
    return info;
}

#pragma mark 获取内网IP
+ (NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}

#pragma mark 获取运营商
+ (CTCarrier *)getCarrierInfo
{
    // 获取运营商信息
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = info.subscriberCellularProvider;
    NSLog(@"carrier:%@", [carrier description]);
    
    // 输出手机的数据业务信息
    NSLog(@"Radio Access Technology:%@", info.currentRadioAccessTechnology);
    
    // 如果运营商变化将更新运营商输出
    info.subscriberCellularProviderDidUpdateNotifier = ^(CTCarrier *carrier)
    {
        NSLog(@"carrier:%@", [carrier description]);
    };
    
    return carrier;
}

#pragma mark 获取电量 (5%精确度)
+ (float)getBatteryLevel
{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    float deviceLevel = [UIDevice currentDevice].batteryLevel;
    NSLog(@"deviceLevel===%.2f",deviceLevel);
    return deviceLevel;
}


#pragma mark 获取电量 （<1%精确度）
+ (float)getAccurateBatteryLevel
{
    //Returns a blob of Power Source information in an opaque CFTypeRef.
    CFTypeRef blob = IOPSCopyPowerSourcesInfo();
    
    //Returns a CFArray of Power Source handles, each of type CFTypeRef.
    CFArrayRef sources = IOPSCopyPowerSourcesList(blob);
    
    CFDictionaryRef pSource = NULL;
    const void *psValue;
    
    //Returns the number of values currently in an array.
    int numOfSources = CFArrayGetCount(sources);
    
    //Error in CFArrayGetCount
    if (numOfSources == 0)
    {
        NSLog(@"Error in CFArrayGetCount");
        return -1.0f;
    }
    
    //Calculating the remaining energy
    for (int i = 0 ; i < numOfSources ; i++)
    {
        //Returns a CFDictionary with readable information about the specific power source.
        pSource = IOPSGetPowerSourceDescription(blob, CFArrayGetValueAtIndex(sources, i));
        if (!pSource)
        {
            NSLog(@"Error in IOPSGetPowerSourceDescription");
            return -1.0f;
        }
        psValue = (CFStringRef)CFDictionaryGetValue(pSource, CFSTR(kIOPSNameKey));
        
        int curCapacity = 0;
        int maxCapacity = 0;
        double percent;
        
        psValue = CFDictionaryGetValue(pSource, CFSTR(kIOPSCurrentCapacityKey));
        CFNumberGetValue((CFNumberRef)psValue, kCFNumberSInt32Type, &curCapacity);
        
        psValue = CFDictionaryGetValue(pSource, CFSTR(kIOPSMaxCapacityKey));
        CFNumberGetValue((CFNumberRef)psValue, kCFNumberSInt32Type, &maxCapacity);
        
        percent = ((double)curCapacity/(double)maxCapacity * 100.0f);
        NSLog(@"deviceLevel===%.2f",percent);
        return percent;
    }
    return -1.0f;

}

@end
