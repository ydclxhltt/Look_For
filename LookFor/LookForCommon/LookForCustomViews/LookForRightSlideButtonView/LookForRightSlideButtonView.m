//
//  LookForRightSlideButtonView.m
//  IphoneMapSdkDemo
//
//  Created by chenmingguo on 15-1-6.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import "LookForRightSlideButtonView.h"

#define DefaultSpace        3
#define ButtonSpace         5

@interface LookForRightSlideButtonView ()
{
    float buttonWidth;
}
@property (nonatomic, strong) UIView    *parentView;                //父view
@property (nonatomic, strong) NSArray   *imageArray;                //button图片
@property (nonatomic, strong) NSArray   *titleArray;                //button标题
@property (nonatomic, strong) NSString  *startImage;                //
@property (nonatomic, strong) NSMutableArray *buttonArray;          //button数组
@property (nonatomic, strong) NSMutableArray *buttonXArray;         //每个button的x位置
@property (nonatomic, assign) BOOL      isAnimating;                //动画是否在进行中

@property (nonatomic, assign) CGRect    startFrame;                 //起始frame
@property (nonatomic, assign) BOOL      buttonsShow;                //button是否弹出

@end


@implementation LookForRightSlideButtonView

- (id)initViewWithFrame:(CGRect)frame withInView:(UIView*)inView withStartImage:(NSString *)startImage withImageArray:(NSArray *)imageArray withTitleArray:(NSArray *)titleArray delegate:(id)myDelegate
{
    self = [super initWithFrame:frame];

    if (self) {
        self.frame = frame;
        self.startFrame = frame;
        self.parentView = inView;
        self.imageArray = imageArray;
        self.titleArray = titleArray;
        self.startImage = startImage;
        self.buttonsShow = NO;
        self.isAnimating = NO;
        self.buttonArray = [[NSMutableArray alloc] init];
        self.buttonXArray = [[NSMutableArray alloc] init];
        self.delegate = myDelegate;
        [self initView];
    }
    return self;
}

- (void)initView {
    [self.parentView addSubview:self];
    [self.parentView bringSubviewToFront:self];
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    
    //创建menuButton
    UIImage *startImage_Up = [UIImage imageNamed:[self.startImage stringByAppendingString:@"_up.png"]];
    UIImage *startImage_Down = [UIImage imageNamed:[self.startImage stringByAppendingString:@"_down.png"]];
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame = self.bounds;
    [menuButton setBackgroundImage:startImage_Up forState:UIControlStateNormal];
    [menuButton setBackgroundImage:startImage_Down forState:UIControlStateHighlighted];
    [menuButton addTarget:self action:@selector(handleStartClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:menuButton];
    
    //创建弹出的按钮
    for (NSInteger index = 0; index < [self.imageArray count]; index++)
    {
        NSString *titleStr = @"";
        //if (index < [self.titleArray count])
        //    titleStr = [self.titleArray objectAtIndex:index];
        UIView *button = [self shareButtonWithIcon:[self.imageArray objectAtIndex:index] withTitle:titleStr withTag:index];
        [self addSubview:button];
        [self.buttonArray addObject:button];
    }
    
    if(self.buttonArray.count == 0) return;
    
    for (int i = 0; i < self.buttonArray.count; ++i)
    {
        UIView *bubble = [self.buttonArray objectAtIndex:i];
        
        float x = self.startFrame.size.width + i*buttonWidth + (i + 1)*ButtonSpace;
        
        [self.buttonXArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:x], @"x", nil]];
        bubble.center = self.center;
        bubble.tag = i;
    }
    

}

#pragma mark -handle
- (void)handleClick:(id)sender {
    if([self.delegate respondsToSelector:@selector(selectButton:buttonTag:)]) {
        UIButton *button = (UIButton *)sender;
        [self.delegate selectButton:self buttonTag:button.tag];
    }
}

- (void)handleStartClick:(UIButton *)sender
{
    if (!self.isAnimating && !self.buttonsShow)
    {
        [self showButton];
        self.buttonsShow = YES;
    }
    else if (!self.isAnimating && self.buttonsShow)
    {
        [self hiddenButton];
        self.buttonsShow = NO;
    }
    else
    {
        return;
    }
    
    float angle = (self.buttonsShow) ? M_PI/4 : 0.0;
    
    [UIView animateWithDuration:.3 animations:^
    {
        sender.transform = CGAffineTransformMakeRotation(angle);
    }
    completion:^(BOOL finish)
    {
        if (self.buttonsShow)
            [self showButton];
        else
            [self hiddenButton];
    }];
}


#pragma -mark custom
- (void)showButton {
    if (!self.isAnimating) {
        
        self.isAnimating = YES;
        self.frame = CGRectMake(self.startFrame.origin.x, self.startFrame.origin.y, self.startFrame.size.width + self.buttonArray.count * buttonWidth + (self.buttonArray.count + 1)*ButtonSpace, self.startFrame.size.height);
        int inetratorI = 0;
        for (NSDictionary *coordinate in self.buttonXArray)
        {
            UIButton *bubble = [self.buttonArray objectAtIndex:inetratorI];
            bubble.center = CGPointMake(self.startFrame.size.width/2,self.startFrame.size.height/2);
            float delayTime = inetratorI * 0.1;
            [self performSelector:@selector(showBubbleWithAnimation:) withObject:[NSDictionary dictionaryWithObjectsAndKeys:bubble, @"button", coordinate, @"coordinate", nil] afterDelay:delayTime];
            ++inetratorI;
        }
    }
    
}

-(void)showBubbleWithAnimation:(NSDictionary *)info
{
    UIButton *bubble = (UIButton *)[info objectForKey:@"button"];
    NSDictionary *coordinate = (NSDictionary *)[info objectForKey:@"coordinate"];
    
    [UIView animateWithDuration:0.25 animations:^{
        float x = [[coordinate objectForKey:@"x"] floatValue];
        bubble.frame = CGRectMake(x, (self.startFrame.size.height - bubble.frame.size.height) / 2, bubble.frame.size.width, bubble.frame.size.height);
        bubble.alpha = 1;
        //NSLog(@"====%@",nsstring);
    } completion:^(BOOL finished) {
        if(bubble.tag == self.buttonArray.count - 1) {
            self.isAnimating = NO;
        }
    }];
}



- (void)hiddenButton {
    if(!self.isAnimating)
    {
        self.isAnimating = YES;
        int inetratorI = 0;
        for (UIButton *bubble in self.buttonArray)
        {
            float delayTime = inetratorI * 0.1;
            [self performSelector:@selector(hideBubbleWithAnimation:) withObject:bubble afterDelay:delayTime];
            ++inetratorI;
        }
    }
}

-(void)hideBubbleWithAnimation:(UIButton *)bubble
{
    [UIView animateWithDuration:0.25 animations:^{
        bubble.center = CGPointMake(self.startFrame.size.width / 2,self.startFrame.size.height / 2);
        bubble.alpha = 0;
    } completion:^(BOOL finished) {
        if(bubble.tag == self.buttonArray.count - 1) {
            self.isAnimating = NO;
            self.frame = self.startFrame;
        }
    }];
}




//创建button
-(UIButton *)shareButtonWithIcon:(NSString *)iconName withTitle:(NSString *)title withTag:(NSInteger)tag
{
    // Circle background
    UIImage *image_Up = [UIImage imageNamed:[iconName stringByAppendingString:@"_up.png"]];
    UIImage *image_Down = [UIImage imageNamed:[iconName stringByAppendingString:@"_down.png"]];
    float width = image_Up.size.width/2 * CURRENT_SCALE;
    float height = image_Up.size.height/2 * CURRENT_SCALE;
    buttonWidth = width;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((self.bounds.size.width - width)/2, (self.bounds.size.height - height)/2, width,height);
    [button setBackgroundImage:image_Up forState:UIControlStateNormal];
    [button setBackgroundImage:image_Down forState:UIControlStateHighlighted];
    [CommonTool clipView:button withCornerRadius:button.frame.size.width/2];
    button.backgroundColor = [UIColor clearColor];
    button.tag = tag;
    [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
    

    return button;
}


@end
