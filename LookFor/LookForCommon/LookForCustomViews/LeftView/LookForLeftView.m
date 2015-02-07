//
//  LookForLeftView.m
//  LookFor
//
//  Created by clei on 15/1/23.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#define ROWHEIGHT      64.0
#define SPACE_Y        50.0
#define ADDSPACE_Y     30.0
#define RIGHT_SPACE    55.0
#define USER_ICON_WH   55.0
#define LABEL_HEIGHT   20.0
#define SEX_ICON_SPACE 5.0

#import "LookForLeftView.h"
#import "LookForLeftItemView.h"

@interface LookForLeftView()<UITableViewDataSource,UITableViewDelegate>
{
    float scale;
    float labelWidth;
    UIImageView *bgImageView;
    UITableView *table;
    UIImageView *iconImageView,*sexImageView;
    UILabel *nameLabel,*userIDLabel;
}
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation LookForLeftView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        scale = CURRENT_SCALE;
        self.imageArray = @[@"my_quanta",@"message_open",@"friends",@"application",@"set"];
        self.titleArray = @[@"我的圈圈",@"我的信息",@"我的好友",@"我的申请",@"设置"];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUserInfo) name:@"SET_NICKNAME_SUCESS" object:nil];
        
        //滑动
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self                                               action:@selector(handlePan:)];
        [self addGestureRecognizer:panGestureRecognizer];
        [self initView];
        [self setUserInfo];
    }
    return self;
}


#pragma mark 初始化UI
- (void)initView
{
    [self addBgView];
    [self addTableView];
    [self addTableHeaderView];
}


- (void)addBgView
{
    bgImageView = [CreateViewTool createImageViewWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) placeholderImage:nil];
    bgImageView.backgroundColor = RGBA(0.0, 0.0, 0.0, .7);
    [self addSubview:bgImageView];
}


- (void)addTableView
{
    table=[[UITableView alloc]initWithFrame:CGRectMake(-(self.frame.size.width - RIGHT_SPACE * scale), 0, self.frame.size.width - RIGHT_SPACE * scale, self.frame.size.height) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.backgroundColor = [UIColor whiteColor];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:table];
}

- (void)addTableHeaderView
{
    UIImage *image = [UIImage imageNamed:@"left_ico_female.png"];
    
    float height = (USER_ICON_WH + SPACE_Y + ADDSPACE_Y) * scale;
    UIImageView *imageView = [CreateViewTool createImageViewWithFrame:CGRectMake(0, 0, table.frame.size.width, height) placeholderImage:nil];
    table.tableHeaderView = imageView;
    
    float space_x = (- (USER_ICON_WH - ICON_WIDTH)/2 + SPACE_X) * scale;
    iconImageView = [CreateViewTool createRoundImageViewWithFrame:CGRectMake(space_x, SPACE_Y * scale, USER_ICON_WH, USER_ICON_WH) placeholderImage:[UIImage imageNamed:@"1.jpg"] borderColor:nil imageUrl:nil];
    [imageView addSubview:iconImageView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hanleTap:)];
    [iconImageView addGestureRecognizer:tapGesture];
    
    float space_y = iconImageView.frame.origin.y + (iconImageView.frame.size.width - LABEL_HEIGHT * 2 * scale)/2;
    float label_space_x = iconImageView.frame.size.width + iconImageView.frame.origin.x + SPACE_X * scale;
    labelWidth = imageView.frame.size.width - label_space_x - SPACE_X * scale - image.size.width/2 * scale - SEX_ICON_SPACE * scale;
    nameLabel = [CreateViewTool createLabelWithFrame:CGRectMake(label_space_x, space_y, labelWidth, LABEL_HEIGHT) textString:@"" textColor:RGB(35.0, 31.0, 32.0) textFont:BOLD_FONT(16.0)];
    [imageView addSubview:nameLabel];
    
    userIDLabel = [CreateViewTool createLabelWithFrame:CGRectMake(label_space_x, space_y + nameLabel.frame.size.height, labelWidth, LABEL_HEIGHT) textString:@"" textColor:RGB(136.0, 136.0, 136.0) textFont:BOLD_FONT(12.0)];
    [imageView addSubview:userIDLabel];
    
    sexImageView = [CreateViewTool createImageViewWithFrame:CGRectMake(nameLabel.frame.size.width + nameLabel.frame.origin.x + SEX_ICON_SPACE * scale, nameLabel.frame.origin.y + (LABEL_HEIGHT - image.size.height/2)/2 * scale, image.size.width/2, image.size.height/2) placeholderImage:image];
    [imageView addSubview:sexImageView];
    
    
}

#pragma mark 设置数据
- (void)setUserInfo
{
    NSString *nickName = [UserDefaults objectForKey:@"nickName"];
    nickName = (nickName) ? nickName : @"";
    nickName = (!nickName) ? @"" : nickName;
    nameLabel.text = nickName;
    
    NSString *userID = [UserDefaults objectForKey:@"userID"];
    userIDLabel.text = userID;
    
    NSString *imageUrl = [UserDefaults objectForKey:@"userImage"];
    [iconImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    
    CGRect frame = nameLabel.frame;
    CGRect sexFrame = sexImageView.frame;
    float width = [nickName sizeWithAttributes:@{NSFontAttributeName : nameLabel.font}].width;
    frame.size.width = (width >= labelWidth) ? labelWidth : width;
    sexFrame.origin.x = frame.size.width + frame.origin.x + SEX_ICON_SPACE * scale;
    nameLabel.frame = frame;
    sexImageView.frame = sexFrame;
    
    int sex = [[UserDefaults objectForKey:@"sex"] intValue];
    sex = (sex == 0) ? 1 : sex;
    if (sex == 1)
    {
        sexImageView.image = [UIImage imageNamed:@"left_ico_female.png"];
    }
    else if (sex == 2)
    {
        sexImageView.image = [UIImage imageNamed:@"left_ico_male.png"];
    }
}

#pragma mark 相关控制

- (void)hanleTap:(UITapGestureRecognizer *)tapGesture
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(leftViewClickedIconImageView)])
    {
        [self.delegate leftViewClickedIconImageView];
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)panGuesture
{
    CGPoint translation = [panGuesture translationInView:self];
    NSLog(@"==%@",NSStringFromCGPoint(translation));
    if(abs(translation.x) > abs(translation.y))
    {
        float add_x = translation.x;
        float alpha = (table.frame.size.width - abs(translation.x))/table.frame.size.width;
        if (add_x >= 0 || add_x <= -table.frame.size.width)
        {
            return;
        }
        bgImageView.alpha = alpha;
        table.transform = CGAffineTransformMakeTranslation(add_x + table.frame.size.width, 0);
        if (panGuesture.state == UIGestureRecognizerStateEnded || panGuesture.state == UIGestureRecognizerStateCancelled )
        {
            if (abs(add_x) >= table.frame.size.width/2)
            {
                [self dismiss];
            }
            else
            {
                [self show];
            }
        }
    }
}



- (void)show
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [self moveViewWithPerValue:1.0];
    [table reloadData];
}

- (void)dismiss
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self moveViewWithPerValue:0.0];
}


- (void)moveViewWithPerValue:(float)value
{
    float move_x = 0.0;
    float alpha = 0.7;
    if (value == 1.0)
    {
        self.alpha = 1.0;
        move_x = table.frame.size.width;
    }
    if (value == 0.0)
    {
        move_x = - table.frame.size.width;
        alpha = 0.0;
    }
    [UIView animateWithDuration:.4 animations:^
    {
        table.transform = CGAffineTransformMakeTranslation(move_x, 0);
        bgImageView.alpha =  alpha;
    } completion:^(BOOL finfish)
    {
        if (value == 0)
        {
            self.alpha = 0.0;
        }
    }];
}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.imageArray count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  ROWHEIGHT * scale;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    LookForLeftItemView *button = (LookForLeftItemView *)[cell.contentView viewWithTag:indexPath.row + 100];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        button = [[LookForLeftItemView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, ROWHEIGHT * scale)];
        button.tag = indexPath.row + 100;
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
    }
    [button setImageWithImageName:self.imageArray[indexPath.row] labelText:self.titleArray[indexPath.row]];
    return cell;
}



- (void)buttonPressed:(UIButton *)sender
{
    [self dismiss];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(leftView:clickedButtonIndex:)])
    {
        [self.delegate leftView:self clickedButtonIndex:(int)sender.tag - 100];
    }
}


@end
