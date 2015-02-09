//
//  LookForModifyUserInfoViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-1-22.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForModifyUserInfoViewController.h"
#import "LookForModifyUserTableViewCell.h"
#import "LookForNickNameViewController.h"
#import "LookForVerifiedCodeViewController.h"
#import "LookForRegisterViewController.h"

#define HeadImageWH         60
#define Default             10
#define LeftSpace           15
#define HeadViewWH          120

#define IconImageWH         30

@interface LookForModifyUserInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
LookForNickNameViewControllerDelegate>

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UIActionSheet *photoSheet;            //照片来源选择
@property (nonatomic, strong) NSString *photoFilePath;

@property (nonatomic, strong) NSString *nickName;
@end

@implementation LookForModifyUserInfoViewController

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadView {
    [super loadView];
    [self initView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改资料";
    
    [self setNavBarItemWithTitle:@"保存"
                     navItemType:rightItem
                    selectorName:@"handleSure"];
    
    [self setNavBarItemWithTitle:@"取消"
                     navItemType:LeftItem
                    selectorName:@"handleCancel"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -custom
- (void)initView {
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT , MAIN_SCREEN_SIZE.width, HeadViewWH)];
    self.headView.backgroundColor = [UIColor clearColor];
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake((MAIN_SCREEN_SIZE.width - HeadImageWH) / 2 , (HeadViewWH - HeadImageWH) / 2, HeadImageWH, HeadImageWH)];
    self.headImageView.backgroundColor = [UIColor clearColor];
    self.headImageView.layer.cornerRadius = HeadImageWH / 2;
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.image = [UIImage imageNamed:@"1.jpg"];
    [self.headView addSubview:self.headImageView];
    
    UIButton *headButton = [UIButton buttonWithType:UIButtonTypeCustom];
    headButton.backgroundColor = [UIColor clearColor];
    headButton.frame = self.headImageView.frame;//CGRectMake(0, 0, self.headImageView.bounds.size.width, self.headImageView.bounds.size.height);
    [headButton addTarget:self
                   action:@selector(handleHeadView)
         forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:headButton];
    
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.headImageView.frame.origin.x + self.headImageView.bounds.size.width - IconImageWH + 10 ,self.headImageView.frame.origin.y + self.headImageView.bounds.size.height - IconImageWH , IconImageWH, IconImageWH)];
    iconImage.backgroundColor = [UIColor clearColor];
    UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    photoButton.frame = iconImage.frame;
    [photoButton setImage:[UIImage imageNamed:@"photo_up.png"] forState:UIControlStateNormal];
    [photoButton setImage:[UIImage imageNamed:@"photo_down.png"] forState:UIControlStateSelected | UIControlStateHighlighted];
    [photoButton addTarget:self
                   action:@selector(handleHeadView)
         forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:photoButton];
    [self.headView addSubview:iconImage];
    
    [self.view addSubview:self.headView];
 
    [self addTableViewWithFrame:CGRectMake(0, self.headView.frame.origin.y + HeadViewWH, MAIN_SCREEN_SIZE.width, MAIN_SCREEN_SIZE.height)
                                   tableType:UITableViewStylePlain
                               tableDelegate:self];
    self.table.separatorColor = [UIColor clearColor];
    self.table.scrollEnabled = NO;
}


#pragma mark - handle
- (void)handleSure {

}

- (void)handleCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleHeadView {
    self.photoSheet = [[UIActionSheet alloc]
                       initWithTitle:nil
                       delegate:self
                       cancelButtonTitle:@"取消"
                       destructiveButtonTitle:nil
                       otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    
    [self.photoSheet showInView:self.view];
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
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *displayCellIdentifier = @"LookForSaveTradeTableViewCell";
    
    NSUInteger row = [indexPath row];
    LookForModifyUserTableViewCell *cell = (LookForModifyUserTableViewCell *) [tableView dequeueReusableCellWithIdentifier:displayCellIdentifier];
    if (cell == nil) {
        cell = (LookForModifyUserTableViewCell *)[[LookForModifyUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: displayCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    switch (row) {
        case 0:{
            cell.titleText = @"姓名";
            [cell setSexText:nil withImageView:nil];
            cell.detailText = self.nickName;
        }
            break;
        case 1:{
            cell.titleText = @"性别";
            [cell setSexText:@"女" withImageView:@"left_ico_female.png"];
        }
            break;
        case 2:{
            cell.titleText = @"手机号";
            [cell setSexText:nil withImageView:nil];

        }
            break;
        case 3:{
            cell.titleText = @"修改密码";
            [cell setSexText:nil withImageView:nil];

        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = nil;
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSUInteger row = [indexPath row];
    switch (row) {
        case 0: {
            vc = [[LookForNickNameViewController alloc] init];
            ((LookForNickNameViewController*)vc).delegate = self;
        }
            break;
        case 1: {
            
        }
            break;
        case 2: {
            vc = [[LookForVerifiedCodeViewController alloc] initWithType:ModifyPassWordType withIsNewPhone:NO];
            
        }
            break;
            
        case 3: {
            vc = [[LookForVerifiedCodeViewController alloc] initWithType:ModifyPhoneType withIsNewPhone:NO];
        }
            break;
            
        default:
            break;
    }
    if (vc != nil) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -LookForNickNameViewControllerDelegate
- (void)nickNameVC:(LookForNickNameViewController *)nickNameVc withNickName:(NSString *)nickName{
    self.nickName = nickName;
    [self.table reloadData];
}

@end
