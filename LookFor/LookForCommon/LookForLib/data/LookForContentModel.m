
//
//  QJContentModel.m
//  QuanJianApp
//
//  Created by chenmingguo on 14-8-24.
//  Copyright (c) 2014年 why. All rights reserved.
//

#import "LookForContentModel.h"

@implementation LookForContentModel

@end


static QJUser *_shareInstance = nil;
@implementation QJUser
@synthesize loginName;          //登录名称
@synthesize passWord;           //密码
@synthesize userId;             //用户id
@synthesize sex;                //性别
@synthesize nickName;           //昵称
@synthesize email;              //邮箱
@synthesize headImageUrl;       //头像url
@synthesize level;              //级别
@synthesize phone;

- (id)init {
    self = [super init];
    if (self) {
        self.userId = 0;
        self.sex = 0;
        self.level = 0;
    }
    return self;
}
+ (QJUser *)shareInstance {
    
    if (_shareInstance != nil) {
        return _shareInstance;
    }
    
    @synchronized(self) {
        if (_shareInstance == nil) {
            _shareInstance = [[self alloc] init];
        }
    }
    return _shareInstance;
}
@end

#pragma mark - catalog
@implementation QJCatalog
@synthesize parentId;
@synthesize catalogId;
@synthesize catelogName;
@synthesize infoUrl;
@synthesize type;
@synthesize imageUrl;
@synthesize catalogDescription;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end

@implementation QJCatalogModel
@synthesize catalogList;
@synthesize parentId;

- (id)init {
    self = [super init];
    if (self) {
        catalogList = [[NSMutableArray alloc] init];
    }
    return self;
}

@end

@implementation QJCatalogModelManager

@synthesize catalogModelList;

- (id)init {
    self = [super init];
    if (self) {
        catalogModelList = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (QJCatalogModel *)getCatalogModel:(NSString *)parentId {
    QJCatalogModel *result = nil;
    
    for (QJCatalogModel *model in catalogModelList)
    {
        if ([model.parentId isEqualToString:parentId])
        {
            result = model;
        }
    }
    
    if (result == nil)
    {
        result = [[QJCatalogModel alloc] init];
        result.parentId = parentId;
        [catalogModelList addObject:result];
    }
    return result;
}
@end
