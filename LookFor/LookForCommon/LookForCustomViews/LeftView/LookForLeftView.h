//
//  LookForLeftView.h
//  LookFor
//
//  Created by clei on 15/1/23.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookForLeftView : UIView

/*
 * 显示
 */
- (void)show;

/*
 * 设置数据
 *
 * @pram name     用户名
 * @pram uerID    用户ID
 * @pram userSex  用户性别
 * @pram imageUrl 用户头像地址
 */
- (void)setUserInfoWithName:(NSString *)name userID:(NSString *)uerID userSex:(int)sex imageUrl:(NSString *)imageUrl;

@end
