//
//  FOMADataConvert.h
//  FOMA_Iphone
//
//  Created by chenmingguo on 14-6-14.
//  Copyright (c) 2014 SMARTGROUP. All rights reserved.
//data convert class

#import <Foundation/Foundation.h>
#import "LookForContentModel.h"

@interface LooKForDataConvert : NSObject

+ (QJUser *)UserConvert:(NSDictionary *)userDictionary;

+ (QJCatalog *)CatalogConvert:(NSDictionary *)dictionary withParentId:(NSString *)parentId;

@end

