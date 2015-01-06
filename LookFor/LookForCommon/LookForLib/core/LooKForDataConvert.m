//
//  FOMADataConvert.m
//  FOMA_Iphone
//
//  Created by chenmingguo on 14-6-14.
//  Copyright (c) 2014 SMARTGROUP. All rights reserved.
//

#import "LooKForDataConvert.h"
#import "LookForCoreDefs.h"
@implementation LooKForDataConvert

+ (BOOL)checkNull:(NSString *)isNull {
    if (isNull == nil || isNull == (id)[NSNull null]) {
        return YES;
    }
    return NO;
}

+ (QJUser *)UserConvert:(NSDictionary *)userDictionary {
    QJUser *user = [QJUser shareInstance];

    if (userDictionary == nil && ![userDictionary isKindOfClass:[NSDictionary class]]) {
        return user;
    }
    
    user.userId = [[userDictionary valueForKey:USERIDKEY] integerValue];
    user.loginName = [userDictionary valueForKey:LOGINNAMEKEY];
    user.passWord = [userDictionary valueForKey:PASSWORDKEY];
    user.sex = [[userDictionary valueForKey:SEXKEY] integerValue];
    user.nickName = [userDictionary valueForKey:NICKNAMEKEY];
    user.email = [userDictionary valueForKey:EMAILKEY];
    user.headImageUrl = [userDictionary valueForKey:HEADIMAGEURLKEY];
    user.level = [[userDictionary valueForKey:LEVELKEY] integerValue];
    user.phone = [userDictionary valueForKey:PHONEKEY];
    
    return user;
}

+ (QJUser *)UserInfo:(NSDictionary *)userDictionary {
    
    if (userDictionary == nil && ![userDictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    QJUser *user = [[QJUser alloc] init];

    user.userId = [[userDictionary valueForKey:USERIDKEY] integerValue];
    user.loginName = [userDictionary valueForKey:LOGINNAMEKEY];
    user.passWord = [userDictionary valueForKey:PASSWORDKEY];
    user.sex = [[userDictionary valueForKey:SEXKEY] integerValue];
    user.nickName = [userDictionary valueForKey:NICKNAMEKEY];
    user.email = [userDictionary valueForKey:EMAILKEY];
    user.headImageUrl = [userDictionary valueForKey:HEADIMAGEURLKEY];
    user.level = [[userDictionary valueForKey:LEVELKEY] integerValue];
    user.phone = [userDictionary valueForKey:PHONEKEY];
    
    return user;
}

+ (QJCatalog *)CatalogConvert:(NSDictionary *)dictionary withParentId:(NSString *)parentId {
    if (dictionary == nil && ![dictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    QJCatalog *catalog = [[QJCatalog alloc] init];
    catalog.parentId = parentId;
    catalog.catalogId = [dictionary valueForKey:CATALOGIDKYE];
    catalog.catelogName = [dictionary valueForKey:CATALOGNAMEKEY];
    catalog.infoUrl = [dictionary valueForKey:INFOURLKEY];
    catalog.type = [[dictionary objectForKey:TYPEKEY] integerValue];
    catalog.catalogDescription = [dictionary objectForKey:CATALOGDESKEY];
    catalog.imageUrl = [dictionary objectForKey:IMAGEURLKEY];
    return catalog;
}

@end



