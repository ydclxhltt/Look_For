//
//  LookForSelectFriendViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-1-13.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "LookForSelectFriendViewController.h"
#import "LookForSelectFriendTableViewCell.h"

@interface LookForSelectFriendViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *selectTableView;
@property (nonatomic, strong) NSMutableArray *selectIndex;
@property (nonatomic, strong) NSString *title;
@end

@implementation LookForSelectFriendViewController

- (id)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    [self initView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectIndex = [[NSMutableArray alloc] init];
    self.title = self.title;
    [self setNavBarItemWithTitle:@"取消"
                     navItemType:LeftItem
                    selectorName:@"handleCancel"];
    
    [self setNavBarItemWithTitle:@"确定"
                     navItemType:rightItem
                    selectorName:@"handleSure"];
    self.navigationController.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -custom
- (void)reloadRightButton {
    if ([self.selectIndex count]) {
        self.navigationController.navigationItem.rightBarButtonItem.enabled = YES;
    } else {
        self.navigationController.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

- (void)initView {
    self.selectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,MAIN_SCREEN_SIZE.width,MAIN_SCREEN_SIZE.height)
                                                        style:UITableViewStylePlain];
    
    self.selectTableView.dataSource = self;
    self.selectTableView.delegate = self;
    self.selectTableView.backgroundColor = [UIColor clearColor];
    self.selectTableView.separatorColor = [UIColor lightGrayColor];// UIColorFromRGB(0xcccccc);
    self.selectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.selectTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.selectTableView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:self.selectTableView];
}

#pragma mark -handle
- (void)handleCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleSure {
    
}

#pragma -message
#pragma mark - TableView Datasource And Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *displayCellIdentifier = @"LookForSelectFriendTableViewCell";
    
    NSUInteger row = [indexPath row];
    LookForSelectFriendTableViewCell *cell = (LookForSelectFriendTableViewCell *) [tableView dequeueReusableCellWithIdentifier:displayCellIdentifier];
    if (cell == nil) {
        cell = (LookForSelectFriendTableViewCell *)[[LookForSelectFriendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: displayCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    if ([self.selectIndex containsObject:[NSNumber numberWithInteger:row]]) {
        cell.friendSelected = YES;
    } else {
        cell.friendSelected = NO;
    }
    
    cell.nameText = @"1111";
    [cell setHeadImage:@"1.jpg"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([self.selectIndex containsObject:[NSNumber numberWithInteger:row]]) {
        [self.selectIndex removeObject:[NSNumber numberWithInteger:row]];
    } else {
        [self.selectIndex addObject:[NSNumber numberWithInteger:row]];
    }
    
    [self.selectTableView reloadData];
    [self reloadRightButton];
}


@end
