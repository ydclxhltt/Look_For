//
//  LookForApplyViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-1-29.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForApplyViewController.h"
#import "LookForApplyTableViewCell.h"

@interface LookForApplyViewController () <UITableViewDataSource, UITableViewDelegate>

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
    [self addTableViewWithFrame:CGRectMake(0, DefaultSpace, MAIN_SCREEN_SIZE.width, self.view.frame.size.height)
                      tableType:UITableViewStylePlain
                  tableDelegate:self];
    self.table.separatorColor = [UIColor clearColor];
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

#pragma -message
#pragma mark - TableView Datasource And Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *displayCellIdentifier = @"LookForApplyTableViewCell";
    
    NSUInteger row = [indexPath row];
    LookForApplyTableViewCell *cell = (LookForApplyTableViewCell *) [tableView dequeueReusableCellWithIdentifier:displayCellIdentifier];
    if (cell == nil) {
        cell = (LookForApplyTableViewCell *)[[LookForApplyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: displayCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    cell.typeText = @"23222";
    cell.timeText = @"1111";
    cell.nameText = @"3333dfd";
    cell.messageText = @"44444";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSUInteger row = [indexPath row];
}


@end
