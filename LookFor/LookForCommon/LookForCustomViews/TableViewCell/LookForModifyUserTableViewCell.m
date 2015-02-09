//
//  LookForModifyUserTableViewCell.m
//  LookFor
//
//  Created by chenmingguo on 15-1-23.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForModifyUserTableViewCell.h"

#define LabelH      20
#define TitleW      80

#define MoreImageWH 15
#define SexLWH      15
#define ButtonW     10

@interface LookForModifyUserTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *moreImageView;
@property (nonatomic, strong) UILabel *sexLabel;
@property (nonatomic, strong) UIImageView *sexImageView;
@end

@implementation LookForModifyUserTableViewCell

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
    self.titleLabel = [CreateViewTool createLabelWithFrame:CGRectMake(LeftSpace, (self.frame.size.height - LabelH) / 2, TitleW, LabelH)
                                                textString:nil
                                                 textColor:TitleColor
                                                  textFont:[UIFont systemFontOfSize:14]];
    [self addSubview:self.titleLabel];
    
    self.detailLabel = [CreateViewTool createLabelWithFrame:CGRectMake(self.titleLabel.frame.origin.x + TitleW - DefaultSpace / 2, (self.frame.size.height - LabelH) / 2, MAIN_SCREEN_SIZE.width - TitleW- LeftSpace * 2 - DefaultSpace, LabelH) textString:nil textColor:DetailColor textFont:[UIFont systemFontOfSize:13]];
    self.detailLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.detailLabel];
    
    self.moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_SIZE.width - LeftSpace - MoreImageWH, (self.frame.size.height - MoreImageWH) / 2, MoreImageWH, MoreImageWH)];
    self.moreImageView.image = [UIImage imageNamed:@"arrow_down.png"];
    [self addSubview:self.moreImageView];
  
    
    UIView *buttomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, MAIN_SCREEN_SIZE.width, 0.5)];
    buttomLine.backgroundColor = SeparatorLineColor;
    buttomLine.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;

    [self addSubview:buttomLine];
}


- (void)setSexText:(NSString *)sexText withImageView:(NSString *)imageName {

    if (sexText) {
        self.detailLabel.hidden = YES;
        self.sexLabel = [CreateViewTool createLabelWithFrame:CGRectMake(self.moreImageView.frame.origin.x - LeftSpace - SexLWH, (self.frame.size.height - SexLWH) / 2, SexLWH, SexLWH)
                                                        textString:@""
                                                         textColor:DetailColor
                                                          textFont:[UIFont systemFontOfSize:14]];
        self.sexLabel.text = sexText;
        [self addSubview: self.sexLabel];
        self.sexImageView = [CreateViewTool createImageViewWithFrame:CGRectMake(self.sexLabel.frame.origin.x + SexLWH, (self.frame.size.height - ButtonW) / 2, ButtonW, ButtonW) placeholderImage:[UIImage imageNamed:imageName]];
        
        [self addSubview:self.sexImageView];
        
     } else {
        self.detailLabel.hidden = NO;
    }
}


- (void)setTitleText:(NSString *)titleText {
    self.titleLabel.text = titleText;
}

- (void)setDetailText:(NSString *)detailText {
    self.detailLabel.text = detailText;
}

@end
