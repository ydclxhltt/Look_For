//
//  LookForAnnotationView.m
//  IphoneMapSdkDemo
//
//  Created by chenmingguo on 15-1-5.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import "LookForAnnotationView.h"

#define TitleLabelHeith         15.0
#define TITLELABEL_SPACE_Y      3.0
#define ICON_IMAGEVIEW_SPACE    4.0
#define BOUBLE_SPACE            5.0
#define ImageWH                 30
#define SELFWH                  120
#define SELFMINWH               60

@interface LookForAnnotationView ()
{
    float scale;
}
@property (nonatomic, strong) AAShareBubbles *shareBubbles;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;  //标题
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *selecteImage;
@end


@implementation LookForAnnotationView

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier defaultImage:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    scale = CURRENT_SCALE;
    
    if (self)
    {
        float selfWidth = SELFMINWH;
        float selfHeight = SELFMINWH;
        if (image)
        {
            self.normalImage = image;
            selfWidth = image.size.width/2;
            selfHeight = image.size.height/2;
            self.image = image;
        }
        self.selecteImage = selectedImage;
        self.bounds = CGRectMake(0, 0, selfWidth * scale, selfHeight * scale);
        self.clipsToBounds = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetState) name:@"OneAnnonationSelected" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showFriendItem) name:@"ShowFriendInfoView" object:nil];
        [self initView];
    }
    return self;
}


//设置是否为选中
- (void)setIsSelect:(BOOL)isSelect
{
    _isSelect = isSelect;
    [self resetView];
}

//初始化UI
- (void)initView
{
    float titleLabel_y = (- TitleLabelHeith - TITLELABEL_SPACE_Y) * scale;
    
    //昵称
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel_y, self.frame.size.width, TitleLabelHeith * scale)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.backgroundColor = [APP_MAIN_COLOR colorWithAlphaComponent:.6];
    [CreateViewTool clipView: self.titleLabel withCornerRadius:2.0];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = FONT(10.0);
    [self addSubview:self.titleLabel];
    
    //头像
    float iconImageView_XY = ICON_IMAGEVIEW_SPACE * scale;
    float iconImageViewWidth = self.frame.size.width - iconImageView_XY * 2;
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(iconImageView_XY,iconImageView_XY, iconImageViewWidth, iconImageViewWidth)];
    [CreateViewTool clipView:self.iconImageView withCornerRadius:iconImageViewWidth/2];
    self.iconImageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.iconImageView];
    
    //点击按钮
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.backgroundColor = [UIColor clearColor];
    menuButton.frame = self.bounds;
    [self addSubview:menuButton];
    [menuButton addTarget:self action:@selector(handleSelect:) forControlEvents:UIControlEventTouchDown];
}


- (void)addBubblesView
{
    if (!self.shareBubbles)
    {
        NSMutableArray *imageArray = [[NSMutableArray alloc] init];
        [imageArray addObject:@"see"];
        [imageArray addObject:@"quanta"];
        [imageArray addObject:@"gothere"];
        UIImage *image = [UIImage imageNamed:@"see_up.png"];
        float radius = self.frame.size.width/2 + BOUBLE_SPACE * scale + image.size.width/2/2 * scale;
        self.shareBubbles = [[AAShareBubbles alloc] initWithPoint:self.iconImageView.center radius:radius inView:self withImageArray:imageArray withTitleArray:nil];
        self.shareBubbles.delegate = self;
        self.shareBubbles.bubbleRadius = 15;
    }
}

- (void)handleSelect:(UIButton *)sender
{
    self.isSelect = !self.isSelect;
    if ([self.delegate respondsToSelector:@selector(selectAnnotation:)] && self.isSelect)
    {
        [self.delegate selectAnnotation:self];
    }
    NSLog(@"self.isSelect===%d",self.isSelect);
}


#pragma mark 设置视图frame
- (void)resetView
{
    if (!self.selecteImage || !self.normalImage)
    {
        return;
    }
    UIImage *image = (self.isSelect) ? self.selecteImage : self.normalImage;
    float viewScale = 1.0;
    /* 放大坐标会移动，暂时屏蔽放大，地图比例尺跟着变不知可否解决此问题*/
    //viewScale = (self.isSelect) ? self.selecteImage.size.width/self.normalImage.size.width : viewScale;
    //viewScale = (self.isSelect) ? 1.1 : viewScale;
    [UIView animateWithDuration:.3 animations:^
    {
        self.image = image;
        self.titleLabel.hidden = self.isSelect;
        self.transform = CGAffineTransformMakeScale(viewScale, viewScale);
    } completion:^(BOOL finish){}];
    
    if (self.isSelect)
    {
        [self addBubblesView];
        [self.shareBubbles show];
    }
    else
    {
        [self.shareBubbles hide];
        self.shareBubbles = nil;
    }
}


- (void)setAnnotationDataWithImageUrl:(NSString *)imageUrl placeholderImage:(NSString *)placeImage  nikeName:(NSString *)name
{
    imageUrl = (imageUrl) ? imageUrl : @"";
    name = (name) ? name : @"";
    placeImage = (placeImage) ? placeImage : @"";
    [self.iconImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:placeImage]];
    self.titleLabel.text = name;
}


#pragma mark 刷新选中状态
- (void)resetState
{
    int selectedIndex = [LookFor_Application shareInstance].selectedAnnonationIndex;
    NSLog(@"self.tag===%d",self.tag);
    if (selectedIndex != self.tag)
    {
        [self setIsSelect:NO];
    }
}


#pragma mark 首页点击好友列表
- (void)showFriendItem
{
    int selectedIndex = [LookFor_Application shareInstance].selectedAnnonationIndex;
    if (self.tag == selectedIndex)
    {
        [self handleSelect:nil];
    }
}


#pragma mark AAShareBubbles

- (void)shareBubbles:(AAShareBubbles *)shareBubbles buttonTag:(NSInteger)tag
{
    switch (tag) {
        case 0:
            NSLog(@"Facebook");
            break;
        case 1:
            NSLog(@"Twitter");
            break;
        case 2:
            NSLog(@"Email");
            break;
        case 3:
            NSLog(@"Google+");
            break;
        case 4:
            NSLog(@"Tumblr");
            break;
            
        default:
            break;
    }
}

- (void)hiddenShareBubbles:(AAShareBubbles *)shareBubble
{
    [self handleSelect:nil];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
