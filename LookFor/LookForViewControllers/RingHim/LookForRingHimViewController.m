//
//  LookForRingHimViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-2-11.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//


#import "LookForRingHimViewController.h"

#import "LookForSaveTradeTableViewCell.h"
#import "LookForSelectFriendViewController.h"
#import "LookForSelectAddressViewController.h"

#define HeadViewH       180
#define LeftSpace       15
#define ImageWH         70
#define TopSpace        10
#define TextViweH       80

#define Space           20
#define MessageH        88

#define PlaceholderText @"我想说点什么......"

@interface LookForRingHimViewController ()<UITextViewDelegate,
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UITableViewDataSource,
UITableViewDelegate,
LookForSelectFriendViewControllerDelegate>

@property (nonatomic, strong) UIView        *headView;              //图片描述view
@property (nonatomic, strong) UITextView    *messageTextView;       //输入框
@property (nonatomic, strong) UILabel       *placeholderLabel;      //输入框默认字体

@property (nonatomic, strong) UIImageView   *photoImageView;        //照片
@property (nonatomic, strong) UIActionSheet *photoSheet;            //照片来源选择
@property (nonatomic, strong) NSString      *photoFilePath;         //图片路径

@property (nonatomic, strong) NSString      *toAddressStr;        //要去的目的地
@property (nonatomic, strong) NSString      *friendName;           //朋友名称

@property (nonatomic, strong) UIView        *messageView;           //地址信息和朋友信息名称
@property (nonatomic, strong) UITableView   *messageTableView;      //

@end

@implementation LookForRingHimViewController

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = BASIC_VIEW_BG_COLOR;
    [self initView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"圈TA";
    [self setNavBarItemWithImageName:@"btn_back"
                         navItemType:LeftItem
                        selectorName:@"handleCancel"];
    
    [self setNavBarItemWithImageName:@"camera"
                         navItemType:rightItem
                        selectorName:@"handleCamera"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark -custom
- (void)initView {
    [self createHeaderView];
    [self createMessageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(LeftSpace, self.messageView.frame.origin.y + MessageH + Space * 2, MAIN_SCREEN_SIZE.width - 2*LeftSpace, 44);
    button.backgroundColor = UIColorFromRGB(0x22CCCC);
    [button setTitle:@"发送" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius =  24 ;
    button.layer.masksToBounds = YES;
    
    [button addTarget:self
               action:@selector(handleSend)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

//创建top输入框和图
- (void)createHeaderView {
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0,60, MAIN_SCREEN_SIZE.width, HeadViewH)];
    self.headView.backgroundColor = [UIColor whiteColor];
    self.messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(LeftSpace,
                                                                        TopSpace,
                                                                        MAIN_SCREEN_SIZE.width - 2*LeftSpace, TextViweH)];
    
    self.messageTextView.textColor = [UIColor blackColor];
    self.messageTextView.font = [UIFont systemFontOfSize:13];
    self.messageTextView.delegate = self;
    self.messageTextView.backgroundColor = [UIColor clearColor];
    // self.messageTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    self.messageTextView.keyboardType = UIKeyboardTypeDefault;
    self.messageTextView.contentInset = UIEdgeInsetsMake(-60, 0, 0, 0);
    [self.headView addSubview:self.messageTextView];
    
    self.placeholderLabel =[[UILabel alloc] initWithFrame:CGRectMake(5, 5, 80, 12)];
    self.placeholderLabel.font = [UIFont fontWithName:@"Arial" size:13.0];//设置字体名字和字体大小
    self.placeholderLabel.text = PlaceholderText;
    self.placeholderLabel.textColor = UIColorFromRGB(0xC8C9CA);
    self.placeholderLabel.backgroundColor = [UIColor clearColor];
    [self.messageTextView addSubview:self.placeholderLabel];
    
    self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(LeftSpace,
                                                                        self.messageTextView.frame.origin.y + self.messageTextView.frame.size.height,
                                                                        ImageWH, ImageWH)];
    self.photoImageView.backgroundColor = [UIColor clearColor];
    self.photoImageView.image = [UIImage imageNamed:@"1.jpg"];
    [self.headView addSubview:self.photoImageView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, HeadViewH - 0.5, MAIN_SCREEN_SIZE.width, 0.5)];
    line.backgroundColor = SeparatorLineColor;
    [self.headView addSubview:line];
    [self.view addSubview:self.headView];
}

- (void)createMessageView {
    self.messageView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                self.headView.frame.origin.y + HeadViewH + Space, MAIN_SCREEN_SIZE.width,
                                                                MessageH)];
    self.messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,MAIN_SCREEN_SIZE.width,MessageH)
                                                         style:UITableViewStylePlain];
    
    self.messageTableView.dataSource = self;
    self.messageTableView.delegate = self;
    self.messageTableView.backgroundColor = [UIColor whiteColor];
    self.messageTableView.separatorColor = [UIColor clearColor];// UIColorFromRGB(0xcccccc);
    self.messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.messageTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.messageTableView.showsVerticalScrollIndicator = YES;
    [self.messageView addSubview:self.messageTableView];
    
    
    UIView *headLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_SIZE.width, 0.5)];
    headLine.backgroundColor = SeparatorLineColor;
    [self.messageView addSubview:headLine];
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, MessageH - 0.5, MAIN_SCREEN_SIZE.width, 0.5)];
    bottomLine.backgroundColor = SeparatorLineColor;
    [self.messageView addSubview:bottomLine];
    
    [self.view addSubview:self.messageView];
    
}

#pragma mark -handle
- (void)handleCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleCamera {
    self.photoSheet = [[UIActionSheet alloc]
                       initWithTitle:nil
                       delegate:self
                       cancelButtonTitle:@"取消"
                       destructiveButtonTitle:nil
                       otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    
    [self.photoSheet showInView:self.view];
}

- (void)handleSend {
    
}

#pragma mark -UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.placeholderLabel.hidden =YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (self.messageTextView.text.length==0) {
        self.placeholderLabel.hidden =NO;
    }else{
        self.placeholderLabel.hidden =YES;
    }
}

#pragma photo
#pragma mark -UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == self.photoSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
    }
    
    switch (buttonIndex)
    {
        case 0:  //打开照相机拍照
            [self takePhoto];
            break;
            
        case 1:  //打开本地相册
            [self LocalPhoto];
            break;
    }
}

#pragma -mark photoCustom
//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker
                           animated:YES
                         completion:^{
                             
                         }];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

//打开本地相册
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker
                       animated:YES
                     completion:^{
                         
                     }];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    //   NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    //    if ([type isEqualToString:@"public.image"])
    //    {
    //        //先把图片转成NSData
    UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    if (image == nil) {
        image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    }
    
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil)
    {
        data = UIImageJPEGRepresentation(image, 0.5);
    }
    else
    {
        data = UIImagePNGRepresentation(image);
    }
    
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    self.photoFilePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
    self.photoImageView.image = image;
    self.navigationController.navigationItem.rightBarButtonItem = nil;
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:^{
        //            UIImage *editedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        //            if (editedImage == nil) {
        //                editedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //            }
        
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES
                               completion:^{
                                   
                               }];
}

#pragma -message
#pragma mark - TableView Datasource And Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *displayCellIdentifier = @"LookForSaveTradeTableViewCell";
    
    NSUInteger row = [indexPath row];
    LookForSaveTradeTableViewCell *cell = (LookForSaveTradeTableViewCell *) [tableView dequeueReusableCellWithIdentifier:displayCellIdentifier];
    if (cell == nil) {
        cell = (LookForSaveTradeTableViewCell *)[[LookForSaveTradeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: displayCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    if (row == 0) {
        if (self.toAddressStr.length > 0) {
            cell.detailText = self.toAddressStr;
            [cell setHeadImage:@"ico_travel_down.png"];
        } else {
            cell.detailText = @"圈目的地";
            [cell setHeadImage:@"ico_travel_up.png"];
        }
    } else if (row == 1){
        if (self.friendName.length >0 ) {
            cell.detailText = self.friendName;
            [cell setHeadImage:@"ico_friend_down.png"];
        } else {
            cell.detailText = @"警告对象";
            [cell setHeadImage:@"ico_friend_up.png"];
        }
    } else {
        if (self.friendName.length >0 ) {
            cell.detailText = self.friendName;
            [cell setHeadImage:@"ico_friend_down.png"];
        } else {
            cell.detailText = @"重复周期设置";
            [cell setHeadImage:@"ico_friend_up.png"];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSUInteger row = [indexPath row];
    if (row == 0) {
        LookForSelectAddressViewController *sa = [[LookForSelectAddressViewController alloc] init];
        [self.navigationController pushViewController:sa animated:YES];

    } else {
        LookForSelectFriendViewController *sf = [[LookForSelectFriendViewController alloc] init];
        sf.delegate = self;
        [self.navigationController pushViewController:sf animated:YES];
    }
}

#pragma mark -LookForSelectFriendViewControllerDelegate
- (void)selectFriendNames:(NSString *)names {
    self.friendName = names;
    [self.messageTableView reloadData];
}

@end
