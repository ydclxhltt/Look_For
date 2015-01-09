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

@interface LookForSaveTradeTableViewCell ()

@property (nonatomic, strong) UIImageView   *headImageView;
@property (nonatomic, strong) UILabel       *detailLabel;
@property (nonatomic, strong) UIImageView   *moreImage;
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
        self.detailLabel.font = [UIFont systemFontOfSize:13];
        self.detailLabel.textColor = [UIColor blackColor];
        self.detailLabel.textAlignment = NSTextAlignmentLeft;
        self.detailLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.detailLabel];
        
        self.moreImage = [[UIImageView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_SIZE.width - LeftSpace - MoreImageWH,  (self.frame.size.height - MoreImageWH) / 2, MoreImageWH, MoreImageWH)];
        self.moreImage.image = [UIImage imageNamed:@"poi_1.png"];
        [self addSubview:self.moreImage];
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
