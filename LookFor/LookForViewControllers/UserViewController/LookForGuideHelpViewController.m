//
//  ELGuideHelpViewController.m
//  ELWork
//
//  Created by chenmingguo on 14-4-14.
//  Copyright (c) 2014年 hu. All rights reserved.
//

#import "LookForGuideHelpViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface LookForGuideHelpViewController ()

@end

@implementation LookForGuideHelpViewController

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View lifecycle
- (void)handleBack
{
  // [APP_DELEGATE addMainView];
    [APP_DELEGATE addMainView];
}

- (void)animateBack
{}

- (void)handleGS:(UISwipeGestureRecognizer *)aGS
{
    if (aGS.direction == UISwipeGestureRecognizerDirectionRight)
    {
        if (_curIndex > 0)
        {
            --_curIndex;
            [_scrollView scrollRectToVisible:CGRectMake(_curIndex*320, 0, 320, 460) animated:YES];
            
            _pageControl.currentPage = _curIndex;
        }
    } else if (aGS.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (_curIndex < self.count) {
            if (_curIndex == 3) {
                [btn setTitle:@"点击进入" forState:UIControlStateNormal];
            }
            ++_curIndex;
            [_scrollView scrollRectToVisible:CGRectMake(_curIndex*320, 0, 320, 460) animated:YES];
            
            _pageControl.currentPage = _curIndex;
        } else {
            [APP_DELEGATE addMainView];
        }
    }
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    
    self.count = 5;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 50)];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollEnabled = NO;
    _scrollView.contentSize = CGSizeMake(320*self.count, self.view.frame.size.height - 50);
    [self.view addSubview:_scrollView ];
    
    for (NSInteger index = 0; index < self.count; ++index) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(index*320, 0, 320, _scrollView.frame.size.height)];
        if (SCREEN_3_5_INCH) {
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"start_0%ld.jpg", index + 1]];
        } else {
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"start320_0%ld.jpg", index + 1]];
        }
        
        [_scrollView addSubview:imageView];
    }
    if (SCREEN_3_5_INCH) {
       _pageControl = [[LookForPageControl alloc] initWithFrame:CGRectMake(0, _scrollView.frame.size.height - 200, 320, 30)];
    } else {
        _pageControl = [[LookForPageControl alloc] initWithFrame:CGRectMake(0, _scrollView.frame.size.height - 170, 320, 30)];
    }
    
    _pageControl.hidesForSinglePage = YES;
    _pageControl.numberOfPages = self.count;
    [_pageControl setDotsImageAcitvie:[UIImage imageNamed:@"dot_sel.png"] andInactive:[UIImage imageNamed:@"dot_normal.png"]];
    _pageControl.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_pageControl];
    
    
    UIView *buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 49,
                                                                  320, 50)];
    UIView *lines = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    lines.backgroundColor = [UIColor lightGrayColor];
    [buttomView addSubview:lines];
    
     btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[btn setBackgroundImage:[UIImage imageNamed:@"text_frame.png"] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5.0;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor redColor].CGColor;
 
    [btn setTitle:@"登入账户" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.frame = CGRectMake(0, 0, 80, 30);
    [btn addTarget:self action:@selector(handleBack) forControlEvents:UIControlEventTouchUpInside];
    btn.center = CGPointMake(buttomView.center.x, 25);
    [self.view addSubview:btn];

    [buttomView addSubview:btn];
    [self.view addSubview:buttomView];
    
    UISwipeGestureRecognizer *lGS = [[UISwipeGestureRecognizer alloc] init];
    lGS.direction = UISwipeGestureRecognizerDirectionLeft;
    [lGS addTarget:self action:@selector(handleGS:)];
    [self.view addGestureRecognizer:lGS];
    
    UISwipeGestureRecognizer *rGS = [[UISwipeGestureRecognizer alloc] init];
    rGS.direction = UISwipeGestureRecognizerDirectionRight;
    [rGS addTarget:self action:@selector(handleGS:)];
    [self.view addGestureRecognizer:rGS];
    
    _curIndex = 0;
}

@end
