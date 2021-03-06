
//
//  LookForSelectFriendTableViewCell.m
//  LookFor
//
//  Created by chenmingguo on 15-1-13.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "LookForSelectFriendTableViewCell.h"

#define SelectImageWH   20
#define HeadImageWH     30
#define NameLabelH      20

@interface LookForSelectFriendTableViewCell ()

@property (nonatomic, strong) UIImageView *selectImageView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation LookForSelectFriendTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.backgroundColor = [UIColor clearColor];
    self.selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(LeftSpace, (self.frame.size.height - SelectImageWH) / 2, SelectImageWH, SelectImageWH)];
    self.selectImageView.backgroundColor = [UIColor clearColor];
    self.selectImageView.image = [UIImage imageNamed:@"select_default.png"];
    [self addSubview:self.selectImageView];
    
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(LeftSpace + SelectImageWH + DefaultSpace, (self.frame.size.height - HeadImageWH) / 2, HeadImageWH, HeadImageWH)];
    self.headImageView.backgroundColor = [UIColor redColor];
    self.headImageView.layer.cornerRadius = HeadImageWH / 2 ;
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.headImageView];

    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImageView.frame.origin.x + HeadImageWH + DefaultSpace, (self.frame.size.height - NameLabelH) / 2, MAIN_SCREEN_SIZE.width - self.headImageView.frame.origin.x + HeadImageWH - LeftSpace, NameLabelH)];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    self.nameLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.nameLabel];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, self.bounds.size.width, 0.5)];
    line.backgroundColor = SeparatorLineColor;
    line.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;

    [self addSubview:line];
}


- (void)setHeadImage:(NSString *)imageName {
    self.headImageView.image = [UIImage imageNamed:imageName];
}

- (void)setFriendSelected:(BOOL)friendSelected {
    if (friendSelected) {
        self.selectImageView.image = [UIImage imageNamed:@"selected.png"];

    } else {
        self.selectImageView.image = [UIImage imageNamed:@"select_default.png"];

    }
}

- (void)setNameText:(NSString *)nameText {
    if (nameText.length <= 0) {
        return;
    }
    self.nameLabel.text = nameText;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
