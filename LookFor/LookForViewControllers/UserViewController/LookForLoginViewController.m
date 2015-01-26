//
//  LookForLoginViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-1-12.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "LookForLoginViewController.h"
#import "LookForLoginView.h"
#import "LookForRegisterViewController.h"
#import "LookForNickNameViewController.h"
#import "LookForVerifiedCodeViewController.h"
#ifdef iphone5
#define LOGINBOX_OFFSET_Y   (-60)
#else
#define LOGINBOX_OFFSET_Y   (-40)
#endif

@interface LookForLoginViewController ()

@property (nonatomic, strong) LookForLoginView *loginView;

@end

@implementation LookForLoginViewController

- (void)loadView {
    [super loadView];
    self.loginView = [[LookForLoginView alloc] initWithFrame:self.view.bounds];
    self.loginView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.loginView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self setNavBarItemWithTitle:@"取消"
                     navItemType:LeftItem
                    selectorName:@"handleCancel"];
    
    [self setNavBarItemWithTitle:@"注册新用户"
                     navItemType:rightItem
                    selectorName:@"handleRegister"];
    [self.loginView.loginButton addTarget:self action:@selector(handleLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.forgetButton addTarget:self action:@selector(handleForget) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView addTarget:self action:@selector(handleResponder) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // self.navigationController.navigationBarHidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - keyborad notify

- (void)keyboardWillAppear:(NSNotification *)notification
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:0.3];
    
    CGFloat offsetY = 0;
    if (SCREEN_4_INCH)
    {
        offsetY = -0;
    }
    else if (SCREEN_3_5_INCH)
    {
        offsetY = -0;
    }
    _loginView.frame = CGRectMake(0,
                                  offsetY,
                                  _loginView.frame.size.width,
                                  _loginView.frame.size.height);
    
    [UIView commitAnimations];
}

- (void)keyboardWillDisappear:(NSNotification *) notification
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _loginView.frame = self.view.bounds;
    
    [UIView commitAnimations];
    
    // _handleLogin = NO;
}

#pragma mark -handle
- (void)handleCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleRegister {
    LookForRegisterViewController *rv = [[LookForRegisterViewController alloc] init];
    
    [self.navigationController pushViewController:rv animated:YES];
}

- (void)handleLogin {
    
}

- (void)handleForget {
    LookForVerifiedCodeViewController *rv = [[LookForVerifiedCodeViewController alloc] initWithType:ModifyPhoneType withIsNewPhone:NO];
    
    [self.navigationController pushViewController:rv animated:YES];
//    LookForModifyPhoneViewController *p = [[LookForModifyPhoneViewController alloc] init];
//    [self.navigationController pushViewController:p animated:YES];
}

- (void)handleResponder {
    [self.loginView.passwordTextField resignFirstResponder];
    [self.loginView.userTextField resignFirstResponder];
}

@end
