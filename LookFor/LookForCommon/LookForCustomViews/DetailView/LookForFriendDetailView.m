//
//  LookForFriendDetailView.m
//  LookFor
//
//  Created by clei on 15/1/20.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForFriendDetailView.h"

#define LABEL_SPACE_X          35.0
#define LABEL_ADDSPACE_Y       2.0
#define LOCTION_ICON_SPACE_X   DETAIL_VIEW_SPACE_XY
#define TITLELABEL_WIDTH       240.0
#define LABEL_HEIGHT           20.0
#define TEXT_COLOR             RGB(64.0,64.0,65.0)

@implementation LookForFriendDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)initView
{
    [super initView];
    [self addTopView];
}

- (void)addTopView
{
    //title
    UILabel *titleLabel = [CreateViewTool createLabelWithFrame:CGRectMake(LABEL_SPACE_X * scale, DETAIL_VIEW_SPACE_XY * scale, TITLELABEL_WIDTH * scale, LABEL_HEIGHT * scale) textString:@"你妹" textColor:TEXT_COLOR textFont:FONT(16.0)];
    [detailView addSubview:titleLabel];
    
    //地址
    UIImage *image = [UIImage imageNamed:@"ures_ico_place.png"];
    float start_y = titleLabel.frame.origin.y + titleLabel.frame.size.height + LABEL_ADDSPACE_Y * scale;
    float location_y = start_y + (titleLabel.frame.size.height - image.size.width/2 * scale)/2;
    
    UIImageView *locationIcon = [CreateViewTool createImageViewWithFrame:CGRectMake(LOCTION_ICON_SPACE_X * scale,location_y , image.size.width/2 * scale, image.size.height/2 * scale) placeholderImage:image];
    [detailView addSubview:locationIcon];
    
    UILabel *localLabel = [CreateViewTool createLabelWithFrame:CGRectMake(titleLabel.frame.origin.x, start_y, titleLabel.frame.size.width, titleLabel.frame.size.height) textString:@"广东省深圳市南山区 高新南七道" textColor:TEXT_COLOR textFont:FONT(11.0)];
    [detailView addSubview:localLabel];
    
    //去他那
    UIImage *goThereImage = [UIImage imageNamed:@"ures_here_up.png"];
    float goThereButton_w = goThereImage.size.width/2 * scale;
    float goThereButton_h = goThereImage.size.height/2 * scale;
    float goThereButton_x = detailView.frame.size.width - DETAIL_VIEW_SPACE_XY * scale - goThereButton_w;
    float goThereButton_y = start_y + LABEL_ADDSPACE_Y * scale;
    UIButton *goThereButton = [CreateViewTool createButtonWithFrame:CGRectMake(goThereButton_x, goThereButton_y, goThereButton_w, goThereButton_h) buttonImage:@"ures_here" selectorName:@"goThereButtonPressed:" tagDelegate:self];
    [detailView addSubview:goThereButton];
    
    //距离/最后时间
    start_y += localLabel.frame.size.height + + LABEL_ADDSPACE_Y * scale;
    UILabel *detailLabel = [CreateViewTool createLabelWithFrame:CGRectMake(localLabel.frame.origin.x, start_y, localLabel.frame.size.width, localLabel.frame.size.height) textString:@"距离您888km,上次更新时间:2015-01-20 17:44" textColor:TEXT_COLOR textFont:FONT(11.0)];
    [detailView addSubview:detailLabel];
    
}


- (void)goThereButtonPressed:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(friendDetailView:clickedGoThereWithIndex:)])
    {
        [self.delegate friendDetailView:self clickedGoThereWithIndex:self.index];
    }
}


@end
