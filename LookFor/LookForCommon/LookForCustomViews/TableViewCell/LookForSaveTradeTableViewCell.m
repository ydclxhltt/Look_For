//
//  LookForSaveTradeTableViewCell.m
//  LookFor
//
//  Created by chenmingguo on 15-1-9.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "LookForSaveTradeTableViewCell.h"

#define HeadImageWH     20
#define LabelH          14
#define MoreImageWH     15
#define LeftSpace       15

#define RightImageWH    30

@interface LookForSaveTradeTableViewCell ()

@property (nonatomic, strong) UIImageView   *headImageView;
@property (nonatomic, strong) UILabel       *detailLabel;
@property (nonatomic, strong) UIImageView   *moreImage;

//针对右侧显示内容和图片
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIImageView *rightImageView;
@end

@implementation LookForSaveTradeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(LeftSpace, (self.frame.size.height - HeadImageWH) / 2, HeadImageWH, HeadImageWH)];
        [self addSubview:self.headImageView];
        
        self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImageView.frame.origin.x + HeadImageWH + LeftSpace / 2,
                                                                        (self.frame.size.height - LabelH) / 2,
                                                                        (MAIN_SCREEN_SIZE.width - (self.headImageView.frame.origin.x + HeadImageWH + LeftSpace / 2) - LeftSpace - MoreImageWH),
                                                                        LabelH)];
        self.detailLabel.font = [UIFont systemFontOfSize:12];
        self.detailLabel.textColor = [UIColor blackColor];
        self.detailLabel.textAlignment = NSTextAlignmentLeft;
        self.detailLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.detailLabel];
        
        self.rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.rightLabel.font = [UIFont systemFontOfSize:12];
        self.rightLabel.textColor = [UIColor blackColor];
        self.rightLabel.textAlignment = NSTextAlignmentRight;
        self.rightLabel.backgroundColor = [UIColor clearColor];
        self.rightLabel.hidden = YES;
        [self addSubview:self.rightLabel];
        
        self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.rightImageView.hidden = YES;
        [self addSubview:self.rightImageView];
        
        self.moreImage = [[UIImageView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_SIZE.width - LeftSpace - MoreImageWH,  (self.frame.size.height - MoreImageWH) / 2, MoreImageWH, MoreImageWH)];
        self.moreImage.image = [UIImage imageNamed:@"arrow_down.png"];
;
        [self addSubview:self.moreImage];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, MAIN_SCREEN_SIZE.width, 0.5)];
        line.backgroundColor = SeparatorLineColor;
        line.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;

        [self addSubview:line];
    }
    return self;
}

- (void)setDetailText:(NSString *)detailText {
    if (detailText.length > 0) {
        self.detailLabel.text = detailText;
    }
}

- (void)setHeadImageHighlighted:(BOOL)isHighlight {
    if (isHighlight) {
        self.headImageView.image = [UIImage imageNamed:@"poi_1.png"];
    } else {
        self.headImageView.image = [UIImage imageNamed:@"poi_1.png"];
    }
}

- (void)setRightText:(NSString *)text withColor:(UIColor *)color{
    CGSize size = [LookForUtil stringSizeWithFont:[UIFont systemFontOfSize:12] withSize:CGSizeMake(999, 9999) withString:text];
    self.rightLabel.hidden = NO;
    self.rightLabel.text = text;
    self.rightLabel.textColor = color;
    self.rightLabel.frame = CGRectMake(self.moreImage.frame.origin.x - size.width - 5, (self.frame.size.height - LabelH) / 2, size.width, LabelH);
    self.rightImageView.frame = CGRectMake(self.rightLabel.frame.origin.x - RightImageWH, (self.frame.size.height - RightImageWH) / 2, RightImageWH, RightImageWH);
}

- (void)setRightImage:(UIImage *)image {
    if (image == nil) {
        self.rightImageView.hidden = YES;
        return;
    }
    self.rightImageView.hidden = NO;
    
    self.rightImageView.frame = CGRectMake(self.rightLabel.frame.origin.x - RightImageWH, (self.frame.size.height - RightImageWH) / 2, RightImageWH, RightImageWH);
    self.rightImageView.image = image;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
