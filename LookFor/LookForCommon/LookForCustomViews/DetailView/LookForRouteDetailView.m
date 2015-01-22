//
//  LookForRouteDetailView.m
//  LookFor
//
//  Created by clei on 15/1/22.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForRouteDetailView.h"

#define DETAIL_LABEL_SPACE_X   30.0
#define DETAIL_LABEL_Height    30.0
#define RAUTE_COLOR            RGB(255.0,102.0,85)

@interface LookForRouteDetailView()
{
    UILabel *detailLabel;
}
@end

@implementation LookForRouteDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)initView
{
    detailViewHeight = self.frame.size.height;
    [self addDetailView];
    [self addCloseButton];
    [self addDetailLabel];
}


- (void)addDetailLabel
{
    float space_x = DETAIL_LABEL_SPACE_X * scale;
    float labelWidth = self.frame.size.width - space_x * 2;
    float labelHeight = DETAIL_LABEL_Height * scale;
    float space_y = (detailViewHeight - labelHeight * scale - DETAIL_VIEW_SPACE_XY * scale)/2 + DETAIL_VIEW_SPACE_XY * scale;
    detailLabel = [CreateViewTool createLabelWithFrame:CGRectMake(space_x,space_y,labelWidth,labelHeight) textString:@" km  需要 小时 分钟" textColor:[UIColor blackColor] textFont:FONT(15.0)];
    [self addSubview:detailLabel];
}


- (void)setDetailTextWithDistance:(int)distance goThereTimeHour:(int)hour  goThereTimeMinute:(int)minute goThereType:(NSString *)type
{
    NSString *hourStr = [NSString stringWithFormat:@" %d ",hour];
    NSString *minuteStr = [NSString stringWithFormat:@" %d ",minute];
    NSString *distanceStr = [NSString stringWithFormat:@" %.1f ",distance/1000.0];
    NSString *detailText = [NSString stringWithFormat:@"%@%@km  需要 %@小时%@分钟",type,distanceStr,hourStr,minuteStr];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:detailText];
    [self makeString:detailText toAttributeString:attributedString withString:distanceStr];
    [self makeString:detailText toAttributeString:attributedString withString:hourStr];
    [self makeString:detailText toAttributeString:attributedString withString:minuteStr];
    detailLabel.attributedText = attributedString;
}

- (void)makeString:(NSString *)textString toAttributeString:(NSMutableAttributedString *)attributedString  withString:(NSString *)string
{
    [attributedString addAttribute:NSFontAttributeName
                             value:BOLD_FONT(17.0)
                             range:[textString rangeOfString:string]];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:RAUTE_COLOR
                             range:[textString rangeOfString:string]];
}

@end
