//
//  LookForBaseDetailView.m
//  LookFor
//
//  Created by clei on 15/1/20.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForBaseDetailView.h"



@interface LookForBaseDetailView()
{
    UIButton *arrowButton;
}
@end

@implementation LookForBaseDetailView

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


#pragma mark 初始化UI
- (void)initView
{
    [self addBgView];
    [self addDetailView];
    [self addButtons];
}

- (void)addBgView
{
    UIButton *bgButton = [CreateViewTool createButtonWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) buttonImage:@"" selectorName:@"dismiss" tagDelegate:self];
    bgButton.backgroundColor = [UIColor clearColor];
    [self addSubview:bgButton];
}

- (void)addDetailView
{
    detailView = [CreateViewTool createImageViewWithFrame:CGRectMake(0, self.frame.size.height, SCREEN_WIDTH, DETAIL_VIEW_DEFAULT_HEIGHT * scale) placeholderImage:nil];
    detailView.userInteractionEnabled = YES;
    detailView.backgroundColor = LAYER_BG_COLOR;
    [CreateViewTool setViewShadow:detailView withShadowColor:LAYER_SHADOW_COLOR shadowOffset:CGSizeMake(0, -SHADOW_HEIGHT) shadowOpacity:SHADOW_OPACITY];
    [self addSubview:detailView];
}


- (void)addButtons
{
    UIImage *closeImage = [UIImage imageNamed:@"ures_close_up.png"];
    float close_Width = closeImage.size.width/2 * scale;
    float close_Height = closeImage.size.height/2 * scale;
    UIButton *closeButton = [CreateViewTool createButtonWithFrame:CGRectMake(detailView.frame.size.width - DETAIL_VIEW_SPACE_XY * scale - close_Width, DETAIL_VIEW_SPACE_XY  * scale, close_Width, close_Height) buttonImage:@"ures_close" selectorName:@"dismiss" tagDelegate:self];
    [detailView addSubview:closeButton];
    
    UIImage *arrowImage = [UIImage imageNamed:@"ures_arrow_up.png"];
    float arrow_Width = arrowImage.size.width/2 * scale;
    float arrow_Height = arrowImage.size.height/2 * scale;
    float space_x = (detailView.frame.size.width - arrow_Width)/2;
    float space_y = detailView.frame.size.height - arrow_Width;
    arrowButton = [CreateViewTool createButtonWithFrame:CGRectMake(space_x, space_y, arrow_Width, arrow_Height) buttonImage:@"ures_arrow" selectorName:@"arrowButtonPressed:" tagDelegate:self];
    arrowButton.selected = NO;
    [detailView addSubview:arrowButton];
}


#pragma mark  点击箭头
- (void)arrowButtonPressed:(UIButton *)sender
{
    sender.selected = !sender.selected;
    float height = (sender.selected) ? - detailView.frame.size.height : - DETAIL_VIEW_DEFAULT_HEIGHT * scale;
    float space_y = (sender.selected) ?  detailView.frame.size.height - sender.frame.size.height : DETAIL_VIEW_DEFAULT_HEIGHT * scale - sender.frame.size.height;
    float angle = (sender.selected) ? M_PI : 0;
    [UIView animateWithDuration:.5 animations:^
    {
        detailView.transform = CGAffineTransformMakeTranslation(0, height);
        CGRect frame = sender.frame;
        frame.origin.y = space_y;
        sender.frame = frame;
        sender.transform = CGAffineTransformMakeRotation(angle);
    }];
}


#pragma mark 显示
- (void)show
{
    [self moveViewWithHeight: - DETAIL_VIEW_DEFAULT_HEIGHT * scale viewAlpha:1.0];
}


#pragma mark 消失
- (void)dismiss
{
    float height = (arrowButton.selected) ?  detailView.frame.size.height :  DETAIL_VIEW_DEFAULT_HEIGHT * scale;
    [self moveViewWithHeight:height viewAlpha:.0];
    arrowButton.selected = NO;
}

#pragma mark 视图动画
- (void)moveViewWithHeight:(float)height viewAlpha:(float)alpha
{
    [UIView animateWithDuration:.5 animations:^
    {
        detailView.transform = CGAffineTransformMakeTranslation(0, height);
        self.alpha = alpha;
    }];
}
@end
