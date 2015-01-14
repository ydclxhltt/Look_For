//
//  QJContentModel.h
//  QuanJianApp
//
//  Created by chenmingguo on 14-8-24.
//  Copyright (c) 2014年 why. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LookForObjectModel : NSObject

- (id)initWithDictionary:(NSDictionary*) dicionary;

@end


@interface QJUser : LookForObjectModel

@property (nonatomic, strong) NSString *loginName;          //登录名称
@property (nonatomic, strong) NSString *passWord;           //密码
@property (nonatomic, assign) NSInteger userId;             //用户id
@property (nonatomic, assign) NSInteger sex;                //性别
@property (nonatomic, strong) NSString *nickName;           //昵称
@property (nonatomic, strong) NSString *email;              //邮箱
@property (nonatomic, strong) NSString *headImageUrl;       //头像url
@property (nonatomic, assign) NSInteger level;              //级别
@property (nonatomic, strong) NSString *phone;

+ (QJUser *)shareInstance;

@end

@interface LookFor_ResponseMessage : LookForObjectModel

@property (nonatomic, strong) NSString *rc;
@property (nonatomic, strong) NSString *rm;

@end



#pragma mark -catalog
//目录
@interface QJCatalog : LookForObjectModel

@property (nonatomic, strong) NSString *parentId;           //父目录id
@property (nonatomic, strong) NSString *catalogId;          //目录id
@property (nonatomic, strong) NSString *catelogName;        //目录名称
@property (nonatomic, strong) NSString *infoUrl;            //uerl
@property (nonatomic, assign) NSInteger type;               //目录类型0：图文，1:文字 ，2:视频  ，3:城市，4:问答

//详情才会用到
@property (nonatomic, strong) NSString *catalogDescription; // 描述
@property (nonatomic, strong) NSString *imageUrl;          //图片url
@end


@interface QJCatalogModel : LookForObjectModel

@property (nonatomic, strong) NSString *parentId;
@property (nonatomic, strong) NSMutableArray *catalogList;

@end

@interface QJCatalogModelManager : LookForObjectModel

@property (nonatomic, strong) NSMutableArray *catalogModelList;

- (QJCatalogModel *)getCatalogModel:(NSString *)parentId;
@end


