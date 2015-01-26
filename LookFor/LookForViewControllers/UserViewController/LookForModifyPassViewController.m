//
//  LookForModifyPassPhoneViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-1-26.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForModifyPassViewController.h"

#define TextBgViewH   88
#define TextFieldH          38
#define TextSapce           6
@interface LookForModifyPassViewController ()

@property (nonatomic, assign) ModifyType type;
@property (nonatomic, strong) UIView *textBgView;   //
@property (nonatomic, strong) UITextField *passwordTextField;       //密码
@property (nonatomic, strong) UITextField *phoneNumberTextField;    //
@end

@implementation LookForModifyPassViewController

- (id)initWithType:(ModifyType)type {
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    [self initView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItemWithTitle:@"完成"
                     navItemType:rightItem
                    selectorName:@"handleSure"];
    
    
    
    [self setNavBarItemWithTitle:@"取消"
                     navItemType:LeftItem
                    selectorName:@"handleCancel"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -custom
- (void)initView {
    self.textBgView = [[UIView alloc] initWithFrame:CGRectMake(0,DefaultSpace*8, MAIN_SCREEN_SIZE.width, TextBgViewH)];
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

        self.phoneNumberTextField.placeholder = @"请输入密码";

    self.phoneNumberTextField.textColor = [UIColor blackColor];
    self.phoneNumberTextField.backgroundColor = [UIColor clearColor];
    self.phoneNumberTextField.font = [UIFont systemFontOfSize:12];
    [self.textBgView addSubview:self.phoneNumberTextField];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.phoneNumberTextField.frame.origin.y + TextFieldH + TextSapce / 2, MAIN_SCREEN_SIZE.width, 0.5)];
    line.backgroundColor = SeparatorLineColor;
    [self.textBgView addSubview:line];
    
    
    
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(LeftSpace, self.phoneNumberTextField.frame.origin.y + TextFieldH + TextSapce, MAIN_SCREEN_SIZE.width - 2 * LeftSpace, TextFieldH)];
    self.passwordTextField.textAlignment = NSTextAlignmentLeft;
    
        self.passwordTextField.placeholder = @"请再次输入密码";

    self.passwordTextField.textColor = [UIColor blackColor];
    self.passwordTextField.backgroundColor = [UIColor clearColor];
    self.passwordTextField.font = [UIFont systemFontOfSize:12];
    [self.textBgView addSubview:self.passwordTextField];
}


- (void)handleCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleSure {
}

@end
