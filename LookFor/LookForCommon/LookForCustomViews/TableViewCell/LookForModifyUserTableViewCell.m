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
#define SexLWH      12
#define ButtonW     20

@interface LookForModifyUserTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *moreImageView;

@end

@implementation LookForModifyUserTableViewCell
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
    self.titleLabel = [CreateViewTool createLabelWithFrame:CGRectMake(LeftSpace, (self.frame.size.height - LabelH) / 2, TitleW, LabelH)
                                                textString:nil
                                                 textColor:[UIColor blackColor]
                                                  textFont:[UIFont systemFontOfSize:12]];
    [self addSubview:self.titleLabel];
    
    self.detailLabel = [CreateViewTool createLabelWithFrame:CGRectMake(self.titleLabel.frame.origin.x + TitleW, (self.frame.size.height - LabelH) / 2, MAIN_SCREEN_SIZE.width - TitleW- LeftSpace * 2 - DefaultSpace, LabelH) textString:nil textColor:[UIColor grayColor] textFont:[UIFont systemFontOfSize:12]];
    self.detailLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.detailLabel];
    
    self.moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_SIZE.width - LeftSpace - MoreImageWH, (self.frame.size.height - MoreImageWH) / 2, MoreImageWH, MoreImageWH)];
    [self addSubview:self.moreImageView];
  
    
    UIView *buttomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, MAIN_SCREEN_SIZE.width, 0.5)];
    buttomLine.backgroundColor = SeparatorLineColor;
    [self addSubview:buttomLine];
}


- (void)isSexSelect:(BOOL)isSex {

    if (isSex) {
        self.detailLabel.hidden = YES;
        self.moreImageView.hidden = YES;
        UILabel *womanLabel = [CreateViewTool createLabelWithFrame:CGRectMake(MAIN_SCREEN_SIZE.width - LeftSpace - SexLWH, (self.frame.size.height - SexLWH) / 2, SexLWH, SexLWH)
                                                        textString:@"女"
                                                         textColor:[UIColor blackColor]
                                                          textFont:[UIFont systemFontOfSize:12]];
        [self addSubview:womanLabel];
        UIButton *womanButton = [CreateViewTool createButtonWithFrame:CGRectMake(womanLabel.frame.origin.x - ButtonW, (self.frame.size.height - 40) / 2, ButtonW, 40)
                                                          buttonImage:nil
                                                         selectorName:@"handleWoman"
                                                          tagDelegate:self];
        [self addSubview:womanButton];
        
        UILabel *manLabel = [CreateViewTool createLabelWithFrame:CGRectMake(womanButton.frame.origin.x - 5 - SexLWH, (self.frame.size.height - SexLWH) / 2, SexLWH, SexLWH)
                                                      textString:@"男"
                                                       textColor:[UIColor blackColor]
                                                        textFont:[UIFont systemFontOfSize:12]];
        [self addSubview:manLabel];
        
        UIButton *manButton = [CreateViewTool createButtonWithFrame:CGRectMake(manLabel.frame.origin.x - ButtonW, (self.frame.size.height - 40) / 2, ButtonW, 40)
                                                          buttonImage:nil
                                                         selectorName:@"handleMan"
                                                          tagDelegate:self];
        [self addSubview:manButton];
    } else {
    
        self.detailLabel.hidden = NO;
        self.moreImageView.hidden = NO;
    }
}


- (void)handleWoman {
    if ([self.delegate respondsToSelector:@selector(selectIndex:)]) {
        [self.delegate selectIndex:1];
    }
}

- (void)handleMan {
    if ([self.delegate respondsToSelector:@selector(selectIndex:)]) {
        [self.delegate selectIndex:0];
    }
}

- (void)setTitleText:(NSString *)titleText {
    self.titleLabel.text = titleText;
}

- (void)setDetailText:(NSString *)detailText {
    self.detailLabel.text = detailText;
}

@end
