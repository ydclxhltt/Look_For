//
//  LookForApplyViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-1-29.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForApplyViewController.h"

@interface LookForApplyViewController ()

@end

@implementation LookForApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的申请";
    
    [self setNavBarItemWithImageName:@"btn_back"
                         navItemType:LeftItem
                        selectorName:@"handleCancel"];
    
    [self setNavBarItemWithTitle:@"清空"
                     navItemType:rightItem
                    selectorName:@"handleClear"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -handle
- (void)handleCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleClear {

}

@end
