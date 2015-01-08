//
//  LookForSafeTravelViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-1-8.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "LookForSafeTravelViewController.h"

#define HeadViewH       150
#define LeftSpace       15
#define ImageWH         60
#define TopSpace        10
#define TextViweH       70

#define PlaceholderText @"我想说点什么......"

@interface LookForSafeTravelViewController () <UITextViewDelegate>

@property (nonatomic, strong) UITextView    *messageTextView;
@property (nonatomic, strong) UIImageView   *photoImageView;
@property (nonatomic, strong) UILabel       *placeholderLabel;
@end

@implementation LookForSafeTravelViewController

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = RGB(242, 242, 244);
    [self initView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"安心出行";
    [self setNavBarItemWithTitle:@"取消"
                     navItemType:LeftItem
                    selectorName:@"handleCancel"];
    
    [self setNavBarItemWithImageName:@"poi_1"
                         navItemType:rightItem
                        selectorName:@"handleCamera"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark -custom
- (void)initView {
    [self createHeaderView];
}

//创建top输入框和图
- (void)createHeaderView {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0,60, MAIN_SCREEN_SIZE.width, HeadViewH)];
    headView.backgroundColor = [UIColor whiteColor];
    self.messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(LeftSpace,
                                                                 TopSpace,
                                                                 MAIN_SCREEN_SIZE.width - 2*LeftSpace, TextViweH)];

    self.messageTextView.textColor = [UIColor blackColor];
    self.messageTextView.font = [UIFont systemFontOfSize:13];
    self.messageTextView.delegate = self;
    self.messageTextView.backgroundColor = [UIColor clearColor];
    self.messageTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    self.messageTextView.keyboardType = UIKeyboardTypeDefault;
    self.messageTextView.contentInset = UIEdgeInsetsMake(-60, 0, 0, 0);
    [headView addSubview:self.messageTextView];
    
    self.placeholderLabel =[[UILabel alloc] initWithFrame:CGRectMake(5, 5, 80, 12)];
    self.placeholderLabel.font = [UIFont fontWithName:@"Arial" size:13.0];//设置字体名字和字体大小
    self.placeholderLabel.text = PlaceholderText;
    self.placeholderLabel.textColor = [UIColor lightGrayColor];
    self.placeholderLabel.backgroundColor = [UIColor clearColor];
    [self.messageTextView addSubview:self.placeholderLabel];
    
    self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(LeftSpace,
                                                                        self.messageTextView.frame.origin.y + self.messageTextView.frame.size.height,
                                                                        ImageWH, ImageWH)];
    self.photoImageView.backgroundColor = [UIColor redColor];
    [headView addSubview:self.photoImageView];
    
    [self.view addSubview:headView];
}

#pragma mark -handle
- (void)handleCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleCamera {

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
