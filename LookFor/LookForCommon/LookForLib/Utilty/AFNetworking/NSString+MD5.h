//
//  NSString+MD5.h
//  FOMA_Iphone
//
//  Created by ma.wenqiu on 14-7-10.
//  Copyright (c) 2014 SMARTGROUP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (MD5)

-(NSString *)md5HexDigest;
-(NSString *)imageType;
-(NSString *)imageFullName;
-(NSString *)imageName;
@end
