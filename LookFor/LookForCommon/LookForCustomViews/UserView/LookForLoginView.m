//
//  LookForLoginView.m
//  LookFor
//
//  Created by chenmingguo on 15-1-12.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "LookForLoginView.h"

#define LogoImageH          100
#define LeftSpace           15
#define Default             10
#define HeadImageWH         13
#define TextBgViewH         80
#define TextFieldH          30


@interface LookForLoginView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *textBgView;   //

@end

@implementation LookForLoginView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, MAIN_SCREEN_SIZE.width, LogoImageH)];
        self.logoImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.logoImageView];
        
        self.textBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.logoImageView.frame.size.height + self.logoImageView.frame.origin.y + Default*2, MAIN_SCREEN_SIZE.width, TextBgViewH)];
        self.textBgView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.textBgView];
    
        
        self.userHeadImage = [[UIImageView alloc] initWithFrame:CGRectMake(LeftSpace, (TextBgViewH / 2 - HeadImageWH) / 2, HeadImageWH, HeadImageWH)];
        [self.textBgView addSubview:self.userHeadImage];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userHeadImage.frame.size.width + LeftSpace, self.userHeadImage.frame.origin.y, 45, HeadImageWH)];
        nameLabel.text = @"用户名:";
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont systemFontOfSize:13];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textAlignment = NSTextAlignmentRight;
        [self.textBgView addSubview:nameLabel];
        
        float textFieldX = nameLabel.frame.origin.x + nameLabel.frame.size.width;
        
        self.userTextField = [[UITextField alloc] initWithFrame:CGRectMake(textFieldX, (TextBgViewH / 2 - TextFieldH) / 2, MAIN_SCREEN_SIZE.width - textFieldX - LeftSpace, TextFieldH)];
        self.userTextField.textAlignment = NSTextAlignmentLeft;
        self.userTextField.placeholder = @"请输入用户名";
        self.userTextField.textColor = [UIColor blackColor];
        self.userTextField.backgroundColor = [UIColor clearColor];
        self.userTextField.delegate = self;
        self.userTextField.font = [UIFont systemFontOfSize:12];
        [self.textBgView addSubview:self.userTextField];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, TextBgViewH / 2, MAIN_SCREEN_SIZE.width, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.textBgView addSubview:line];
        
        self.passwordHeadImage = [[UIImageView alloc] initWithFrame:CGRectMake(LeftSpace, (TextBgViewH - (TextBgViewH / 2 - HeadImageWH) / 2 - HeadImageWH), HeadImageWH, HeadImageWH)];
        [self.textBgView addSubview:self.passwordHeadImage];
        
        UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.passwordHeadImage.frame.size.width + LeftSpace, self.passwordHeadImage.frame.origin.y, 45, HeadImageWH)];
        passwordLabel.text = @"密码:";
        passwordLabel.textColor = [UIColor blackColor];
        passwordLabel.font = [UIFont systemFontOfSize:13];
        passwordLabel.backgroundColor = [UIColor clearColor];
        passwordLabel.textAlignment = NSTextAlignmentRight;
        [self.textBgView addSubview:passwordLabel];
        
        self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(textFieldX, (TextBgViewH - (TextBgViewH / 2 - TextFieldH) / 2 - TextFieldH), MAIN_SCREEN_SIZE.width - textFieldX - LeftSpace, TextFieldH)];
        self.passwordTextField.textAlignment = NSTextAlignmentLeft;
        self.passwordTextField.placeholder = @"请输入密码";
        self.passwordTextField.textColor = [UIColor blackColor];
        self.passwordTextField.backgroundColor = [UIColor clearColor];
        self.passwordTextField.delegate = self;
        self.passwordTextField.font = [UIFont systemFontOfSize:12];
        [self.textBgView addSubview:self.passwordTextField];
        
        self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.loginButton.frame = CGRectMake(LeftSpace, self.textBgView.frame.size.height + self.textBgView.frame.origin.y + Default*2, MAIN_SCREEN_SIZE.width - 2*LeftSpace, 44);
        [self.loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [self addSubview:self.loginButton];
    }
    return self;
}

- (BOOL)checkEmpty
{
    return (self.passwordTextField.text.length == 0 || self.userTextField.text.length == 0);
}

- (void)show
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1];
    [self setAlpha:1.0f];
    [UIView commitAnimations];
}

- (void)disappear
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1];
    [self setAlpha:0.0f];
    [UIView commitAnimations];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.userTextField)
    {
        [self.passwordTextField becomeFirstResponder];
    }
    else
    {
        [textField endEditing:YES];
    }
    return YES;
}

@end
