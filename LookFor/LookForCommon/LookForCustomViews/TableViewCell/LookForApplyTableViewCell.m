//
//  LookForApplyTableViewCell.m
//  LookFor
//
//  Created by chenmingguo on 15-1-29.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForApplyTableViewCell.h"

#define LabelH      13

#define TypeLabelW   60

@interface LookForApplyTableViewCell ()

@property (nonatomic, strong) UILabel *typeLabel;       //右边状态label
@property (nonatomic, strong) UILabel *timeLabel;       //时间lable
@property (nonatomic, strong) UILabel *nameLabel;       //姓名
@property (nonatomic, strong) UILabel *messageLabel;    //申请原因
@end


@implementation LookForApplyTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    UILabel *tempLabel = [CreateViewTool createLabelWithFrame:CGRectMake(LeftSpace, DefaultSpace, 30, LabelH)
                                                   textString:@"申请"
                                                    textColor:[UIColor lightGrayColor]
                                                     textFont:[UIFont systemFontOfSize:11]];
    [self addSubview:tempLabel];
    
    self.nameLabel = [CreateViewTool createLabelWithFrame:CGRectMake(LeftSpace + tempLabel.frame.size.width + DefaultSpace / 2, DefaultSpace, 100, LabelH)
                                               textString:nil
                                                textColor:[UIColor blackColor]
                                                 textFont:[UIFont systemFontOfSize:11]];
    [self addSubview:self.nameLabel];
    
    self.messageLabel = [CreateViewTool createLabelWithFrame:CGRectMake(self.nameLabel.frame.origin.x + self.nameLabel.frame.size.width, DefaultSpace, 100, LabelH)
                                                  textString:nil
                                                   textColor:[UIColor lightGrayColor]
                                                    textFont:[UIFont systemFontOfSize:11]];
    [self addSubview:self.messageLabel];
    
    self.typeLabel = [CreateViewTool createLabelWithFrame:CGRectMake(MAIN_SCREEN_SIZE.width - LeftSpace - TypeLabelW, (self.frame.size.height - LabelH) /2, TypeLabelW, LabelH)
                                               textString:nil
                                                textColor:[UIColor lightGrayColor]
                                                 textFont:[UIFont systemFontOfSize:11]];
    self.typeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.typeLabel];
    
    self.timeLabel = [CreateViewTool createLabelWithFrame:CGRectMake(LeftSpace, self.nameLabel.frame.size.height + self.nameLabel.frame.origin.y + DefaultSpace / 2, 100, LabelH)
                                               textString:nil
                                                textColor:[UIColor lightGrayColor]
                                                 textFont:[UIFont systemFontOfSize:10]];
    [self addSubview:self.timeLabel];
    
    
    UIView *buttomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, MAIN_SCREEN_SIZE.width, 0.5)];
    buttomLine.backgroundColor = SeparatorLineColor;
    buttomLine.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:buttomLine];
}


- (void)setTypeText:(NSString *)typeText {
    self.typeLabel.text = typeText;
}

- (void)setTimeText:(NSString *)timeText {
    self.timeLabel.text = timeText;
}

- (void)setNameText:(NSString *)nameText {
    self.nameLabel.text = nameText;
    
    CGSize size = [CommonTool stringWidthWithStr:nameText
                                        textFont:[UIFont systemFontOfSize:11]
                                       labelSize:CGSizeMake(150, LabelH)];\
    self.nameLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y, size.width, LabelH);
    self.messageLabel.frame = CGRectMake(self.nameLabel.frame.origin.x + size.width +DefaultSpace / 2, self.messageLabel.frame.origin.y, MAIN_SCREEN_SIZE.width - self.typeLabel.frame.size.width - self.nameLabel.frame.origin.x - size.width - DefaultSpace / 2, LabelH);
}

- (void)setMessageText:(NSString *)messageText {
    self.messageLabel.text = messageText;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
