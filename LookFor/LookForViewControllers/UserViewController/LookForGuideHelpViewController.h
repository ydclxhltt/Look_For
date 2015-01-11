//
//  ELGuideHelpViewController.h
//  ELWork
//
//  Created by chenmingguo on 14-4-14.
//  Copyright (c) 2014年 hu. All rights reserved.
//

#import "BasicViewController.h"
#import "LookForPageControl.h"

@interface LookForGuideHelpViewController :BasicViewController
{
    NSInteger _curIndex;
    UIScrollView *_scrollView;
    LookForPageControl *_pageControl;
    UIButton *btn;
}
@property (nonatomic, assign) NSInteger count;
@end
