//
//  BasicViewController.m
//  SmallPig
//
//  Created by clei on 14/11/5.
//  Copyright (c) 2014年 chenlei. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController ()<UIGestureRecognizerDelegate>
{

}
@end

@implementation BasicViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    startHeight = 0.0;
    //设置页面背景
    self.view.backgroundColor =  BASIC_VIEW_BG_COLOR;
    
    //设置导航条
    //self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    //self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self.navigationController.navigationBar setBackgroundImage:[CommonTool imageWithColor:APP_MAIN_COLOR] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationController.navigationBar.translucent = YES;
    /*
     *  效果等同IOS7 automaticallyAdjustsScrollViewInsets
     *
     *  UIScrollView *scrollView;
     *  UIEdgeInsets inset = scrollView.contentInset;
     *  inset.top = 64.0;
     *  scrollView.contentInset = inset;
     */
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}



#pragma mark 设置导航条Item

// 1.设置导航条Item
- (void)setNavBarItemWithTitle:(NSString *)title navItemType:(NavItemType)type selectorName:(NSString *)selName
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60, 30);
    button.titleLabel.font = FONT(17.0);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    if (selName && ![@"" isEqualToString:selName])
    {
        [button addTarget:self action:NSSelectorFromString(selName) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem  *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    if(LeftItem == type)
        self.navigationItem.leftBarButtonItem = barItem;
    else if (rightItem == type)
        self.navigationItem.rightBarButtonItem = barItem;
}


// 2.设置导航条Item
- (void)setNavBarItemWithImageName:(NSString *)imageName navItemType:(NavItemType)type selectorName:(NSString *)selName
{
    UIImage *image_up = [UIImage imageNamed:[imageName stringByAppendingString:@"_up.png"]];
    UIImage *image_down = [UIImage imageNamed:[imageName stringByAppendingString:@"_down.png"]];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, image_up.size.width/2, image_up.size.height/2);
    [button setBackgroundImage:image_up forState:UIControlStateNormal];
    [button setBackgroundImage:image_down forState:UIControlStateHighlighted];
    [button setBackgroundImage:image_down forState:UIControlStateSelected];
    if (selName && ![@"" isEqualToString:selName])
    {
        [button addTarget:self action:NSSelectorFromString(selName) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem  *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    if(LeftItem == type)
        self.navigationItem.leftBarButtonItem = barItem;
    else if (rightItem == type)
        self.navigationItem.rightBarButtonItem = barItem;
}

#pragma mark 添加返回Item
//添加返回按钮
- (void)addBackItem
{
    [self setNavBarItemWithImageName:@"back" navItemType:LeftItem selectorName:@"backButtonPressed:"];
}

- (void)backButtonPressed:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 添加个人Item
//添加个人按钮
- (void)addPersonalItem
{
    [self setNavBarItemWithImageName:@"personal" navItemType:LeftItem selectorName:@"personalButtonPressed:"];
}

- (void)personalButtonPressed:(UIButton *)sender
{
    
}



#pragma mark 添加表
//添加表
- (void)addTableViewWithFrame:(CGRect)frame tableType:(UITableViewStyle)type tableDelegate:(id)delegate
{
    _table=[[UITableView alloc]initWithFrame:frame style:type];
    _table.dataSource=delegate;
    _table.delegate=delegate;
    _table.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_table];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
