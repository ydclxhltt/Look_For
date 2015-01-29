//
//  LookForLBSTpyeViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-1-29.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForLBSTpyeViewController.h"
#import "LookForRightSelectTableViewCell.h"


@interface LookForLBSTpyeViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LookForLBSTpyeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarItemWithImageName:@"btn_back" navItemType:LeftItem
                        selectorName:@"handleCancel"];

    
    [self addTableViewWithFrame:CGRectMake(0, DefaultSpace, MAIN_SCREEN_SIZE.width, self.view.frame.size.height)
                      tableType:UITableViewStylePlain
                  tableDelegate:self];
    self.table.separatorColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

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
    return 50;
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
    
    if (row == 0) {
        cell.titleText = @"地图模式";
        if ([UserDefaults integerForKey:LBSMapTypeKey] == LBSMapTypeStandard) {
            [cell setSelectImage:@"selected.png"];
        } else {
        [cell setSelectImage:@"select_default.png"];
        }
    } else {
        cell.titleText = @"卫星模式";
        if ([UserDefaults integerForKey:LBSMapTypeKey] == LBSMapTypeSatellite) {
            [cell setSelectImage:@"selected.png"];
        } else {
            [cell setSelectImage:@"select_default.png"];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSUInteger row = [indexPath row];
    if (row == 0) {
        [UserDefaults setInteger:LBSMapTypeStandard forKey:LBSMapTypeKey];
    }else {
        [UserDefaults setInteger:LBSMapTypeSatellite forKey:LBSMapTypeKey];
    }
    
}

@end
