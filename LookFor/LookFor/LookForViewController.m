//
//  LookForViewController.m
//  LookFor
//
//  Created by chenmingguo on 14-12-29.
//  Copyright (c) 2014年 chenmingguo. All rights reserved.
//

#import "LookForViewController.h"

@interface LookForViewController ()

@end

@implementation LookForViewController

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeSystem];
    bu.frame = CGRectMake(0, 0, 100, 100);
    bu.backgroundColor = [UIColor redColor];
    [bu setTitle:@"111" forState:UIControlStateNormal];
    [self.view addSubview:bu];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
