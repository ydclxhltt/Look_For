//
//  LookForRightSlideButtonView.m
//  IphoneMapSdkDemo
//
//  Created by chenmingguo on 15-1-6.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import "LookForRightSlideButtonView.h"

#define ButtonWH            35
#define CircleImageWH       16
#define DefaultSpace        3
#define TitleLabelHeith     12
#define ButtonSpace         5

@interface LookForRightSlideButtonView ()

@property (nonatomic, strong) UIView    *parentView;                //父view
@property (nonatomic, strong) NSArray   *imageArray;                //button图片
@property (nonatomic, strong) NSArray   *titleArray;                //button标题
@property (nonatomic, strong) NSString  *startImage;                //
@property (nonatomic, strong) NSMutableArray *buttonArray;          //button数组
@property (nonatomic, strong) NSMutableArray *buttonX;              //每个button的x位置
@property (nonatomic, assign) BOOL      isAnimating;                //动画是否在进行中

@property (nonatomic, assign) CGRect    startFrame;                 //起始frame
@property (nonatomic, assign) BOOL      buttonsShow;                //button是否弹出

@end


@implementation LookForRightSlideButtonView
@synthesize delegate;

- (id)initViewWithFrame:(CGRect)frame withInView:(UIView*)inView withStartImage:(NSString *)startImage withImageArray:(NSArray *)imageArray withTitleArray:(NSArray *)titleArray {
    self = [super init];
    
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
        self.buttonX = [[NSMutableArray alloc] init];
        [self initView];
    }
    return self;
}

- (void)initView {
    [self.parentView addSubview:self];
    [self.parentView bringSubviewToFront:self];
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    //创建弹出的按钮
    for (NSInteger index = 0; index < [self.titleArray count]; index++) {
        if (index < [self.imageArray count]) {
            UIView *button = [self shareButtonWithIcon:[self.imageArray objectAtIndex:index] withTitle:[self.titleArray objectAtIndex:index] withTag:index];
            [self.buttonArray addObject:button];
            
        }
    }
    
    if(self.buttonArray.count == 0) return;
    
    
    for (int i = 0; i < self.buttonArray.count; ++i)
    {
        UIView *bubble = [self.buttonArray objectAtIndex:i];
        
        float x = self.startFrame.size.width + i*ButtonWH + (i + 1)*ButtonSpace;
        
        [self.buttonX addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:x], @"x", nil]];
        bubble.center = self.center;
        bubble.tag = i;
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = self.bounds;
   
    [button setImage:[UIImage imageNamed:self.startImage] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleStartClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

#pragma mark -handle
- (void)handleClick:(id)sender {
    if([self.delegate respondsToSelector:@selector(selectButton:buttonTag:)]) {
        UIButton *button = (UIButton *)sender;
        [self.delegate selectButton:self buttonTag:button.tag];
    }
}

- (void)handleStartClick:(id)sender {
    if (!self.isAnimating && !self.buttonsShow) {
        [self showButton];
        self.buttonsShow = YES;
    } else if (!self.isAnimating && self.buttonsShow) {
        [self hiddenButton];
        self.buttonsShow = NO;
    } else {
        return;
    }
}


#pragma -mark custom
- (void)showButton {
    if (!self.isAnimating) {
        
        self.isAnimating = YES;
        self.frame = CGRectMake(self.startFrame.origin.x, self.startFrame.origin.y, self.startFrame.size.width + self.buttonArray.count * ButtonWH + (self.buttonArray.count + 1)*ButtonSpace, self.startFrame.size.height);
        int inetratorI = 0;
        for (NSDictionary *coordinate in self.buttonX)
        {
            UIButton *bubble = [self.buttonArray objectAtIndex:inetratorI];
            bubble.center = CGPointMake(self.startFrame.size.width / 2,self.startFrame.size.height / 2);
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
-(UIView *)shareButtonWithIcon:(NSString *)iconName withTitle:(NSString *)title withTag:(NSInteger)tag
{
    // Circle background
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, self.startFrame.size.height / 2, ButtonWH,ButtonWH)];
    circle.backgroundColor = [UIColor whiteColor];
    circle.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    circle.layer.cornerRadius = ButtonWH / 2 ;
    circle.layer.masksToBounds = YES;
    [self addSubview:circle];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, ButtonWH,  ButtonWH);
    button.backgroundColor = [UIColor clearColor];
    button.tag = tag;
    [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // Circle icon
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CircleImageWH, CircleImageWH)];
    icon.backgroundColor = [UIColor clearColor];
    CGRect f = icon.frame;
    f.origin.x = (circle.frame.size.width - f.size.width) / 2;
    f.origin.y = DefaultSpace;
    icon.frame = f;
    icon.image = [UIImage imageNamed:iconName];
    [button addSubview:icon];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, icon.frame.origin.y + icon.frame.size.height , circle.frame.size.width, TitleLabelHeith)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor blackColor];
    label.textAlignment = UITextAlignmentCenter;
    label.text = title;
    [button addSubview:label];
    [circle addSubview:button];
    return circle;
}


@end
