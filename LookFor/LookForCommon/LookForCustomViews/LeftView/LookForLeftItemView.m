//
//  LookForLeftItemView.m
//  LookFor
//
//  Created by clei on 15/1/23.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForLeftItemView.h"


@interface LookForLeftItemView()
{
    UIImageView *iconImageView;
    UILabel *textLabel;
    float scale;
}
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *selectImage;
@end

@implementation LookForLeftItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        scale = CURRENT_SCALE;
        [self initView];
    }
    return self;
}


- (void)initView
{
    [self addIconImageView];
    [self addTextLable];
}


- (void)addIconImageView
{
    float space_x = SPACE_X * scale;
    float space_y = (self.frame.size.height - ICON_HEIGHT * scale)/2;
    iconImageView = [CreateViewTool createImageViewWithFrame:CGRectMake(space_x, space_y, ICON_HEIGHT * space_x, ICON_WIDTH * space_x) placeholderImage:self.normalImage];
    [self addSubview:iconImageView];
}

- (void)addTextLable
{
    float space_x = iconImageView.frame.size.width + iconImageView.frame.origin.x + SPACE_X * scale;
    float labelHeight = 20.0 * scale;
    float space_y = (self.frame.size.height - labelHeight)/2;
    float labelWidth = self.frame.size.width - space_x - SPACE_X * scale;
    textLabel = [CreateViewTool createLabelWithFrame:CGRectMake(space_x , space_y, labelWidth, space_y) textString:@"1111" textColor:NORMAL_COLOR textFont:FONT(16.0)];
    [self addSubview:textLabel];
}


- (void)setImageWithImageName:(NSString *)imageName labelText:(NSString *)text
{
    [self setImageWithImageName:imageName];
    
    float icon_height = self.normalImage.size.height/2 * scale;
    float icon_width = self.normalImage.size.width/2 * scale;
    float space_y = (self.frame.size.height - icon_height)/2;
    iconImageView.frame = CGRectMake(iconImageView.frame.origin.x, space_y, icon_width, icon_height);
    iconImageView.frame = CGRectMake(iconImageView.frame.origin.x, space_y, icon_width, icon_height);
    iconImageView.image = self.normalImage;
    
    CGRect frame = textLabel.frame;
    frame.origin.x = iconImageView.frame.size.width + iconImageView.frame.origin.x + SPACE_X * scale;
    frame.size.width = self.frame.size.width - frame.origin.x - SPACE_X * scale;
    textLabel.frame = frame;
    textLabel.text = text;
}

- (void)setImageWithImageName:(NSString *)imageName
{
    self.normalImage = [UIImage imageNamed:[imageName stringByAppendingString:@"_up.png"]];
    self.selectImage = [UIImage imageNamed:[imageName stringByAppendingString:@"_down.png"]];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    iconImageView.image = self.selectImage;
    textLabel.textColor = SELECT_COLOR;
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    iconImageView.image = self.normalImage;
    textLabel.textColor = NORMAL_COLOR;
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    iconImageView.image = self.normalImage;
    textLabel.textColor = NORMAL_COLOR;
    [super touchesCancelled:touches withEvent:event];
}



@end
