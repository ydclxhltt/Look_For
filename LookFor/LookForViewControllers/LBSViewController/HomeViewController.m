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
#import "LookForLoginViewController.h"
#import "LookForFriendDetailView.h"
#import "LookForFriendView.h"
#import "LookForLeftView.h"
#import "LookForModifyUserInfoViewController.h"
#import "LookForLoginViewController.h"
#import "LookForSettingViewController.h"
#import "LookForMyMessageViewController.h"
#import "LookForApplyViewController.h"
#import "LookForMyCirleViewController.h"


@interface HomeViewController ()<BMKLocationServiceDelegate,
BMKMapViewDelegate,
BMKGeoCodeSearchDelegate,
LookForRightSlideButtonViewDelegate,
LookForAnnotationViewDelegate,
FriendDetailViewGoThereDelegate,
FriendViewDelegate,
LookForLeftViewDelegate>
{
    BMKLocationService *locationService;
    BMKMapView *_mapView;
    BMKGeoCodeSearch *geocodesearch;
    BOOL isShowFriendView;
    LookForFriendDetailView *friendDetailView;
    LookForFriendView *friendsView;
    CLLocationCoordinate2D myLocation;
    CLLocationCoordinate2D friendLocation;
    LookForLeftView *leftView;
}
@property(nonatomic, strong) NSString *lastLocation;
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
    [self getFriendList];
    //添加通知
    [self addNotifications];
 
    [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(test) userInfo:nil repeats:NO];
    // Do any additional setup after loading the view.
}

- (void)test
{
    [LookForRequestTool registerWithMobile:@"18625353675" userPassword:@"123456"];
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
    NSString *nickName = [UserDefaults objectForKey:@"nickName"];
    if (!nickName || [@"" isEqualToString:nickName])
    {
        return;
    }
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

#pragma mark 好友item按钮事件
- (void)friendsButtonPressed:(UIButton *)button
{
    if (friendDetailView)
    {
        [friendDetailView dismiss];
    }
    isShowFriendView = !isShowFriendView;
    if (isShowFriendView)
    {
        [self addFriendsView];
        //获取好友列表
        [self getFriendList];
        return;
    }
    [friendsView dismiss];
}

- (void)addFriendsView
{
    if (!friendsView)
    {
        friendsView = [[LookForFriendView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) addToView:self.view];
    }
    [friendsView show];
    friendsView.delegate = self;
    friendsView.dataArray = self.friendListObj.friendList;
}



#pragma mark 个人item按钮事件

- (void)personalButtonPressed:(UIButton *)sender
{
    if (friendDetailView)
    {
        [friendDetailView dismiss];
    }
    if (friendsView)
    {
        [friendsView dismiss];
    }
    [self addLeftView];
}

- (void)addLeftView
{
    if (!leftView)
    {
        leftView = [[LookForLeftView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [APP_DELEGATE.window addSubview:leftView];
    }
    leftView.delegate = self;
    [leftView show];
}


#pragma mark 添加通知
- (void)addNotifications
{
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(getFriendListSucess:) name:FRIEND_LIST_SUCESS object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(getFriendListFailure) name:FRIEND_LIST_FAILURE object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(getFriendDetailListSucess:) name:FRIENDDETAIL_LIST_SUCESS object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(getFriendDetailListFailure) name:FRIENDDETAIL_LIST_FAILURE object:nil];
}


#pragma mark 获取好友列表
- (void)getFriendList
{
    [LookForRequestTool getFriendListRequestWithUserID:@"001"];
}

- (void)getFriendListSucess:(NSNotification *)notification
{
    self.friendListObj = (LookFor_FriendList *)[notification object];
    [self addFriendAnnotations:self.friendListObj.friendList];
    if (isShowFriendView)
    {
        [self addFriendsView];
    }
}

- (void)getFriendListFailure
{
    
}

#pragma mark 获取好友详情

- (void)getFriendDetailListWithFriendsID:(NSString *)friendsID
{
    [LookForRequestTool getFriendDetailListRequestWithUserID:@"001" allFriendID:[friendsID stringByAppendingString:@","]];
}

- (void)getFriendDetailListSucess:(NSNotification *)notification
{
    NSArray *array = ((LookFor_FriendDetailList *)[notification object]).lbsList;
    if (array && [array count] > 0)
    {
        if (friendDetailView)
        {
            LookFor_FriendDetail *friendDetailInfo = (LookFor_FriendDetail *)array[0];
            self.lastLocation = friendDetailInfo.location;
            friendLocation = CLLocationCoordinate2DMake(friendDetailInfo.latitude, friendDetailInfo.longitude);
            friendDetailView.distance = [self getDistanceWithStartLocation:myLocation  endLocation:friendLocation];
            [friendDetailView setDetailInfo:friendDetailInfo];
        }
    }
}

- (void)getFriendDetailListFailure
{
    
}

#pragma mark 添加地图好友头像
- (void)addFriendAnnotations:(NSArray *)array
{
    [_mapView removeAnnotations:_mapView.annotations];
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
        case 3:
        {
//            LookForAssemblyViewController *ll = [[LookForAssemblyViewController alloc] init];
            LookForLoginViewController *ll = [[LookForLoginViewController alloc] init];
            
            [self.navigationController pushViewController:ll animated:YES];
            break;
        }
            
            
        default:
            break;
    }
}


#pragma mark locationManageDelegate
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"userLocation====%@",[userLocation.location description]);
    [_mapView updateLocationData:userLocation];
    myLocation = userLocation.location.coordinate;
    [_mapView setCenterCoordinate:myLocation animated:YES];
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
        //newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        NSString *seeString = (friendInfo.permission == 1) ? @"hide" : @"see";
        NSArray *array = @[seeString,@"quanta",@"gothere"];
        newAnnotationView.bubbleArray = [NSMutableArray arrayWithArray:array];
        [newAnnotationView setState];
        return newAnnotationView;
    }
    return nil;
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
    if (friendsView)
    {
        [friendsView dismiss];
    }
    [LookFor_Application shareInstance].selectedAnnonationIndex = annotationView.tag;
    [_mapView setCenterCoordinate:annotationView.coordinate animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OneAnnonationSelected" object:nil];
    [self showFriendDetailViewWithIndex:annotationView.tag];
}

- (void)showFriendDetailViewWithIndex:(int)index
{
    if (!friendDetailView)
    {
        friendDetailView = [[LookForFriendDetailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) addToView:self.view];
        friendDetailView.delegate = self;
    }
    //设置消息和距离
    LookFor_Friend *friendInfo = (LookFor_Friend *)(self.friendListObj.friendList[index]);
    self.lastLocation = friendInfo.location;
    friendLocation = CLLocationCoordinate2DMake(friendInfo.latitude, friendInfo.longitude);
    friendDetailView.distance = [self getDistanceWithStartLocation:myLocation endLocation:friendLocation];
    [friendDetailView setDetailInfo:friendInfo];
    friendDetailView.index = index;
    [friendDetailView show];
    [self getFriendDetailListWithFriendsID:friendInfo.friendId];
}

- (float)getDistanceWithStartLocation:(CLLocationCoordinate2D)start endLocation:(CLLocationCoordinate2D)end
{
    BMKMapPoint startPoint = BMKMapPointForCoordinate(start);
    BMKMapPoint endPoint = BMKMapPointForCoordinate(end);
    CLLocationDistance dictance = BMKMetersBetweenMapPoints(startPoint,endPoint);
    return dictance/1000.0;
}

#pragma mark friendViewDelegate
- (void)friendViewClickedItemIndex:(int)index
{
    [LookFor_Application shareInstance].selectedAnnonationIndex = index;
    [friendsView dismiss];
    isShowFriendView = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowFriendInfoView" object:nil];
}

- (void)friendViewDismissed
{
    
}

#pragma mark friendDetailDelegate
- (void)friendDetailViewClickedGoThereWithIndex:(int)index
{
    LookForRouteSearchViewController *routeViewController = [[LookForRouteSearchViewController alloc] initWithStart:myLocation withEnd:friendLocation withToAddress:self.lastLocation];
    [self.navigationController pushViewController:routeViewController animated:YES];
}

- (void)friendDetailViewClickedClose
{
    [friendDetailView removeFromSuperview];
    friendDetailView = nil;
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

#pragma mark -LookForLeftViewDelegate
//点击按钮
- (void)leftView:(LookForLeftView *)leftView clickedButtonIndex:(int)index {
    UIViewController *vc = nil;
    switch (index) {
        case 0:{
            vc = [[LookForMyCirleViewController alloc] init];
        }
            break;
        case 1:{
            // vc = [[LookForModifyUserInfoViewController alloc] init];
            vc = [[LookForMyMessageViewController alloc] init];
        }
            break;
        case 2:{
            vc = [[LookForSelectFriendViewController alloc] init];
        }
            break;
        case 3:{
            vc = [[LookForApplyViewController alloc] init];
        }
            break;
        case 4:{
            vc = [[LookForSettingViewController alloc] init];
        }
            break;
            
        default:
            break;
    }
    if (vc != nil) {
        [self.navigationController pushViewController:vc animated:YES];
    }
    [leftView dismiss];
}

//点击头像
- (void)leftViewClickedIconImageView {
//    LookForLoginViewController *login = [[LookForLoginViewController alloc] init];
    LookForModifyUserInfoViewController *vc = [[LookForModifyUserInfoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [leftView dismiss];
}


@end
