//
//  LookFor_Application.h
//  LookFor
//
//  Created by chenlei on 15/1/7.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

/*
 *  保存全局变量
 */

#import <Foundation/Foundation.h>

@interface LookFor_Application : NSObject

//记录选中的地图视图
@property (nonatomic, assign) int selectedAnnonationIndex;

/*
 *  构建单例
 */
+ (instancetype)shareInstance;
@end
