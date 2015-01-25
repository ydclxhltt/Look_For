//
//  LookForNickNameViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-1-22.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForNickNameViewController.h"

#define HeadViewH       80
#define LeftSpace       15
#define TopSpace        10
#define TextViweH       80

#define PlaceholderText @"给自己取个美妙的名称吧"


@interface LookForNickNameViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UIView        *headView;              //view
@property (nonatomic, strong) UITextView    *messageTextView;       //输入框
@property (nonatomic, strong) UILabel       *placeholderLabel;      //输入框默认字体
@end

@implementation LookForNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"输入昵称";
    [self setNavBarItemWithTitle:@"取消"
                     navItemType:LeftItem
                    selectorName:@"handleCancel"];
    [self createHeaderView];
    
    UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor yellowColor];
    button.frame = CGRectMake(LeftSpace, self.headView.frame.origin.y + self.headView.frame.size.height + LeftSpace , MAIN_SCREEN_SIZE.width - 2*LeftSpace, 40);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    button.layer.cornerRadius = button.frame.size.height / 2;
    button.layer.masksToBounds = YES;
    [button addTarget:self
                         action:@selector(handleSure)
               forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - custom
//创建top输入框和图
- (void)createHeaderView {
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0,60, MAIN_SCREEN_SIZE.width, HeadViewH)];
    self.headView.backgroundColor = [UIColor whiteColor];
    self.messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(LeftSpace,
                                                                        TopSpace,
                                                                        MAIN_SCREEN_SIZE.width - 2*LeftSpace, TextViweH)];
    
    self.messageTextView.textColor = [UIColor blackColor];
    self.messageTextView.font = [UIFont systemFontOfSize:13];
    self.messageTextView.delegate = self;
    self.messageTextView.backgroundColor = [UIColor clearColor];
    // self.messageTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    self.messageTextView.keyboardType = UIKeyboardTypeDefault;
    self.messageTextView.contentInset = UIEdgeInsetsMake(-60, 0, 0, 0);
    [self.headView addSubview:self.messageTextView];
    
    self.placeholderLabel =[[UILabel alloc] initWithFrame:CGRectMake(5, 5, MAIN_SCREEN_SIZE.width, 12)];
    self.placeholderLabel.font = [UIFont fontWithName:@"Arial" size:13.0];//设置字体名字和字体大小
    self.placeholderLabel.text = PlaceholderText;
    self.placeholderLabel.textColor = [UIColor lightGrayColor];
    self.placeholderLabel.backgroundColor = [UIColor clearColor];
    [self.messageTextView addSubview:self.placeholderLabel];
    
    
    UIView *headLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_SIZE.width, 0.5)];
    headLine.backgroundColor = SeparatorLineColor;
    [self.headView addSubview:headLine];
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, HeadViewH - 0.5, MAIN_SCREEN_SIZE.width, 0.5)];
    bottomLine.backgroundColor = SeparatorLineColor;
    [self.headView addSubview:bottomLine];

   
    [self.view addSubview:self.headView];
}


#pragma mark -handle
- (void)handleCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleSure {

}
#pragma mark -UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.placeholderLabel.hidden =YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (self.messageTextView.text.length==0) {
        self.placeholderLabel.hidden =NO;
    }else{
        self.placeholderLabel.hidden =YES;
    }
}

@end
