//
//  LookForBaseDetailView.h
//  LookFor
//
//  Created by clei on 15/1/20.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DETAIL_VIEW_DEFAULT_HEIGHT     100.0
#define DETAIL_VIEW_SPACE_XY           10.0

@interface LookForBaseDetailView : UIView
{
    UIImageView *detailView;
    UIButton *arrowButton;
    float detailViewHeight;
    float scale;
}
@property (nonatomic, strong) id detailInfo;


/*
 *  初始化视图
 *
 *  @pram frame frame
 *  @pram view  父视图
 */
- (instancetype)initWithFrame:(CGRect)frame addToView:(UIView *)view;

/*
 *  初始化UI
 */
- (void)initView;

/*
 *  显示
 */
- (void)show;

/*
 *  隐藏
 */
- (void)dismiss;

/*
 * 添加详细视图
 */
- (void)addDetailView;

/*
 * 添加关闭按钮
 */
- (void)addCloseButton;

@end
