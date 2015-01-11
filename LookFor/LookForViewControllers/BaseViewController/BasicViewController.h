//
//  BasicViewController.h
//  SmallPig
//
//  Created by clei on 14/11/5.
//  Copyright (c) 2014年 chenlei. All rights reserved.
//

typedef enum : NSUInteger
{
    LeftItem,
    rightItem,
    backItem,
} NavItemType;

typedef enum : NSUInteger
{
    PushTypeRegister = 0 << 0,
    PushTypeFindPassWord = 1 << 1,
} PushType;


#import <UIKit/UIKit.h>
#import "CreateViewTool.h"
#import "LookForAppDelegate.h"
//#import "AppDelegate.h"
//#import "XSH_Application.h"
//#import "RequestTool.h"
//#import "SVProgressHUD.h"

@interface BasicViewController : UIViewController
{
    //y起始坐标
    float startHeight;
}
@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) UITableView *table;

/*
 *  设置导航条Item
 *
 *  @pram title     按钮title
 *  @pram type      NavItemType 设置左或右item的标识
 *  @pram selName   item按钮响应方法名
 */
- (void)setNavBarItemWithTitle:(NSString *)title navItemType:(NavItemType)type selectorName:(NSString *)selName;

/*
 *  设置导航条Item
 *
 *  @pram imageName 图片名字
 *  @pram type      NavItemType 设置左或右item的标识
 *  @pram selName   item按钮响应方法名
 */
- (void)setNavBarItemWithImageName:(NSString *)imageName navItemType:(NavItemType)type selectorName:(NSString *)selName;

/*
 *  设置导航条Item back按钮
 */
- (void)addBackItem;


/*
 *  添加表视图，如：tableView
 *
 *  @pram frame     tableView的frame
 *  @pram type      UITableViewStyle
 *  @pram delegate  tableView的委托
 *
 */
- (void)addTableViewWithFrame:(CGRect)frame tableType:(UITableViewStyle)type tableDelegate:(id)delegate;


@end
