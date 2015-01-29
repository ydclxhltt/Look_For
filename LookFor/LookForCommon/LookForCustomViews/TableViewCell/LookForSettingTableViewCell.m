//
//  LookForSettingTableViewCell.m
//  LookFor
//
//  Created by chenmingguo on 15-1-25.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForSettingTableViewCell.h"
#define TitleLabelH     13
#define DetailLabelH    10
#define TitleLableW     100
#define MoreImageWH     20

@interface LookForSettingTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *moreImageView;
@end


@implementation LookForSettingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)initView {
    self.titleLabel = [CreateViewTool createLabelWithFrame:CGRectMake(LeftSpace, (self.frame.size.height - TitleLabelH) / 2, TitleLableW, TitleLabelH) textString:nil textColor:[UIColor blackColor] textFont:[UIFont systemFontOfSize:12]];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.titleLabel];
    
    self.moreImageView = [CreateViewTool createImageViewWithFrame:CGRectMake(MAIN_SCREEN_SIZE.width - LeftSpace - MoreImageWH - DefaultSpace, (self.frame.size.height - MoreImageWH) / 2, MoreImageWH, MoreImageWH) placeholderImage:nil];
    self.moreImageView.image = [UIImage imageNamed:@"arrow_down.png"];
    [self addSubview:self.moreImageView];
    
    self.detailLabel = [CreateViewTool createLabelWithFrame:CGRectMake(LeftSpace + TitleLableW, (self.frame.size.height - DetailLabelH) / 2, MAIN_SCREEN_SIZE.width - LeftSpace - TitleLableW -DefaultSpace - self.moreImageView.frame.origin.x, DetailLabelH)
                                                textString:nil
                                                 textColor:[UIColor blackColor]
                                                  textFont:[UIFont systemFontOfSize:12]];
    [self addSubview:self.detailLabel];
    
    UIView *buttomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, MAIN_SCREEN_SIZE.width, 0.5)];
    buttomLine.backgroundColor = SeparatorLineColor;
    [self addSubview:buttomLine];

    
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
@end
