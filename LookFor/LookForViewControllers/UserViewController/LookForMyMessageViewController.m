//
//  LookForMyMessageViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-1-27.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForMyMessageViewController.h"
#import "LookForMyMessageTableViewCell.h"



@interface LookForMyMessageViewController ()<UITableViewDataSource, UITableViewDelegate,LookForMyMessageTableViewCellDelegate>

@end

@implementation LookForMyMessageViewController

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的消息";
    
    [self setNavBarItemWithTitle:@"清除"
                     navItemType:rightItem
                    selectorName:@"handleClear"];
    
    [self setNavBarItemWithTitle:@"取消"
                     navItemType:LeftItem
                    selectorName:@"handleCancel"];
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
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *displayCellIdentifier = @"LookForMyMessageTableViewCell";
    
    NSUInteger row = [indexPath row];
    LookForMyMessageTableViewCell *cell = (LookForMyMessageTableViewCell *) [tableView dequeueReusableCellWithIdentifier:displayCellIdentifier];
    if (cell == nil) {
        cell = (LookForMyMessageTableViewCell *)[[LookForMyMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: displayCellIdentifier];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    cell.titleText = @"1111";
    cell.detailText = @"222";
    cell.imageName = @"poi_1.png";
    if (row %2 == 0) {
        cell.timeText = @"3433";
    } else {
      cell.sureText = @"4444";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSUInteger row = [indexPath row];
   }


@end
