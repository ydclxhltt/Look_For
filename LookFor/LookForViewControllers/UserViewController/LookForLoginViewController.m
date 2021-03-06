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
    
    [self setNavBarItemWithTitle:@"注册"
                     navItemType:rightItem
                    selectorName:@"handleRegister"];
    [self.loginView.loginButton addTarget:self action:@selector(handleLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.forgetButton addTarget:self action:@selector(handleForget) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView addTarget:self action:@selector(handleResponder) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucess) name:LOGIN_SUECESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFail) name:LOGIN_FAIL object:nil];
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

- (void)handleCancel
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)handleRegister
{
    LookForRegisterViewController *rv = [[LookForRegisterViewController alloc] init];
    [self.navigationController pushViewController:rv animated:YES];
}

#pragma mark 登录
- (void)handleLogin
{
    if ([self isCanCommit])
    {
        [LookForRequestTool loginWithMobile:self.loginView.userTextField.text userPassword:self.loginView.passwordTextField.text];
    }
}

- (BOOL)isCanCommit
{
    NSString *password = self.loginView.passwordTextField.text;
    password = (password) ? password : @"";
    
    NSString *mobile = self.loginView.userTextField.text;
    mobile = (mobile) ? mobile : @"";
    
    NSString *message = @"";
    if (mobile.length == 0)
    {
        message = MOBILE_NULL;
    }
    else if (![CommonTool isEmailOrPhoneNumber:mobile])
    {
        message = MOBILE_ERROR;
    }
    else if (password.length == 0)
    {
        message = PASSWORD_NULL;
    }
    
    if ([@"" isEqualToString:message])
    {
        return YES;
    }
    else
    {
        [CommonTool addAlertTipWithMessage:message];
        return NO;
    }
}

- (void)loginSucess
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loginFail
{
    [CommonTool addAlertTipWithMessage:@"登录成功"];
}


#pragma mark 忘记密码
- (void)handleForget
{
    LookForVerifiedCodeViewController *rv = [[LookForVerifiedCodeViewController alloc] initWithType:ModifyPhoneType withIsNewPhone:NO];
    [self.navigationController pushViewController:rv animated:YES];
}

- (void)handleResponder
{
    [self.loginView.passwordTextField resignFirstResponder];
    [self.loginView.userTextField resignFirstResponder];
}

@end
