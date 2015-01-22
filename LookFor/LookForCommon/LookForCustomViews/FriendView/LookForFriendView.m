//
//  LookForFriendView.m
//  LookFor
//
//  Created by clei on 15/1/22.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForFriendView.h"
#import "LookFor_FriendList.h"

#define FRIENDS_VIEW_HEIGHT     100.0
#define FRIENDS_VIEW_SPACE_XY   15.0
#define FRIEND_VIEW_ITEM_WIDTH  55.0
#define FRIEND_VIEW_LABEL_WIDTH 20.0

@interface LookForFriendView()
{
    float scale;
    UIImageView *friendItemsView;
}
@end

@implementation LookForFriendView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame addToView:(UIView *)view
{
    self = [super initWithFrame:frame];
    if (self)
    {
        scale = CURRENT_SCALE;
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.0;
        [view addSubview:self];
        [self initView];
        
    }
    return self;
}

#pragma mark UI
- (void)initView
{
    [self addBgButton];
    [self addFriendView];
}


- (void)addBgButton
{
    UIButton *bgButton = [CreateViewTool createButtonWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) buttonImage:@"" selectorName:@"dismiss" tagDelegate:self];
    bgButton.backgroundColor = [UIColor clearColor];
    [self addSubview:bgButton];
}

- (void)addFriendView
{
    friendItemsView = [CreateViewTool createImageViewWithFrame:CGRectMake(0, - (NAV_HEIGHT + FRIENDS_VIEW_HEIGHT) , SCREEN_WIDTH, NAV_HEIGHT + FRIENDS_VIEW_HEIGHT) placeholderImage:nil];
    friendItemsView.backgroundColor = LAYER_BG_COLOR;
    [CreateViewTool setViewShadow:friendItemsView withShadowColor:LAYER_SHADOW_COLOR shadowOffset:CGSizeMake(0, SHADOW_HEIGHT) shadowOpacity:SHADOW_OPACITY];
    [self addSubview:friendItemsView];
}


#pragma mark 设置数据
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self addFriendItemView];
}


- (void)addFriendItemView
{
    int count = [self.dataArray count];
    for (UIView *view in friendItemsView.subviews)
    {
        if ([view isKindOfClass:[UIScrollView class]])
        {
            [view removeFromSuperview];
        }
    }
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, FRIENDS_VIEW_HEIGHT)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(FRIENDS_VIEW_SPACE_XY * (count + 1) + FRIEND_VIEW_ITEM_WIDTH * count,scrollView.frame.size.height);
    [friendItemsView addSubview:scrollView];
    for (int i = 0; i < count; i ++)
    {
        id friendObj = self.dataArray[i];
        if (![friendObj isKindOfClass:[LookFor_Friend class]])
        {
            return;
        }
        LookFor_Friend *friendInfo = (LookFor_Friend *)friendObj;
        UIImage *image = [UIImage imageNamed:@"1.jpg"];
        UIImageView *friendItemView = [CreateViewTool createRoundImageViewWithFrame:CGRectMake(FRIENDS_VIEW_SPACE_XY + i * (FRIENDS_VIEW_SPACE_XY + FRIEND_VIEW_ITEM_WIDTH), FRIENDS_VIEW_SPACE_XY, FRIEND_VIEW_ITEM_WIDTH, FRIEND_VIEW_ITEM_WIDTH) placeholderImage:image borderColor:nil imageUrl:friendInfo.portrait];
        [friendItemView setImageWithURL:[NSURL URLWithString:friendInfo.portrait] placeholderImage:image];
        friendItemView.tag = i;
        [scrollView addSubview:friendItemView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [friendItemView addGestureRecognizer:tapGesture];
        
        NSString *userName = friendInfo.commentName;
        userName = (!userName || [@"" isEqualToString:userName]) ? friendInfo.nickName : userName;
        UILabel * nameLabel = [CreateViewTool createLabelWithFrame:CGRectMake(friendItemView.frame.origin.x, scrollView.frame.size.height - FRIEND_VIEW_LABEL_WIDTH - 3.0, friendItemView.frame.size.width, FRIEND_VIEW_LABEL_WIDTH) textString:userName textColor:[UIColor blackColor] textFont:FONT(12.0)];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [scrollView addSubview:nameLabel];
    }
}

#pragma mark 相关操作
- (void)handleTap:(UITapGestureRecognizer *)tapGesture
{
    int index = tapGesture.view.tag;
    NSLog(@"====%d",index);
    if (self.delegate && [self.delegate respondsToSelector:@selector(friendViewClickedItemIndex:)])
    {
        [self.delegate friendViewClickedItemIndex:index];
    }
    [self dismiss];
}


- (void)show
{
    [self isShowFriendView:YES];
}

- (void)dismiss
{
    [self isShowFriendView:NO];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(friendViewDismissed)])
    {
        [self.delegate friendViewDismissed];
    }
}


- (void)isShowFriendView:(BOOL)isShow
{
    float move_y = 0.0;
    move_y = (isShow) ? friendItemsView.frame.size.height : - friendItemsView.frame.size.height;
    
    float alpha = 1.0;
    alpha = (isShow) ? alpha : 0.0;
    
    [UIView animateWithDuration:.5 animations:^
     {
         friendItemsView.transform = CGAffineTransformMakeTranslation(0, move_y);
         self.alpha = alpha;
     }];
}


- (void)dealloc
{
    self.delegate = nil;
}

@end
