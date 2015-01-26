//
//  LookForModifyPhoneViewController.h
//  LookFor
//
//  Created by chenmingguo on 15-1-22.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//短信验证码界面

#import "BasicViewController.h"

@interface LookForVerifiedCodeViewController : BasicViewController


/*
 * type类型，表示是修改手机，密码，忘记密码
 * 修改手机号码是游泳，isNewPhone 当前是否未新手机号界面
 */
- (id)initWithType:(ModifyType)type withIsNewPhone:(BOOL)isNewPhone;
@end
