//
//  LookForFriendDetailView.m
//  LookFor
//
//  Created by clei on 15/1/20.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForFriendDetailView.h"
#import "LookFor_FriendDetailList.h"

#define LABEL_SPACE_X          35.0
#define LABEL_ADDSPACE_Y       0.0
#define LOCTION_ICON_SPACE_X   DETAIL_VIEW_SPACE_XY
#define TITLELABEL_WIDTH       240.0
//#define LABEL_HEIGHT         25.0
#define TEXT_COLOR             RGB(64.0,64.0,65.0)

@interface LookForFriendDetailView()
{
    UILabel *titleLabel;
    UILabel *localLabel;
    UILabel *detailLabel;
}

@end


@implementation LookForFriendDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark UI
- (void)initView
{
    [super initView];
    [self addTopView];
    [self addBottomView];
}

- (void)addTopView
{
    
    UIImage *image = [UIImage imageNamed:@"ures_ico_place.png"];
    float labelHeight = image.size.height/2 * scale;

    //title
    titleLabel = [CreateViewTool createLabelWithFrame:CGRectMake(LABEL_SPACE_X * scale, DETAIL_VIEW_SPACE_XY * scale, TITLELABEL_WIDTH * scale, labelHeight * scale) textString:@"你妹" textColor:TEXT_COLOR textFont:FONT(15.0)];
    [detailView addSubview:titleLabel];
    
    //地址
    
    float start_y = titleLabel.frame.origin.y + titleLabel.frame.size.height + LABEL_ADDSPACE_Y * scale;
    float location_y = start_y + (titleLabel.frame.size.height - image.size.width/2 * scale)/2;
    
    UIImageView *locationIcon = [CreateViewTool createImageViewWithFrame:CGRectMake(LOCTION_ICON_SPACE_X * scale,location_y , image.size.width/2 * scale, image.size.height/2 * scale) placeholderImage:image];
    [detailView addSubview:locationIcon];
    
    localLabel = [CreateViewTool createLabelWithFrame:CGRectMake(titleLabel.frame.origin.x, start_y, titleLabel.frame.size.width, titleLabel.frame.size.height) textString:@"广东省深圳市南山区 高新南七道" textColor:TEXT_COLOR textFont:FONT(11.0)];
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
    detailLabel = [CreateViewTool createLabelWithFrame:CGRectMake(localLabel.frame.origin.x, start_y, localLabel.frame.size.width, localLabel.frame.size.height) textString:@"距离您  km,上次更新时间:  " textColor:TEXT_COLOR textFont:FONT(11.0)];
    [detailView addSubview:detailLabel];
    
}

- (void)addBottomView
{
    float start_y = arrowButton.frame.size.height + arrowButton.frame.origin.y;
    float space_x = 2 * DETAIL_VIEW_SPACE_XY * scale;
    float height = 0.0;
    NSArray *imageArray = @[@"ures_ico_battery.png",@"ures_ico_signal.png",@"ures_ico_speed.png",@"ures_ico_weilan.png"];
    NSArray *textArray = @[@" %",@" ",@" km/h",@"共  个围栏"];
    int row = ceil([imageArray count]/2);
    for (int i = 0; i < row; i++)
    {
        for (int j = 0; j < 2; j++)
        {
            int objectIndex = i * 2 + j;
            if (objectIndex >= [imageArray count])
            {
                break;
            }
            UIImage *image = [UIImage imageNamed:imageArray[objectIndex]];
            float iconWidth = image.size.width/2 * scale;
            float iconHeight = image.size.height/2 * scale;
            float labeWidth = (detailView.frame.size.width - 2 * space_x - iconWidth * 2 - space_x * 3)/2;
            float labeHeight = iconHeight;
            height = iconHeight;
            UIImageView *iconImageView = [CreateViewTool createImageViewWithFrame:CGRectMake(space_x + j * (space_x + labeWidth), start_y + i * (iconHeight + LABEL_ADDSPACE_Y * scale), iconWidth, labeHeight) placeholderImage:image];
            [detailView addSubview:iconImageView];
            
            UILabel *label = [CreateViewTool createLabelWithFrame:CGRectMake(iconImageView.frame.origin.x + iconImageView.frame.size.width + space_x, iconImageView.frame.origin.y, labeWidth, labeHeight) textString:textArray[objectIndex] textColor:TEXT_COLOR textFont:FONT(11.0)];
            label.tag = objectIndex + 100;
            [detailView addSubview:label];
        }
    }
    
    CGRect frame = detailView.frame;
    frame.size.height = start_y + row * (height + LABEL_ADDSPACE_Y * scale) + arrowButton.frame.size.height;
    detailView.frame = frame;
}

#pragma mark 设置数据
- (void)setDetailInfo:(id)detailInfo
{
    [super setDetailInfo:detailInfo];
    [self setDetailViewData];
}

- (void)setDetailViewData
{
    if ([self.detailInfo isKindOfClass:[LookFor_Friend class]])
    {
        LookFor_Friend *friendInfo = (LookFor_Friend *)self.detailInfo;
        NSString *name = friendInfo.nickName;
        name = (friendInfo.commentName && ![@"" isEqualToString:friendInfo.commentName]) ? friendInfo.commentName : name;
        [self setDataForTitleLabel:name  localLabel:friendInfo.location detailLabel:friendInfo.updateTime];
    }
    
    if ([self.detailInfo isKindOfClass:[LookFor_FriendDetail class]])
    {
        LookFor_FriendDetail *friendDetailInfo = (LookFor_FriendDetail *)self.detailInfo;
        NSString *battery = [NSString stringWithFormat:@"%.0f％",friendDetailInfo.battery];
        NSString *signal = [NSString stringWithFormat:@"%.0f",friendDetailInfo.signal];
        NSString *velocity = [NSString stringWithFormat:@"%.0fkm/h",friendDetailInfo.velocity];
        NSString *lattice = [NSString stringWithFormat:@"共%d个围栏",friendDetailInfo.lattice];
        NSArray *array = @[battery,signal,velocity,lattice];
        for (int i = 0; i < 4; i++)
        {
            UILabel *label = (UILabel *)[detailView viewWithTag:i + 100];
            label.text = array[i];
        }
        NSString *name = friendDetailInfo.nickName;
        name = (friendDetailInfo.commentName && ![@"" isEqualToString:friendDetailInfo.commentName]) ? friendDetailInfo.commentName : name;
        [self setDataForTitleLabel:name  localLabel:friendDetailInfo.location detailLabel:friendDetailInfo.updateTime];
    }
}

- (void)setDataForTitleLabel:(NSString *)title localLabel:(NSString *)location detailLabel:(NSString *)detail
{
    titleLabel.text = title;
    localLabel.text = location;
    detailLabel.text = [NSString stringWithFormat:@"距离您%.1fkm,上次更新时间:%@",self.distance,detail];
}


#pragma mark 相关操作
- (void)dismiss
{
    [super dismiss];
    if (self.delegate && [self.delegate respondsToSelector:@selector(friendDetailViewClickedClose)])
    {
        [self.delegate friendDetailViewClickedClose];
    }
}


- (void)goThereButtonPressed:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(friendDetailViewClickedGoThereWithIndex:)])
    {
        [self.delegate friendDetailViewClickedGoThereWithIndex:self.index];
        [self dismiss];
    }
}


- (void)dealloc
{
    self.delegate = nil;
}


@end
