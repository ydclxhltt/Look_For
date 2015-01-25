//
//  LookForRegisterViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-1-12.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "LookForRegisterViewController.h"

#define LeftSpace           15
#define Default             10
#define HeadImageWH         13
#define TextBgViewH         80
#define TextFieldH          30

@interface LookForRegisterViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *textBgView;   //
@property (nonatomic, strong) UIImageView *phoneNumberHeadImage;           //用户名头的图片
@property (nonatomic, strong) UIImageView *verifiedHeadImage;       //用户秘密头的图片
@property (nonatomic, strong) UITextField *phoneNumberTextField;           //用户名
@property (nonatomic, strong) UITextField *verifiedTextField;       //密码
@property (nonatomic, assign) BOOL isRegister;
@property (nonatomic, strong) UIButton    *loginButton;

@end

@implementation LookForRegisterViewController

- (id)initIsRegister:(BOOL)isRegister {
    self = [super init];
    if (self) {
        self.isRegister = isRegister;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.textBgView = [[UIView alloc] initWithFrame:CGRectMake(0,Default*2, MAIN_SCREEN_SIZE.width, TextBgViewH)];
    self.textBgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.textBgView];
    
    
    self.phoneNumberHeadImage = [[UIImageView alloc] initWithFrame:CGRectMake(LeftSpace, (TextBgViewH / 2 - HeadImageWH) / 2, HeadImageWH, HeadImageWH)];
    [self.textBgView addSubview:self.phoneNumberHeadImage];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.phoneNumberHeadImage.frame.size.width + LeftSpace, self.phoneNumberHeadImage.frame.origin.y, 45, HeadImageWH)];
    nameLabel.text = @"手机号:";
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont systemFontOfSize:13];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textAlignment = NSTextAlignmentRight;
    [self.textBgView addSubview:nameLabel];
    
    float textFieldX = nameLabel.frame.origin.x + nameLabel.frame.size.width;
    
    self.phoneNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(textFieldX, (TextBgViewH / 2 - TextFieldH) / 2, MAIN_SCREEN_SIZE.width - textFieldX - LeftSpace, TextFieldH)];
    self.phoneNumberTextField.textAlignment = NSTextAlignmentLeft;
    self.phoneNumberTextField.placeholder = @"请输入手机号码";
    self.phoneNumberTextField.textColor = [UIColor blackColor];
    self.phoneNumberTextField.backgroundColor = [UIColor clearColor];
    self.phoneNumberTextField.delegate = self;
    self.phoneNumberTextField.font = [UIFont systemFontOfSize:12];
    [self.textBgView addSubview:self.phoneNumberTextField];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, TextBgViewH / 2, MAIN_SCREEN_SIZE.width, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.textBgView addSubview:line];
    
    self.verifiedHeadImage = [[UIImageView alloc] initWithFrame:CGRectMake(LeftSpace, (TextBgViewH - (TextBgViewH / 2 - HeadImageWH) / 2 - HeadImageWH), HeadImageWH, HeadImageWH)];
    [self.textBgView addSubview:self.verifiedHeadImage];
    
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.verifiedHeadImage.frame.size.width + LeftSpace, self.verifiedHeadImage.frame.origin.y, 45, HeadImageWH)];
    passwordLabel.text = @"验证码:";
    passwordLabel.textColor = [UIColor blackColor];
    passwordLabel.font = [UIFont systemFontOfSize:13];
    passwordLabel.backgroundColor = [UIColor clearColor];
    passwordLabel.textAlignment = NSTextAlignmentRight;
    [self.textBgView addSubview:passwordLabel];
    
    self.verifiedTextField = [[UITextField alloc] initWithFrame:CGRectMake(textFieldX, (TextBgViewH - (TextBgViewH / 2 - TextFieldH) / 2 - TextFieldH), MAIN_SCREEN_SIZE.width - textFieldX - LeftSpace, TextFieldH)];
    self.verifiedTextField.textAlignment = NSTextAlignmentLeft;
    self.verifiedTextField.placeholder = @"请输入验证码";
    self.verifiedTextField.textColor = [UIColor blackColor];
    self.verifiedTextField.backgroundColor = [UIColor clearColor];
    self.verifiedTextField.delegate = self;
    self.verifiedTextField.font = [UIFont systemFontOfSize:12];
    [self.textBgView addSubview:self.verifiedTextField];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.frame = CGRectMake(LeftSpace, self.textBgView.frame.size.height + self.textBgView.frame.origin.y + Default*2, MAIN_SCREEN_SIZE.width - 2*LeftSpace, 44);
    [self.loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (self.isRegister) {
        [self.loginButton setTitle:@"注册" forState:UIControlStateNormal];

    } else {
        [self.loginButton setTitle:@"找回密码" forState:UIControlStateNormal];

    }
    [self.view addSubview:self.loginButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
