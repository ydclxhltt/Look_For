//
//  QJContentService.m
//  QuanJianApp
//
//  Created by chenmingguo on 14-8-24.
//  Copyright (c) 2014年 why. All rights reserved.
//

#import "LookForContentService.h"
#import "LookForDataConvert.h"
#import "DBManager.h"

static LookForContentService *_shareInstance = nil;

@interface LookForContentService ()


@property (nonatomic, strong) QJCatalogModelManager *catalogModelManager;

@end



@implementation LookForContentService

- (id)init {
    self = [super init];
    if (self) {
        _catalogModelManager = [[QJCatalogModelManager alloc] init];
    }
    return self;
}

+ (LookForContentService *)shareInstance {
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

#pragma mark -catalog
- (QJCatalogModel *)getLocalCatalogModel:(NSString *)parentId {
    QJCatalogModel *model = [_catalogModelManager getCatalogModel:parentId];
    [model.catalogList removeAllObjects];
   // [model.catalogList addObjectsFromArray:[[DBManager sharedInstance] selectCatalogList:parentId]];
    return model;
}

- (QJCatalogModel *)getCatalogModel:(NSString *)parentId {
    return [_catalogModelManager getCatalogModel:parentId];
}

- (void)setCatalog:(NSArray *)catalogArray withParentId:(NSString *)parentId {
    if (catalogArray == nil) {
        return;
    }
    QJCatalogModel *model = [_catalogModelManager getCatalogModel:parentId];
    [model.catalogList removeAllObjects];
    
    for (NSDictionary *dic in catalogArray) {
        QJCatalog *cat = [LooKForDataConvert CatalogConvert:dic withParentId:parentId];
        [model.catalogList addObject:cat];
       // [[DBManager sharedInstance] insertCatalog:cat];
    }
    
}

@end
