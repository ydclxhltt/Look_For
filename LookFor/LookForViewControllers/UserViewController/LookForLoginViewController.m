//
//  LookForLoginViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-1-12.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "LookForLoginViewController.h"
#import "LookForLoginView.h"

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
    self.loginView.userHeadImage.image = [UIImage imageNamed:@"poi_1.png"];
    self.loginView.logoImageView.image = [UIImage imageNamed:@"poi_1.png"];;
    self.loginView.passwordHeadImage.image = [UIImage imageNamed:@"poi_1.png"];
    [self.loginView.loginButton setImage:[UIImage imageNamed:@"poi_1.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.loginView];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

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
    if (iPhone5)
    {
        offsetY = -30;
    }
    else
    {
        offsetY = -110;
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


@end
