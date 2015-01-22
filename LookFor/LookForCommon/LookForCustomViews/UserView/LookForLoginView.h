//
//  LookForLoginView.h
//  LookFor
//
//  Created by chenmingguo on 15-1-12.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookForLoginView : UIControl

@property (nonatomic, strong) UIImageView *logoImageView;           //logo

@property (nonatomic, strong) UIImageView *userHeadImage;           //用户名头的图片
@property (nonatomic, strong) UIImageView *passwordHeadImage;       //用户秘密头的图片
@property (nonatomic, strong) UITextField *userTextField;           //用户名
@property (nonatomic, strong) UITextField *passwordTextField;       //密码

@property (nonatomic, strong) UIButton    *loginButton;

@property (nonatomic, strong) UIButton    *forgetButton;            //忘记密码

- (BOOL)checkEmpty;
- (void)show;
- (void)disappear;
@end
