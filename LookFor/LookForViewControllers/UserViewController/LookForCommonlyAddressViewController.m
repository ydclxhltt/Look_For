//
//  LookForCommonlyAddressViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-1-29.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForCommonlyAddressViewController.h"
#import "LookForRightSelectTableViewCell.h"

@interface LookForCommonlyAddressViewController ()<LookForRightSelectTableViewCellDelegate,UITableViewDataSource,UITableViewDelegate>

@end

@implementation LookForCommonlyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItemWithImageName:@"btn_back"
                         navItemType:LeftItem
                        selectorName:@"handleCancel"];

    [self setNavBarItemWithImageName:@"add"
                         navItemType:rightItem
                        selectorName:@"handleAdd"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -handle
- (void)handleCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleAdd {

}


#pragma -message
#pragma mark - TableView Datasource And Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *displayCellIdentifier = @"LookForRightSelectTableViewCell";
    
    NSUInteger row = [indexPath row];
    LookForRightSelectTableViewCell *cell = (LookForRightSelectTableViewCell *) [tableView dequeueReusableCellWithIdentifier:displayCellIdentifier];
    if (cell == nil) {
        cell = (LookForRightSelectTableViewCell *)[[LookForRightSelectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: displayCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    [cell setDeleteImageName:@"delete"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSUInteger row = [indexPath row];
}

@end
