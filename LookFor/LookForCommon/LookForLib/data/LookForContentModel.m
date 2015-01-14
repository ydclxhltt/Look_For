
//
//  QJContentModel.m
//  QuanJianApp
//
//  Created by chenmingguo on 14-8-24.
//  Copyright (c) 2014年 why. All rights reserved.
//

#import "LookForContentModel.h"
#import <objc/runtime.h>

@implementation LookForContentModel

- (id)initWithDictionary:(NSDictionary*) dicionary
{
    self = [self init];
    if(self && dicionary)
    {
        [self objectFromDictionary:dicionary];
    }
    
    return self;
}


- (NSMutableDictionary *)makeDictionary:(NSDictionary*) dicionary
{
    //次产品数据接口特殊处理
    NSMutableDictionary *responseDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *bodyDic = [dicionary objectForKey:@"body"];
    for (NSString *key in bodyDic.allKeys)
    {
        if ([bodyDic objectForKey:key])
        {
            [responseDic setValue:[bodyDic objectForKey:key] forKey:key];
        }
    }
    return responseDic;
}

- (void)objectFromDictionary:(NSDictionary *) dicionary
{
    NSArray *aryList = [self objPropertyList];
    for (NSString *name in aryList) {
        id obj = [dicionary objectForKey:name];
        if (!obj)
            continue;
        if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]])
        {
            [self setValue:obj forKeyPath:name];
        }

    }
}
//获取自己以及父类的属性(使得object支持继承)
- (NSArray*)objPropertyList
{
    unsigned int propCount, i;
    NSMutableArray *propertyList = [NSMutableArray array];
    Class cl;
    cl = [self class];
    while (![NSStringFromClass(cl) isEqualToString:@"NSObject"])
    {
        objc_property_t* properties = class_copyPropertyList(cl, &propCount);
        for (i = 0; i < propCount; i++)
        {
            objc_property_t prop = *properties;
            const char *propName = property_getName(prop);
            if(propName)
            {
                NSString *name = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
                [propertyList addObject:name];
            }
            properties++;
        }
        free((properties -= propCount));
        cl = [cl superclass];
    }
    return propertyList;
}
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

- (id)init
{
    self = [super init];
    if (self) {
        self.userId = 0;
        self.sex = 0;
        self.level = 0;
    }
    return self;
}
+ (QJUser *)shareInstance
{
    
    if (_shareInstance != nil)
    {
        return _shareInstance;
    }
    
    @synchronized(self)
    {
        if (_shareInstance == nil)
        {
            _shareInstance = [[self alloc] init];
        }
    }
    return _shareInstance;
}
@end


#pragma mark 请求返回头
@implementation LookFor_ResponseMessage

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary*) dicionary
{
    self = [super initWithDictionary:[[dicionary objectForKey:@"response"] objectForKey:@"header"]];
    
    return self;
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
