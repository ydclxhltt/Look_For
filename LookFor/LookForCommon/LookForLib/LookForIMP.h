//
//  FOMAIMP.h
//  AFNetworking iOS Example
//
//  Created by chenmingguo on 14-6-11.
//  Copyright (c) 2014 SMARTGROUP. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LookForIMP : NSObject

+ (LookForIMP *)shareInstance;

/**
 * @brief   login interface
 * @param 	name
 * @param 	passWord
 */

- (void)login:(NSString *)passWord
     withName:(NSString *)name;

/**
 * @brief   获取目录
 * @param 	parentId       父目录id
 */
- (void)getCatalogList:(NSString *)parentId;

@end
