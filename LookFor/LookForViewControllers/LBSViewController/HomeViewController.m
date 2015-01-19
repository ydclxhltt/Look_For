//
//  LocationServiceViewController.m
//  XSHCar
//
//  Created by clei on 14/12/22.
//  Copyright (c) 2014年 chenlei. All rights reserved.
//

#define FRIENDS_VIEW_HEIGHT     100.0
#define FRIENDS_VIEW_SPACE_XY   15.0
#define FRIEND_VIEW_ITEM_WIDTH  55.0
#define FRIEND_VIEW_LABEL_WIDTH 20.0


#import "HomeViewController.h"
#import "LookForRightSlideButtonView.h"
#import "LookForRouteSearchViewController.h"
#import "LookForSafeTravelViewController.h"
#import "LookForSelectFriendViewController.h"
#import "LookForAnnotationView.h"
#import "LookForAssemblyViewController.h"

@interface HomeViewController ()<BMKLocationServiceDelegate,
BMKMapViewDelegate,
BMKGeoCodeSearchDelegate,
LookForRightSlideButtonViewDelegate,
LookForAnnotationViewDelegate>
{
    BMKLocationService *locationService;
    BMKMapView *_mapView;
    BMKGeoCodeSearch *geocodesearch;
    UIImageView *friendsView;
    BOOL isShowFriendView;
}
@property(nonatomic, strong) LookFor_FriendList *friendListObj;
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"LookFor";
    //初始化数据
    isShowFriendView = NO;
    //添加返回item
    [self addPersonalItem];
    //添加联系人item
    [self addFriendItem];
    //初始化UI
    [self initView];
    //获取当前位置
    [self getLocation];
    //获取好友列表
    [LookForRequestTool getFriendListRequestWithUserID:@"001"];
    //获取好友详情列表
    [LookForRequestTool getFriendListRequestWithUserID:@"001" allFriendID:@"002,"];
    //添加通知
    [self addNotifications];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self setAboutLocationDelegate:self];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setAboutLocationDelegate:nil];
    
}

#pragma mark 设置定位/地图代理
- (void)setAboutLocationDelegate:(id)delegate
{
    if (locationService)
        locationService.delegate = delegate;
    if (_mapView)
        _mapView.delegate = delegate;
    if (geocodesearch)
        geocodesearch.delegate = delegate;
}


#pragma mark 初始化UI
- (void)initView
{
    [self addMapView];
    [self addSideView];
    
}

- (void)addSideView
{
    NSArray *imageArray = @[@"menu_travel",@"menu_friends",@"menu_group",@"menu_location"];
    UIImage *image = [UIImage imageNamed:@"menu_down.png"];
    float space_y = 100.0 * scale;
    float space_x = 10.0 * scale;
    LookForRightSlideButtonView *slideButtonView = [[LookForRightSlideButtonView alloc] initViewWithFrame:CGRectMake(space_x, SCREEN_HEIGHT - space_y, image.size.width/2 * scale, image.size.height/2 * scale) withInView:self.view withStartImage:@"menu" withImageArray:imageArray withTitleArray:nil delegate:self];
    NSLog(@"slideButtonView===%@",slideButtonView);
    
    float space_add_y = 10.0 * scale;
    
    UIButton *locationButton = [CreateViewTool createButtonWithFrame:CGRectMake(space_x, slideButtonView.frame.origin.y - space_add_y - image.size.height/2, image.size.width/2, image.size.height/2) buttonImage:@"recovery" selectorName:@"startLocation" tagDelegate:self];
    [self.view addSubview:locationButton];
    
}

- (void)addMapView
{
    [self addMapViewWithFrame:CGRectMake(0, 0, MAIN_SCREEN_SIZE.width, MAIN_SCREEN_SIZE.height) mapType:BMKMapTypeStandard mapZoomLevel:16.0 showUserLocation:YES];
}

- (void)addFriendsView
{
    if (!friendsView)
    {
        friendsView = [CreateViewTool createImageViewWithFrame:CGRectMake(0, - (NAV_HEIGHT + FRIENDS_VIEW_HEIGHT) , SCREEN_WIDTH, NAV_HEIGHT + FRIENDS_VIEW_HEIGHT) placeholderImage:nil];
        friendsView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.8];
        [CreateViewTool setViewShadow:friendsView withShadowColor:[[UIColor blackColor] colorWithAlphaComponent:.5] shadowOffset:CGSizeMake(0, 15.0) shadowOpacity:.5];
        [self.view addSubview:friendsView];
    }
    else
    {
        if (self.friendListObj.friendList && [self.friendListObj.friendList count] > 0)
        {
            [self addFriendItemView];
        }
        else if ([self.friendListObj.friendList count] == 0)
        {
            //无好友
        }
    }
}

- (void)addFriendItemView
{
    int count = [self.friendListObj.friendList count];
    for (UIView *view in friendsView.subviews)
    {
        if ([view isKindOfClass:[UIScrollView class]])
        {
            [view removeFromSuperview];
        }
    }
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, FRIENDS_VIEW_HEIGHT)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(FRIENDS_VIEW_SPACE_XY * (count + 1) + FRIEND_VIEW_ITEM_WIDTH * count,scrollView.frame.size.height);
    [friendsView addSubview:scrollView];
    for (int i = 0; i < count; i ++)
    {
        LookFor_Friend *friendInfo = self.friendListObj.friendList[i];
        UIImage *image = [UIImage imageNamed:@"1.jpg"];
        UIImageView *friendItemView = [CreateViewTool createRoundImageViewWithFrame:CGRectMake(FRIENDS_VIEW_SPACE_XY + i * (FRIENDS_VIEW_SPACE_XY + FRIEND_VIEW_ITEM_WIDTH), FRIENDS_VIEW_SPACE_XY, FRIEND_VIEW_ITEM_WIDTH, FRIEND_VIEW_ITEM_WIDTH) placeholderImage:image borderColor:nil imageUrl:friendInfo.portrait];
        [friendItemView setImageWithURL:[NSURL URLWithString:friendInfo.portrait] placeholderImage:image];
        friendItemView.tag = i;
        [scrollView addSubview:friendItemView];
        NSString *userName = friendInfo.commentName;
        userName = (!userName || [@"" isEqualToString:userName]) ? friendInfo.nickName : userName;
        UILabel * nameLabel = [CreateViewTool createLabelWithFrame:CGRectMake(friendItemView.frame.origin.x, scrollView.frame.size.height - FRIEND_VIEW_LABEL_WIDTH - 3.0, friendItemView.frame.size.width, FRIEND_VIEW_LABEL_WIDTH) textString:userName textColor:[UIColor blackColor] textFont:FONT(12.0)];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [scrollView addSubview:nameLabel];
    }
}

- (void)friendsButtonPressed:(UIButton *)button
{
    isShowFriendView = !isShowFriendView;
    if (isShowFriendView)
    {
        [self addFriendsView];
        //获取好友列表
        [LookForRequestTool getFriendListRequestWithUserID:@"001"];
    }
    [self isShowFriendView:isShowFriendView];
}

#pragma mark item按钮事件

- (void)personalButtonPressed:(UIButton *)sender
{
    
}


- (void)isShowFriendView:(BOOL)isShow
{
    float move_y = 0.0;
    move_y = (isShow) ? friendsView.frame.size.height : - friendsView.frame.size.height;
    
    float alpha = 1.0;
    alpha = (isShow) ? alpha : 0.0;
    
    [UIView animateWithDuration:.5 animations:^
     {
         friendsView.transform = CGAffineTransformMakeTranslation(0, move_y);
         friendsView.alpha = alpha;
     }];
}


#pragma mark 添加通知
- (void)addNotifications
{
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(getFriendListSucess:) name:FRIEND_LIST_SUCESS object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(getFriendListFailure) name:FRIEND_LIST_FAILURE object:nil];
}


#pragma mark 获取好友列表成功
- (void)getFriendListSucess:(NSNotification *)notification
{
    self.friendListObj = (LookFor_FriendList *)[notification object];
    [self addFriendAnnotations:self.friendListObj.friendList];
    [self addFriendsView];
}

#pragma mark 获取好友列表失败
- (void)getFriendListFailure
{
    
}

#pragma mark 添加好友头像
- (void)addFriendAnnotations:(NSArray *)array
{
    for (LookFor_Friend *friendObj in array)
    {
        int index = [array indexOfObject:friendObj];
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(friendObj.latitude, friendObj.longitude);
        NSDictionary *baidudic = BMKConvertBaiduCoorFrom(coordinate, BMK_COORDTYPE_GPS);
        coordinate =  BMKCoorDictionaryDecode(baidudic);
        [self addAnnotationWithLocation:coordinate annotationTitle:[NSString stringWithFormat:@"%d",index]];
    }
}

- (void)addAnnotationWithLocation:(CLLocationCoordinate2D)coordinate  annotationTitle:(NSString *)title
{
    BMKPointAnnotation *point = [[BMKPointAnnotation alloc]init];
    point.title = title;
    [point setCoordinate:coordinate];
    [_mapView addAnnotation:point];
}


#pragma mark 获取当前位置
- (void)getLocation
{
   [self setLocation];
   [self startLocation];
}

#pragma mark  定位相关
- (void)setLocation
{
    locationService = [[BMKLocationService alloc]init];
    //定位的最小更新距离
    [BMKLocationService setLocationDistanceFilter:kCLDistanceFilterNone];
    //定位精确度
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyBest];
}

- (void)startLocation
{
    locationService.delegate = self;
    [locationService startUserLocationService];
}


- (void)stopLocation
{
    locationService.delegate = nil;
    [locationService stopUserLocationService];
    
}

#pragma mark 地图相关

- (void)addMapViewWithFrame:(CGRect)frame mapType:(BMKMapType)type  mapZoomLevel:(float)level   showUserLocation:(BOOL)isShow
{
    _mapView = [[BMKMapView alloc] initWithFrame:frame];
    _mapView.delegate = self;
    _mapView.mapType = type;
    _mapView.zoomLevel = level;
    _mapView.showsUserLocation = isShow;
    [self.view addSubview:_mapView];
}

#pragma mark 编译地址
- (void)getReverseGeocodeWithLocation:(CLLocationCoordinate2D)locaotion
{
    if (!geocodesearch)
    {
        geocodesearch = [[BMKGeoCodeSearch alloc] init];
        geocodesearch.delegate = self;
    }
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = locaotion;
    BOOL flag = [geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}


#pragma mark -LookForRightSlideButtonViewDelegate
- (void)selectButton:(LookForRightSlideButtonView *)shareBubbles buttonTag:(NSInteger)tag
{
    switch (tag) {
        case 0: {
            CLLocationCoordinate2D star1;
            star1.latitude = 40.056885;
            star1.longitude = 116.308150;
            CLLocationCoordinate2D end1;
            end1.latitude = 39.912094;
            end1.longitude = 116.403936;
            LookForRouteSearchViewController *route = [[LookForRouteSearchViewController alloc] initWithStart:star1 withEnd:end1 withToAddress:@"天安门"];
            [self.navigationController pushViewController:route animated:YES];

            break;
        }
        case 1: {
            LookForSafeTravelViewController *st = [[LookForSafeTravelViewController alloc] init];
            
            [self.navigationController pushViewController:st animated:YES];
            
            break;
        }
        case 2:{
            LookForSelectFriendViewController *sf = [[LookForSelectFriendViewController alloc] init];
            [self.navigationController pushViewController:sf animated:YES];
            break;
        }
        case 3:{
            LookForAssemblyViewController *ct = [[LookForAssemblyViewController alloc] init];
            [self.navigationController pushViewController:ct animated:YES];
            break;
        }
            
            
        default:
            break;
    }
}


#pragma mark locationManageDelegate
/**
 *在将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser
{
    
}

/**
 *在停止定位后，会调用此函数
 */
- (void)didStopLocatingUser
{
    
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"userLocation====%@",[userLocation.location description]);
    [_mapView updateLocationData:userLocation];
    [_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    //[self getReverseGeocodeWithLocation:userLocation.location.coordinate];
    [self stopLocation];
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    
}


#pragma mark MapViewDelegate
/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        UIImage *norImage = [UIImage imageNamed:@"icon_user.png"];
        UIImage *selImage = [UIImage imageNamed:@"icon_user_selected.png"];
        LookForAnnotationView *newAnnotationView = [[LookForAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation" defaultImage:norImage selectedImage:selImage];
        newAnnotationView.delegate = self;
        newAnnotationView.tag = [annotation.title intValue];
        newAnnotationView.coordinate = annotation.coordinate;
        LookFor_Friend *friendInfo = [self.friendListObj.friendList objectAtIndex:newAnnotationView.tag];
        NSString *userName = friendInfo.commentName;
        userName = (!userName || [@"" isEqualToString:userName]) ? friendInfo.nickName : userName;
        [newAnnotationView setAnnotationDataWithImageUrl:friendInfo.portrait placeholderImage:@"1.jpg" nikeName:userName];
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

/**
 *当mapView新添加annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 新添加的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    
}

/**
 *当选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    
}

/**
 *当取消选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 取消选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    
}


#pragma mark 坐标转换地址Delegate
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"" message:result.address delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [myAlertView show];
}


#pragma  mark LookForAnnotationViewDelegate

- (void)selectAnnotation:(LookForAnnotationView *)annotationView
{
    [LookFor_Application shareInstance].selectedAnnonationIndex = annotationView.tag;
    [_mapView setCenterCoordinate:annotationView.coordinate animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OneAnnonationSelected" object:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    if (_mapView)
    {
        _mapView = nil;
    }
    if (locationService)
    {
        [self stopLocation];
        locationService = nil;
    }
    if (geocodesearch)
    {
        geocodesearch = nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
