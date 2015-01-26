//
//  LookForModifyPhoneViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-1-22.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForVerifiedCodeViewController.h"

#import "LookForModifyPassViewController.h"

#define LeftSpace           15
#define Default             10
#define HeadImageWH         13
#define TextBgViewH         88
#define TextFieldH          38
#define TextSapce           6
#define ResetButtonW        60
@interface LookForVerifiedCodeViewController ()
@property (nonatomic, strong) UIView *textBgView;   //
@property (nonatomic, strong) UITextField *phoneNumberTextField;    //
@property (nonatomic, strong) UITextField *verifiedTextField;       //验证码
@property (nonatomic, assign) ModifyType  type;
@property (nonatomic, assign) BOOL isNewPhone;
@end

@implementation LookForVerifiedCodeViewController

- (id)initWithType:(ModifyType)type withIsNewPhone:(BOOL)isNewPhone {
    self = [super init];
    if (self) {
        self.type = type;
        self.isNewPhone = isNewPhone;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    [self initView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.type == ModifyForgetPassType) {
        self.title = @"忘记密码";

    } else if (self.type == ModifyPassWordType) {
        self.title = @"修改密码";

    } else {
        self.title = @"修改手机号码";

    }
    
    
    [self setNavBarItemWithTitle:@"完成"
                     navItemType:rightItem
                    selectorName:@"handleSure"];
    
    
    
    [self setNavBarItemWithTitle:@"取消"
                     navItemType:LeftItem
                    selectorName:@"handleCancel"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -custom
- (void)initView {
    self.textBgView = [[UIView alloc] initWithFrame:CGRectMake(0,Default*8, MAIN_SCREEN_SIZE.width, TextBgViewH)];
    self.textBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textBgView];
    
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_SIZE.width, 0.5)];
    topLine.backgroundColor = SeparatorLineColor;
    [self.textBgView addSubview:topLine];
    
    UIView *buttomLine = [[UIView alloc] initWithFrame:CGRectMake(0, TextBgViewH - 0.5, MAIN_SCREEN_SIZE.width, 0.5)];
    buttomLine.backgroundColor = SeparatorLineColor;
    [self.textBgView addSubview:buttomLine];
    self.phoneNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(LeftSpace, TextSapce / 2, MAIN_SCREEN_SIZE.width - 2*LeftSpace, TextFieldH)];
    self.phoneNumberTextField.textAlignment = NSTextAlignmentLeft;
    if (self.type == ModifyPassWordType) {
        if (self.isNewPhone) {
            self.phoneNumberTextField.placeholder = @"请输入新手机号码";

        } else {
            self.phoneNumberTextField.placeholder = @"请输入旧手机号码";
        }
    } else {
        self.phoneNumberTextField.placeholder = @"请输入手机号码";
    }
    self.phoneNumberTextField.textColor = [UIColor blackColor];
    self.phoneNumberTextField.backgroundColor = [UIColor clearColor];
    self.phoneNumberTextField.font = [UIFont systemFontOfSize:12];
    [self.textBgView addSubview:self.phoneNumberTextField];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.phoneNumberTextField.frame.origin.y + TextFieldH + TextSapce / 2, MAIN_SCREEN_SIZE.width, 0.5)];
    line.backgroundColor = SeparatorLineColor;
    [self.textBgView addSubview:line];
    
    
    self.verifiedTextField = [[UITextField alloc] initWithFrame:CGRectMake(LeftSpace, self.phoneNumberTextField.frame.origin.y + TextFieldH + TextSapce, MAIN_SCREEN_SIZE.width - 2 * LeftSpace - Default - ResetButtonW, TextFieldH)];
    
    self.verifiedTextField.textAlignment = NSTextAlignmentLeft;
    self.verifiedTextField.placeholder = @"请输入验证码";
    self.verifiedTextField.textColor = [UIColor blackColor];
    self.verifiedTextField.backgroundColor = [UIColor clearColor];
    self.verifiedTextField.font = [UIFont systemFontOfSize:12];
    [self.textBgView addSubview:self.verifiedTextField];
    
    UIView *line2  = [[UIView alloc] initWithFrame:CGRectMake(self.verifiedTextField.frame.size.width + LeftSpace, self.verifiedTextField.frame.origin.y - 3, 0.5, 44)];
    line2.backgroundColor = SeparatorLineColor;
    [self.textBgView addSubview:line2];
    
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    resetButton.frame = CGRectMake(MAIN_SCREEN_SIZE.width - Default- ResetButtonW, self.verifiedTextField.frame.origin.y, ResetButtonW, TextFieldH);
    [resetButton setTitle:@"重新获取" forState:UIControlStateNormal];
    [resetButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    resetButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [resetButton addTarget:self action:@selector(handleVerified) forControlEvents:UIControlEventTouchUpInside];
    [self.textBgView addSubview:resetButton];
}

#pragma mark -handle

- (void)handleVerified {
    
}

- (void)handleCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleSure {
    if (self.isNewPhone) {
        
        return;
    }
    
    UIViewController *vc = nil;
    if (self.type == ModifyPassWordType || self.type == ModifyForgetPassType) {
        vc = [[LookForModifyPassViewController alloc] initWithType:self.type];
    } else {
        vc = [[LookForVerifiedCodeViewController alloc] initWithType:self.type withIsNewPhone:YES];
    }
    
    if (vc != nil) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
