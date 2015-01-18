//
//  LookForAssemblyTableViewCell.m
//  LookFor
//
//  Created by chenmingguo on 15-1-18.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForAssemblyTableViewCell.h"

#define HeadImageWH     20
#define LeftSpace       15
#define DefaultSpace    10
#define TitleLabelH     13
#define DetailLabelH    10
#define TimeLabelW      80

@interface LookForAssemblyTableViewCell ()

@property (nonatomic, strong) UIImageView   *headImageView;
@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UILabel       *detailLabel;
@property (nonatomic, strong) UILabel       *timeLabel;
@end


@implementation LookForAssemblyTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(LeftSpace, (self.frame.size.height - HeadImageWH) / 2, HeadImageWH, HeadImageWH)];
    [self addSubview:self.headImageView];

    self.titleLabel = [CreateViewTool createLabelWithFrame:CGRectMake(self.headImageView.frame.origin.x + HeadImageWH + DefaultSpace / 2, DefaultSpace / 2,(MAIN_SCREEN_SIZE.width - self.headImageView.frame.origin.x - HeadImageWH - DefaultSpace / 2 - LeftSpace), TitleLabelH)
                                                textString:nil
                                                 textColor:[UIColor blackColor]
                                                  textFont:[UIFont systemFontOfSize:12]];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.titleLabel];
    
    self.timeLabel = [CreateViewTool createLabelWithFrame:CGRectMake((MAIN_SCREEN_SIZE.width - TimeLabelW - LeftSpace), DefaultSpace / 2, TimeLabelW, TitleLabelH)
                                               textString:nil
                                                textColor:[UIColor lightGrayColor]
                                                 textFont:[UIFont systemFontOfSize:10]];
    self.timeLabel.backgroundColor = [UIColor clearColor];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.timeLabel];
    
    self.detailLabel = [CreateViewTool createLabelWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + TitleLabelH + DefaultSpace / 3,(MAIN_SCREEN_SIZE.width - self.titleLabel.frame.origin.x - LeftSpace) , DetailLabelH)
                                                 textString:nil
                                                  textColor:[UIColor lightGrayColor]
                                                   textFont:[UIFont systemFontOfSize:10]];
    self.detailLabel.backgroundColor = [UIColor clearColor];
    self.detailLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.detailLabel];
    
    UIView *buttomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, MAIN_SCREEN_SIZE.width, 0.5)];
    buttomLine.backgroundColor = SeparatorLineColor;
    [self addSubview:buttomLine];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitleText:(NSString *)titleText {
    if (titleText.length <= 0) {
        return;
    }
    self.titleLabel.text = titleText;
}

- (void)setDetailText:(NSString *)detailText {
    if (detailText.length <= 0) {
        return;
    }
    self.detailLabel.text = detailText;
}

- (void)setTimeText:(NSString *)timeText {
    if (timeText.length <= 0) {
        return;
    }
    
    self.timeLabel.text = timeText;
}

- (void)setHeadImage:(UIImage *)headImage {
    if (headImage == nil) {
        return;
    }
    
    self.headImageView.image = headImage;
}

@end
