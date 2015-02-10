//
//  LookForAssemblyViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-1-18.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForAssemblyViewController.h"
#import "LookForCallTogetherViewController.h"
#import "LookForAssemblyTableViewCell.h"

#define LeftSpace       15
#define DefaultSpace    10
#define TitleLabelH     13
@interface LookForAssemblyViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation LookForAssemblyViewController

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadView {
    [super loadView];
    [self initView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"集结号";
    [self setNavBarItemWithImageName:@"btn_back"
                         navItemType:LeftItem
                        selectorName:@"handleCancel"];
    
    [self setNavBarItemWithImageName:@"add"
                         navItemType:rightItem
                        selectorName:@"handleAddle"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -custom

- (void)initView {
    UILabel *topTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(LeftSpace, 70, MAIN_SCREEN_SIZE.width, TitleLabelH)];
    topTitleLabel.backgroundColor = [UIColor clearColor];
    topTitleLabel.textColor = [UIColor blackColor];
    topTitleLabel.font = [UIFont systemFontOfSize:12];
    topTitleLabel.textAlignment = NSTextAlignmentLeft;
    topTitleLabel.text = @"正在参加";
    [self.view addSubview:topTitleLabel];
  
    [self addTableViewWithFrame:CGRectMake(0, topTitleLabel.frame.origin.y + TitleLabelH + 5, MAIN_SCREEN_SIZE.width, MAIN_SCREEN_SIZE.height - topTitleLabel.frame.origin.x - TitleLabelH) tableType:UITableViewStylePlain tableDelegate:self];
    self.table.separatorColor = [UIColor clearColor];
    self.table.backgroundColor = [UIColor clearColor];
}

#pragma mark -handle 

- (void)handleCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleAddle {
    LookForCallTogetherViewController *ct = [[LookForCallTogetherViewController alloc] init];
    
    [self.navigationController pushViewController:ct animated:YES];
}

#pragma -message
#pragma mark - TableView Datasource And Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *displayCellIdentifier = @"LookForAssemblyTableViewCell";
    
   // NSUInteger row = [indexPath row];
    LookForAssemblyTableViewCell *cell = (LookForAssemblyTableViewCell *) [tableView dequeueReusableCellWithIdentifier:displayCellIdentifier];
    if (cell == nil) {
        cell = (LookForAssemblyTableViewCell *)[[LookForAssemblyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: displayCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    cell.titleText = @"111111";
    cell.detailText = @"22222";
    cell.timeText = @"333";
    cell.headImage = [UIImage imageNamed:@"1.jpg"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
  //  NSUInteger row = [indexPath row];
    
}

@end
