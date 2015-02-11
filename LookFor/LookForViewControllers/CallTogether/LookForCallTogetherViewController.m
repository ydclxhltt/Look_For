//
//  LookForCallTogetherViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-1-13.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "LookForCallTogetherViewController.h"
#import "LookForCallTogetherNameViewController.h"
#import "LookForSelectFriendViewController.h"
#import "LookForSaveTradeTableViewCell.h"
#import "LookForSelectAddressViewController.h"

#define TableViewH      132 + NAV_HEIGHT
#define LeftSpace       15

@interface LookForCallTogetherViewController ()<UITableViewDelegate, UITableViewDataSource,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UIActionSheetDelegate,
LookForCallTogetherNameViewControllerDelegate,
LookForSelectFriendViewControllerDelegate>

@property (nonatomic, strong) UITableView *callTogeterTableView;
@property (nonatomic, strong) UIActionSheet *photoSheet;            //照片来源选择

@property (nonatomic, strong) NSString *photoFilePath;
@property (nonatomic, strong) UIImage *photoImage;
@property (nonatomic, strong) NSString *friendNames;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *togeterName;
@end

@implementation LookForCallTogetherViewController

- (void)loadView {
    [super loadView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"召集";
    [self setNavBarItemWithTitle:@"取消"
                     navItemType:LeftItem
                    selectorName:@"handleCancel"];
    
    [self setNavBarItemWithImageName:@"camera"
                         navItemType:rightItem
                        selectorName:@"handleCamera"];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -custom
- (void)initView {
   
    self.callTogeterTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,MAIN_SCREEN_SIZE.width,TableViewH)
                                                         style:UITableViewStylePlain];
    
    self.callTogeterTableView.dataSource = self;
    self.callTogeterTableView.delegate = self;
    self.callTogeterTableView.backgroundColor = [UIColor clearColor];
    self.callTogeterTableView.separatorColor = [UIColor clearColor];
    self.callTogeterTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.callTogeterTableView.showsHorizontalScrollIndicator = NO;
    self.callTogeterTableView.showsVerticalScrollIndicator = NO;
    self.callTogeterTableView.scrollEnabled = NO;
    self.callTogeterTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.callTogeterTableView];
    
    UIButton *button = [CreateViewTool createButtonWithFrame:CGRectMake(LeftSpace, self.callTogeterTableView.frame.size.height + self.callTogeterTableView.frame.origin.y + LeftSpace, MAIN_SCREEN_SIZE.width - 2*LeftSpace, 36)
                                                 buttonTitle:@"召集"
                                                  titleColor:[UIColor whiteColor] normalBackgroundColor:nil highlightedBackgroundColor:nil
                                                selectorName:@"handleCall"
                                                 tagDelegate:self];
    button.backgroundColor = RGB(118, 203, 203);
    button.layer.cornerRadius = button.frame.size.height / 2;
    button.layer.masksToBounds = YES;

    [self.view addSubview:button];
    
}

#pragma mark -handle
- (void)handleCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleCamera {

}


- (void)handleCall {
    
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
        cell.detailText = @"召集名称";
        if (self.photoImage != nil || self.togeterName.length) {
            [cell setRightImage:self.photoImage];
            [cell setHeadImage:@"ico_friend_down.png"];
        } else {
            [cell setHeadImage:@"ico_friend_up.png"];
        }
        
        if (self.togeterName.length) {
            [cell setRightText:self.togeterName withColor:DetailColor];
            [cell setHeadImage:@"ico_friend_down.png"];

        } else {
            [cell setRightText:@"未命名" withColor:DetailColor];
            [cell setHeadImage:@"ico_friend_up.png"];
        }
        
    } else if (row == 1) {
        cell.detailText = @"选择好友";
        if (self.friendNames.length) {
            [cell setHeadImage:@"ico_friend_down.png"];
            [cell setRightText:self.friendNames withColor:DetailColor];
        } else {
            [cell setHeadImage:@"ico_friend_up.png"];
            [cell setRightText:nil withColor:DetailColor];
        }
    } else {
        cell.detailText = @"召集目的地";
        if (self.address.length) {
            [cell setRightText:self.address withColor:DetailColor];
            [cell setHeadImage:@"ico_travel_down.png"];
        } else {
            [cell setRightText:nil withColor:DetailColor];
            [cell setHeadImage:@"ico_travel_up.png"];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSUInteger row = [indexPath row];
    
    if (row == 0) {
        LookForCallTogetherNameViewController *name = [[LookForCallTogetherNameViewController alloc] init];
        name.delegate = self;
        [self.navigationController pushViewController:name animated:YES];
    } else if (row == 1) {
        LookForSelectFriendViewController *sf = [[LookForSelectFriendViewController alloc] initWithTitle:@"选择好友"];
        sf.delegate = self;
        [self.navigationController pushViewController:sf animated:YES];
    } else {
        LookForSelectAddressViewController *sa = [[LookForSelectAddressViewController alloc] init];
        [self.navigationController pushViewController:sa animated:YES];

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
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
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
        self.photoImage = image;
        if (self.photoImage != nil) {
            self.navigationController.navigationItem.rightBarButtonItem = nil;
        }
        self.navigationController.navigationItem.rightBarButtonItem = nil;
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES
                                   completion:^{
                                       [self.callTogeterTableView reloadData];
                                   }];
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES
                               completion:^{
                                   
                               }];
}

#pragma mark -LookForCallTogetherNameViewControllerDelegate
- (void)callTogetherName:(NSString *)name {
    self.togeterName = name;
    [self.callTogeterTableView reloadData];
}

#pragma mark -LookForSelectFriendViewControllerDelegate
- (void)selectFriendNames:(NSString *)names {
    self.friendNames = names;
    [self.callTogeterTableView reloadData];
}

@end
