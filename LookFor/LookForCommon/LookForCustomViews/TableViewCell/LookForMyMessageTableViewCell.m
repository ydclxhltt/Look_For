//
//  LookForMyMessageTableViewCell.m
//  LookFor
//
//  Created by chenmingguo on 15-1-27.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//



#import "LookForMyMessageTableViewCell.h"

#define LeftSpace       15
#define DefaultSpace    10
#define TitleLabelH     13
#define DetailLabelH    10
#define TimeLabelW      80
#define ButtonW         40

#define Tag             100

@interface LookForMyMessageTableViewCell ()
@property (nonatomic, strong) UIImageView   *headImageView;     //头像
@property (nonatomic, strong) UILabel       *titleLabel;        //标题
@property (nonatomic, strong) UILabel       *detailLabel;       //描述
@property (nonatomic, strong) UILabel       *timeLabel;         //时间

@property (nonatomic, strong) UILabel       *sureLabel;         //确定label

@property (nonatomic, strong) UIButton      *confirmButton;     //确定按钮
@property (nonatomic, strong) UIButton      *refuseButton;      //拒绝按钮
@end


@implementation LookForMyMessageTableViewCell

@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {

    self.headImageView = [CreateViewTool createImageViewWithFrame:CGRectMake(LeftSpace, DefaultSpace  , self.frame.size.height - DefaultSpace * 2, self.frame.size.height - DefaultSpace * 2) placeholderImage:nil];
    [self addSubview:self.headImageView];
    
    self.titleLabel = [CreateViewTool createLabelWithFrame:CGRectMake(LeftSpace + DefaultSpace / 2+ self.headImageView.frame.size.width, LeftSpace, MAIN_SCREEN_SIZE.width - ButtonW * 2 - LeftSpace - DefaultSpace, TitleLabelH) textString:nil textColor:[UIColor blackColor] textFont:[UIFont systemFontOfSize:12]];
    [self addSubview:self.titleLabel];
    
    self.detailLabel = [CreateViewTool createLabelWithFrame:CGRectMake(self.titleLabel.frame.origin.x, LeftSpace + TitleLabelH + DefaultSpace / 2, self.titleLabel.frame.size.width, DetailLabelH) textString:nil
                                                  textColor:[UIColor lightGrayColor] textFont:[UIFont systemFontOfSize:11]];
    [self addSubview:self.detailLabel];
    
    self.sureLabel = [CreateViewTool createLabelWithFrame:CGRectMake(MAIN_SCREEN_SIZE.width - LeftSpace - 60, (self.frame.size.height - TitleLabelH )/2, 60, TitleLabelH)
                                               textString:nil
                                                textColor:[UIColor blackColor]
                                                 textFont:[UIFont systemFontOfSize:12]];
    self.sureLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.sureLabel];

    self.timeLabel = [CreateViewTool createLabelWithFrame:CGRectMake(MAIN_SCREEN_SIZE.width - LeftSpace - TimeLabelW, LeftSpace, TimeLabelW, DetailLabelH)
                                               textString:nil
                                                textColor:[UIColor lightGrayColor]
                                                 textFont:[UIFont systemFontOfSize:11]];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.timeLabel];
    
    self.refuseButton = [CreateViewTool createButtonWithFrame:CGRectMake(MAIN_SCREEN_SIZE.width - LeftSpace - ButtonW, self.frame.size.height - LeftSpace - self.timeLabel.frame.size.height, ButtonW, self.frame.size.height - LeftSpace - DetailLabelH - DefaultSpace / 2)
                                                  buttonImage:nil
                                                 selectorName:@"handleRefuse"
                                                  tagDelegate:self];
    [self.refuseButton setTitle:@"拒绝" forState:UIControlStateNormal];
    self.refuseButton.hidden = YES;
    self.refuseButton.tag = Tag + 1;
    [self addSubview:self.refuseButton];
    
    self.confirmButton = [CreateViewTool createButtonWithFrame:CGRectMake(self.refuseButton.frame.origin.x - DefaultSpace / 2 - ButtonW, self.refuseButton.frame.origin.y, ButtonW, self.refuseButton.frame.size.height)
                                                   buttonImage:nil
                                                  selectorName:@"handleConfirm"
                                                   tagDelegate:self];
    self.confirmButton.hidden = YES;
    self.confirmButton.tag = Tag;
    [self.confirmButton setTitle:@"同意" forState:UIControlStateNormal];

    [self addSubview:self.confirmButton];
    UIView *buttomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, MAIN_SCREEN_SIZE.width, 0.5)];
    buttomLine.backgroundColor = SeparatorLineColor;
    buttomLine.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:buttomLine];

}

#pragma mark -handle
- (void)handleRefuse {
    if ([self.delegate respondsToSelector:@selector(selectButton:withIndex:)]) {
        [self.delegate selectButton:self withIndex:Tag + 1];
    }
}

- (void)handleConfirm {
    if ([self.delegate respondsToSelector:@selector(selectButton:withIndex:)]) {
        [self.delegate selectButton:self withIndex:Tag];
    }
}

- (void)setImageName:(NSString *)imageName {
    if (imageName.length) {
        self.headImageView.image = [UIImage imageNamed:imageName];
    }
}

- (void)setTitleText:(NSString *)titleText {
    self.titleLabel.text = titleText;
}

- (void)setDetailText:(NSString *)detailText {
    self.detailLabel.text = detailText;
}

- (void)setTimeText:(NSString *)timeText {
    if (timeText.length <= 0) {
        return;
    }
    
    self.timeLabel.text = timeText;
    self.timeLabel.hidden = NO;
    self.refuseButton.hidden = NO;
    self.confirmButton.hidden = NO;
    self.sureLabel.hidden = YES;
}

- (void)setSureText:(NSString *)sureText {
    if (sureText.length <= 0) {
        return;
    }
    
    self.sureLabel.text = sureText;
    self.timeLabel.hidden = YES;
    self.refuseButton.hidden = YES;
    self.confirmButton.hidden = YES;
    self.sureLabel.hidden = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
