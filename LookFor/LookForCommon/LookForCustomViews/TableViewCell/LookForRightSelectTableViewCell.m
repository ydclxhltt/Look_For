//
//  LookForRightSelectTableViewCell.m
//  LookFor
//
//  Created by chenmingguo on 15-1-27.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForRightSelectTableViewCell.h"
#define TitleLabelH       13
#define SelectImageWH     25

@interface LookForRightSelectTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *selectImageView;

@end

@implementation LookForRightSelectTableViewCell

@synthesize delegate;

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
    self.titleLabel = [CreateViewTool createLabelWithFrame:CGRectMake(LeftSpace, (self.frame.size.height - TitleLabelH) / 2, MAIN_SCREEN_SIZE.width - LeftSpace* 2 - SelectImageWH, TitleLabelH)
                                                textString:nil
                                                 textColor:[UIColor blackColor]
                                                  textFont:[UIFont systemFontOfSize:12]];
    [self addSubview:self.titleLabel];
    
    self.selectImageView = [CreateViewTool createImageViewWithFrame:CGRectMake(MAIN_SCREEN_SIZE.width - LeftSpace - SelectImageWH, (self.frame.size.height - SelectImageWH) / 2, SelectImageWH, SelectImageWH) placeholderImage:nil];
    self.selectImageView.image = [UIImage imageNamed:@"select_default.png"];
    [self addSubview:self.selectImageView];
    
    UIView *buttomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, MAIN_SCREEN_SIZE.width, 0.5)];
    buttomLine.backgroundColor = SeparatorLineColor;
    buttomLine.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:buttomLine];

}

- (void)setSelectImage:(NSString *)imageName {
    if (imageName == nil) {
        return;
    }
    
    self.selectImageView.image = [UIImage imageNamed:imageName];
}

- (void)setTitleText:(NSString *)titleText {
    if (titleText.length <= 0) {
        return;
    }
    
    self.titleLabel.text = titleText;
}

- (void)setDeleteImageName:(NSString *)deleteImageName {
    self.selectImageView.hidden = YES;
    
    UIButton *button = [CreateViewTool createButtonWithFrame:self.selectImageView.frame
                                                 buttonImage:deleteImageName
                                                selectorName:@"handleDelete"
                                                 tagDelegate:self];
    [self addSubview:button];
}

- (void)handleDelete {
    if ([self.delegate respondsToSelector:@selector(deleteItem:)]) {
        [self.delegate deleteItem:self];
    }
}

@end
