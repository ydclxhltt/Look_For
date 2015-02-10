//
//  LookForMyCirleViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-2-1.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForMyCirleViewController.h"

#import "LookForAssemblyTableViewCell.h"

@interface LookForMyCirleViewController ()

@end

@implementation LookForMyCirleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的圈圈";
    
    [self setNavBarItemWithImageName:@"btn_back"
                         navItemType:LeftItem
                        selectorName:@"handleCancel"];
    
    [self addTableViewWithFrame:CGRectMake(0, DefaultSpace, MAIN_SCREEN_SIZE.width, self.view.frame.size.height)
                      tableType:UITableViewStylePlain
                  tableDelegate:self];
    self.table.separatorColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -handle
- (void)handleCancel {
    [self.navigationController popViewControllerAnimated:YES];
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
    static NSString *displayCellIdentifier = @"LookForAssemblyTableViewCell";
    
    NSUInteger row = [indexPath row];
    LookForAssemblyTableViewCell *cell = (LookForAssemblyTableViewCell *) [tableView dequeueReusableCellWithIdentifier:displayCellIdentifier];
    if (cell == nil) {
        cell = (LookForAssemblyTableViewCell *)[[LookForAssemblyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: displayCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    cell.titleText = @"1111";
    cell.detailText = @"33333";
    cell.headImage = [UIImage imageNamed:@"1.jpg"];
    [cell showSwitch];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSUInteger row = [indexPath row];
}


@end
