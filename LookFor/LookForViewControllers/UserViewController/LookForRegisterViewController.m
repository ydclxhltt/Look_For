//
//  LookForRegisterViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-1-12.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//修改密码和注册通用

#import "LookForRegisterViewController.h"
#import <SMS_SDK/SMS_SDK.h>

#define LeftSpace           15
#define Default             10
#define HeadImageWH         13
#define TextBgViewH         132
#define TextFieldH          44
#define TextSapce           0
#define ResetButtonW        60

@interface LookForRegisterViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *textBgView;   //
@property (nonatomic, strong) UIImageView *phoneNumberHeadImage;    //用户名头的图片
@property (nonatomic, strong) UIImageView *verifiedHeadImage;       //用户秘密头的图片
@property (nonatomic, strong) UITextField *passwordTextField;       //密码
@property (nonatomic, strong) UITextField *phoneNumberTextField;    //
@property (nonatomic, strong) UITextField *verifiedTextField;       //验证码
@property (nonatomic, strong) UIButton    *loginButton;

@end

@implementation LookForRegisterViewController



- (void)loadView {
    [super loadView];
    self.textBgView = [[UIView alloc] initWithFrame:CGRectMake(0,Default*8, MAIN_SCREEN_SIZE.width, TextBgViewH)];
    self.textBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textBgView];
    
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_SIZE.width, 0.5)];
    topLine.backgroundColor = SeparatorLineColor;
    [self.textBgView addSubview:topLine];
    
    UIView *buttomLine = [[UIView alloc] initWithFrame:CGRectMake(0, TextBgViewH - 0.5, MAIN_SCREEN_SIZE.width, 0.5)];
    buttomLine.backgroundColor = SeparatorLineColor;
    [self.textBgView addSubview:buttomLine];
    
    //    self.phoneNumberHeadImage = [[UIImageView alloc] initWithFrame:CGRectMake(LeftSpace, (TextBgViewH / 2 - HeadImageWH) / 2, HeadImageWH, HeadImageWH)];
    //    [self.textBgView addSubview:self.phoneNumberHeadImage];
    //
    //    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.phoneNumberHeadImage.frame.size.width + LeftSpace, self.phoneNumberHeadImage.frame.origin.y, 45, HeadImageWH)];
    //    nameLabel.text = @"手机号:";
    //    nameLabel.textColor = [UIColor blackColor];
    //    nameLabel.font = [UIFont systemFontOfSize:13];
    //    nameLabel.backgroundColor = [UIColor clearColor];
    //    nameLabel.textAlignment = NSTextAlignmentRight;
    //    [self.textBgView addSubview:nameLabel];
    
    
    self.phoneNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(LeftSpace, TextSapce / 2, MAIN_SCREEN_SIZE.width - 2*LeftSpace, TextFieldH)];
    self.phoneNumberTextField.textAlignment = NSTextAlignmentLeft;
    self.phoneNumberTextField.placeholder = @"请输入手机号码";
    self.phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumberTextField.textColor = TitleColor;
    self.phoneNumberTextField.backgroundColor = [UIColor clearColor];
    self.phoneNumberTextField.delegate = self;
    self.phoneNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextChanged:) name:UITextFieldTextDidChangeNotification object:self.phoneNumberTextField];
    self.phoneNumberTextField.font = [UIFont systemFontOfSize:14];
    [self.textBgView addSubview:self.phoneNumberTextField];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.phoneNumberTextField.frame.origin.y + TextFieldH + TextSapce / 2, MAIN_SCREEN_SIZE.width, 0.5)];
    line.backgroundColor = SeparatorLineColor;
    [self.textBgView addSubview:line];
    
    
    
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(LeftSpace, self.phoneNumberTextField.frame.origin.y + TextFieldH + TextSapce, MAIN_SCREEN_SIZE.width - 2 * LeftSpace, TextFieldH)];
    self.passwordTextField.textAlignment = NSTextAlignmentLeft;
    self.passwordTextField.placeholder = @"请输入密码";
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.textColor = TitleColor;
    self.passwordTextField.backgroundColor = [UIColor clearColor];
    self.passwordTextField.delegate = self;
    self.passwordTextField.font = [UIFont systemFontOfSize:14];
    [self.textBgView addSubview:self.passwordTextField];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.passwordTextField.frame.origin.y + TextFieldH + TextSapce / 2, MAIN_SCREEN_SIZE.width, 0.5)];
    line1.backgroundColor = SeparatorLineColor;
    [self.textBgView addSubview:line1];
    
    self.verifiedTextField = [[UITextField alloc] initWithFrame:CGRectMake(LeftSpace, self.passwordTextField.frame.origin.y + TextFieldH + TextSapce, MAIN_SCREEN_SIZE.width - 2 * LeftSpace - Default - ResetButtonW, TextFieldH)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextChanged:) name:UITextFieldTextDidChangeNotification object:self.verifiedTextField];
    self.verifiedTextField.textAlignment = NSTextAlignmentLeft;
    self.verifiedTextField.placeholder = @"请输入验证码";
    self.verifiedTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.verifiedTextField.textColor = TitleColor;
    self.verifiedTextField.backgroundColor = [UIColor clearColor];
    self.verifiedTextField.delegate = self;
    self.verifiedTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.verifiedTextField.font = [UIFont systemFontOfSize:14];
    [self.textBgView addSubview:self.verifiedTextField];
    
    UIView *line2  = [[UIView alloc] initWithFrame:CGRectMake(self.verifiedTextField.frame.size.width + LeftSpace, self.verifiedTextField.frame.origin.y - 3, 0.5, 44)];
    line2.backgroundColor = SeparatorLineColor;
    [self.textBgView addSubview:line2];
    
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    resetButton.frame = CGRectMake(MAIN_SCREEN_SIZE.width - Default- ResetButtonW, self.verifiedTextField.frame.origin.y, ResetButtonW, TextFieldH);
    [resetButton setTitle:@"重新获取" forState:UIControlStateNormal];
    [resetButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    resetButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [resetButton addTarget:self action:@selector(handleVerified) forControlEvents:UIControlEventTouchUpInside];
    [self.textBgView addSubview:resetButton];
    
    
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.backgroundColor = [UIColor yellowColor];
    self.loginButton.frame = CGRectMake(LeftSpace, self.textBgView.frame.size.height + self.textBgView.frame.origin.y + Default*2, MAIN_SCREEN_SIZE.width - 2*LeftSpace, 44);
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setTitle:@"注册" forState:UIControlStateNormal];
    self.loginButton.layer.cornerRadius = self.loginButton.frame.size.height / 2;
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.backgroundColor = RGB(240, 196, 48);

    [self.loginButton addTarget:self
                         action:@selector(handleRegister)
               forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.loginButton];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    
    
    [self setNavBarItemWithTitle:@"取消"
                     navItemType:LeftItem
                    selectorName:@"handleCancel"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -handle
- (void)handleCancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleSure
{
    
}

- (void)handleVerified
{
    NSString *message = @"";
    NSString *phoneNumber = self.phoneNumberTextField.text;
    phoneNumber = (phoneNumber) ? phoneNumber : @"";
    if (phoneNumber.length == 0)
    {
        message = MOBILE_NULL;
    }
    else if (![CommonTool isEmailOrPhoneNumber:phoneNumber])
    {
        message = MOBILE_ERROR;
    }
    if (![@"" isEqualToString:message])
    {
        [CommonTool addAlertTipWithMessage:message];
        return;
    }
    [SMS_SDK getVerificationCodeByVoiceCallWithPhone:phoneNumber zone:@"86" result:^(SMS_SDKError *error)
    {
        NSLog(@"error===%@",error);
    }];
}

- (void)handleRegister
{
    if (![self isCanCommit])
    {
        return;
    }
    
    [SMS_SDK commitVerifyCode:@"" result:^(enum SMS_ResponseState state)
    {
        if (state == SMS_ResponseStateSuccess)
        {
            [self registerRequest];
        }
        else if (state == SMS_ResponseStateFail)
        {
            [CommonTool addAlertTipWithMessage:CODE_ERROR];
        }
    }];
}


- (BOOL)isCanCommit
{
    NSString *message = @"";
    
    NSString *phoneNumber = self.phoneNumberTextField.text;
    phoneNumber = (phoneNumber) ? phoneNumber : @"";
    
    NSString *password = self.passwordTextField.text;
    password = (password) ? password : @"";
    
    NSString *code = self.verifiedTextField.text;
    code = (code) ? code : @"";
    
    if (phoneNumber.length == 0)
    {
        message = MOBILE_NULL;
    }
    else if (![CommonTool isEmailOrPhoneNumber:phoneNumber])
    {
        message = MOBILE_ERROR;
    }
    else if (password.length == 0)
    {
        message = PASSWORD_NULL;
    }
    else if (code.length == 0)
    {
        message = CODE_NULL;
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

#pragma mark registerRequest
- (void)registerRequest
{
    
}


#pragma mark UITextFieldNotification
- (void)textFieldTextChanged:(NSNotification *)notification
{
    UITextField *textField = (UITextField *)notification.object;
    if (textField == self.phoneNumberTextField)
    {
        if (self.phoneNumberTextField.text.length > 11)
        {
            self.phoneNumberTextField.text = [self.phoneNumberTextField.text stringByReplacingCharactersInRange:NSMakeRange(11, self.phoneNumberTextField.text.length - 11) withString:@""];
        }
    }
    if (textField == self.verifiedTextField)
    {
        if (self.verifiedTextField.text.length > 4)
        {
            self.phoneNumberTextField.text = [self.phoneNumberTextField.text stringByReplacingCharactersInRange:NSMakeRange(4, self.phoneNumberTextField.text.length - 4) withString:@""];
        }
    }
}


@end
