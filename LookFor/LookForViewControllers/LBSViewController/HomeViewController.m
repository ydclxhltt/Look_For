//
//  LocationServiceViewController.m
//  XSHCar
//
//  Created by clei on 14/12/22.
//  Copyright (c) 2014年 chenlei. All rights reserved.
//


#import "HomeViewController.h"
#import "LookForRightSlideButtonView.h"
#import "LookForRouteSearchViewController.h"
#import "LookForSafeTravelViewController.h"
#import "LookForSelectFriendViewController.h"
#import "LookForCallTogetherViewController.h"


@interface HomeViewController ()<BMKLocationServiceDelegate,
BMKMapViewDelegate,
BMKGeoCodeSearchDelegate,
LookForRightSlideButtonViewDelegate>
{
    BMKLocationService *locationService;
    BMKMapView *mapView;
    BMKGeoCodeSearch *geocodesearch;
}
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加返回item
    [self addBackItem];
    //获取当前位置
    [self getLocation];
    //获取好友列表
    [LookForRequestTool getFriendListRequestWithUserID:@"001"];
    
    NSArray *imageArray = @[@"menu_travel",@"menu_friends",@"menu_group",@"menu_location"];
    UIImage *image = [UIImage imageNamed:@"menu_down.png"];
    float space_y = 100.0 * scale;
    float space_x = 10.0 * scale;
    LookForRightSlideButtonView *slideButtonView = [[LookForRightSlideButtonView alloc] initViewWithFrame:CGRectMake(space_x, SCREEN_HEIGHT - space_y, image.size.width/2 * scale, image.size.height/2 * scale) withInView:self.view withStartImage:@"menu" withImageArray:imageArray withTitleArray:nil delegate:self];
    NSLog(@"slideButtonView===%@",slideButtonView);
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
    if (mapView)
        mapView.delegate = delegate;
    if (geocodesearch)
        geocodesearch.delegate = delegate;
}

#pragma mark 获取当前位置
- (void)getLocation
{
   [self setLocation];
   [self addMapViewWithFrame:CGRectMake(0, 0, MAIN_SCREEN_SIZE.width, MAIN_SCREEN_SIZE.height) mapType:BMKMapTypeStandard mapZoomLevel:16.0 showUserLocation:YES];
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
    mapView = [[BMKMapView alloc] initWithFrame:frame];
    mapView.delegate = self;
    mapView.mapType = type;
    mapView.zoomLevel = level;
    mapView.showsUserLocation = isShow;
    [self.view addSubview:mapView];
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
            LookForCallTogetherViewController *ct = [[LookForCallTogetherViewController alloc] init];
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
    [mapView updateLocationData:userLocation];
    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    [self getReverseGeocodeWithLocation:userLocation.location.coordinate];
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
    BMKAnnotationView *annotationView;
    return annotationView;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    if (mapView)
    {
        mapView = nil;
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
