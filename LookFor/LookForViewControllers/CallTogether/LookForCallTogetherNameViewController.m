//
//  LookForCallTogetherNameViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-1-13.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "LookForCallTogetherNameViewController.h"

@interface LookForCallTogetherNameViewController ()

@property (nonatomic, strong) UITextField *nameTextField;

@end

@implementation LookForCallTogetherNameViewController

@synthesize delegate;
- (void)loadView {
    [super loadView];
    
    [self initView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"召集名称";
    [self setNavBarItemWithTitle:@"取消"
                     navItemType:LeftItem
                    selectorName:@"handleCancel"];
    
    [self setNavBarItemWithTitle:@"确定"
                     navItemType:rightItem
                    selectorName:@"handleSure"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -custom

- (void)initView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 80, MAIN_SCREEN_SIZE.width, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_SIZE.width, 0.5)];
    topLine.backgroundColor = SeparatorLineColor;
    [view addSubview:topLine];
    UIView *buttomLine = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height - 0.5, MAIN_SCREEN_SIZE.width, 0.5)];
    buttomLine.backgroundColor = SeparatorLineColor;
    [view addSubview:buttomLine];
    
    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 1, MAIN_SCREEN_SIZE.width - 30, 38)];
    self.nameTextField.placeholder = @"请输入召集姓名";
    self.nameTextField.font = [UIFont systemFontOfSize:12];
    self.nameTextField.textColor = [UIColor blackColor];
    [view addSubview:self.nameTextField];
    
    [self.view addSubview:view];
}

#pragma mark -handle
- (void)handleCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleSure {

    if ([self.delegate respondsToSelector:@selector(callTogetherName:)]) {
        [self.delegate callTogetherName:self.nameTextField.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}



@end
