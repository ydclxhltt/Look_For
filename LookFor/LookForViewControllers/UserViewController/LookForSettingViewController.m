//
//  LookForSettingViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-1-25.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForSettingViewController.h"
#import "LookForSettingTableViewCell.h"
#import "LookForLBSTpyeViewController.h"
#import "LookForSelectFriendViewController.h"


@interface LookForSettingViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation LookForSettingViewController

- (void)loadView {
    [super loadView];
    [self initView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self setNavBarItemWithTitle:@"取消"
                     navItemType:LeftItem
                    selectorName:@"handleCancel"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -custom
- (void)initView {
  
    [self addTableViewWithFrame:CGRectMake(0, 0, MAIN_SCREEN_SIZE.width, self.view.frame.size.height)
                      tableType:UITableViewStylePlain
                  tableDelegate:self];
    self.table.separatorColor = [UIColor clearColor];
}

#pragma mark -handle
- (void)handleCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleLogOut {

}
#pragma -message
#pragma mark - TableView Datasource And Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *displayCellIdentifier = @"LookForSelectFriendTableViewCell";
    
    NSUInteger row = [indexPath row];
    NSUInteger section = [indexPath section];
    
    LookForSettingTableViewCell *cell = (LookForSettingTableViewCell *) [tableView dequeueReusableCellWithIdentifier:displayCellIdentifier];
    if (cell == nil) {
        cell = (LookForSettingTableViewCell *)[[LookForSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: displayCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    if (section == 0) {
        if (row == 0) {
            cell.titleText = @"地图展示方式";
        } else if (row == 1) {
            cell.titleText = @"闭眼权限设置";

        } else if (row == 2) {
            cell.titleText = @"常用地址";

        } else {
            cell.titleText = @"添加默认联系人";

        }
    } else {
        if (row == 0) {
            cell.titleText = @"版本更新";

        } else {
            cell.titleText = @"关于我们";
        
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 15)];
    head.backgroundColor = kTableViewGrayColor;
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 1) {
        return 60;
    }else {
        return  0;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_SIZE.width, 60)];
        view.backgroundColor = kTableViewGrayColor;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 20, MAIN_SCREEN_SIZE.width, 40);
        button.backgroundColor = [UIColor redColor];
        [button addTarget:self
                   action:@selector(handleLogOut)
         forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:button];
        return view;
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSUInteger section = [indexPath section];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIViewController *vc = nil;
    if (section == 0) {
        if (row == 0) {
            vc = [[LookForLBSTpyeViewController alloc] init];
        } else if (row == 1) {
            vc = [[LookForSelectFriendViewController alloc] initWithTitle:@"闭眼权限设置"];
        } else if (row == 2) {
        
        } else {
            vc = [[LookForSelectFriendViewController alloc] initWithTitle:@"默认联系人"];
        }
    } else {
        if (row == 0) {
            
        } else {
            
        }
    }
    [self.navigationController pushViewController:vc animated:YES];
}

@end
