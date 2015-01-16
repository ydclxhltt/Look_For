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
    UIButton *menuButton;
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
        [self initView];
    }
    return self;
}

//设置是否为选中
//- (void)setIsSelect:(BOOL)isSelect
//{
//    _isSelect = isSelect;
//    menuButton.selected = isSelect;
//    [self resetView];
//}

//初始化UI
- (void)initView
{
    float titleLabel_y = (- TitleLabelHeith - TITLELABEL_SPACE_Y) * scale;
    
    //昵称
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel_y, self.frame.size.width, TitleLabelHeith * scale)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.backgroundColor = [APP_MAIN_COLOR colorWithAlphaComponent:.6];
    [CommonTool clipView: self.titleLabel withCornerRadius:2.0];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = FONT(10.0);
    [self addSubview:self.titleLabel];
    
    //头像
    float iconImageView_XY = ICON_IMAGEVIEW_SPACE * scale;
    float iconImageViewWidth = self.frame.size.width - iconImageView_XY * 2;
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(iconImageView_XY,iconImageView_XY, iconImageViewWidth, iconImageViewWidth)];
    [CommonTool clipView:self.iconImageView withCornerRadius:iconImageViewWidth/2];
    self.iconImageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.iconImageView];
    
    //点击按钮
    menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.backgroundColor = [UIColor clearColor];
    menuButton.frame = self.bounds;
    menuButton.selected = self.selected;
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
    if ([self.delegate respondsToSelector:@selector(selectAnnotation:)])
    {
        [self.delegate selectAnnotation:self];
    }
    sender.selected = !sender.selected;
    self.isSelect = sender.selected;
    [self resetView];
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
    //viewScale = (self.isSelect) ? self.selecteImage.size.width/self.normalImage.size.width : viewScale;
    viewScale = (self.isSelect) ? 1.2 : viewScale;
    [UIView animateWithDuration:.3 animations:^
    {
        self.image = image;
        self.transform = CGAffineTransformMakeScale(viewScale, viewScale);
        self.titleLabel.hidden = self.isSelect;
    } completion:^(BOOL finish){}];
    
    [self addBubblesView];
    if (self.isSelect)
        [self.shareBubbles show];
    else
        [self.shareBubbles hide];
}


- (void)setAnnotationDataWithImageUrl:(NSString *)imageUrl placeholderImage:(NSString *)placeImage  nikeName:(NSString *)name
{
    imageUrl = (imageUrl) ? imageUrl : @"";
    name = (name) ? name : @"";
    placeImage = (placeImage) ? placeImage : @"";
    [self.iconImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:placeImage]];
    self.titleLabel.text = name;
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
    [self handleSelect:menuButton];
    self.shareBubbles = nil;
}

@end
