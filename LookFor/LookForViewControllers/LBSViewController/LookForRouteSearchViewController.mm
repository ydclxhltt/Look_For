//
//  LookForRouteSearchViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-1-6.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "LookForRouteSearchViewController.h"
#import "UIImage+Rotate.h"
#import "RTLabel.h"

#define HeadHeight      80
#define LeftSpace       15
#define topSpace        30

#define FooterHeight    50

#define BackWH          40
#define DefaultSpace    10

#define LabelW          20
#define LabelH          12
#define AddressLabelW   120

typedef enum {
    Walk_type = 0,
    Drive_type,
    Bud_type
}RouteType;

@interface RouteAnnotation : BMKPointAnnotation
{
    int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
    int _degree;
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end


@interface LookForRouteSearchViewController () <BMKMapViewDelegate, BMKRouteSearchDelegate>
@property (nonatomic, strong) BMKMapView* mapView;
@property (nonatomic, strong) BMKRouteSearch* routesearch;
@property (nonatomic, assign) CLLocationCoordinate2D startCoordinate2D;     //起点坐标
@property (nonatomic, assign) CLLocationCoordinate2D endCoordinate2D;       //终点坐标
@property (nonatomic, strong) NSString *toAddress;                          //要去的位置
@property (nonatomic, strong) RTLabel  *mileageLabel;                       //里程
@property (nonatomic, strong) UIView   *footerView;

@end

@implementation LookForRouteSearchViewController

- (id)initWithStart:(CLLocationCoordinate2D)start withEnd:(CLLocationCoordinate2D)end withToAddress:(NSString *)address{
    self = [super init];
    if (self) {
        self.startCoordinate2D = start;
        self.endCoordinate2D = end;
        self.toAddress = address;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_SIZE.width, MAIN_SCREEN_SIZE.height)];
    [_mapView setZoomLevel:14];
    _routesearch = [[BMKRouteSearch alloc]init];

    [self.view addSubview:self.mapView];
    
    [self handleWalkSearch];
    [self createHeadView];
    [self createFooterView];
}

- (void)dealloc {
    if (_routesearch != nil) {
        _routesearch = nil;
    }
    if (_mapView) {
        _mapView = nil;
    }
}


-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _routesearch.delegate = self;
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _routesearch.delegate = nil;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -handle
-(void)handleBusSearch {
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.pt = self.startCoordinate2D;
    
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    end.pt = self.endCoordinate2D;
    
    BMKTransitRoutePlanOption *transitRouteSearchOption = [[BMKTransitRoutePlanOption alloc]init];
  //  transitRouteSearchOption.city= @"北京市";
    transitRouteSearchOption.from = start;
    transitRouteSearchOption.to = end;
    BOOL flag = [_routesearch transitSearch:transitRouteSearchOption];
    
    if(flag)
    {
        NSLog(@"bus检索发送成功");
    }
    else
    {
        NSLog(@"bus检索发送失败");
    }

}

-(void)handleDriveSearch {
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.pt = self.startCoordinate2D;
    
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    end.pt = self.endCoordinate2D;
    
    BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc]init];
    drivingRouteSearchOption.from = start;
    drivingRouteSearchOption.to = end;
    BOOL flag = [_routesearch drivingSearch:drivingRouteSearchOption];
    if(flag)
    {
        NSLog(@"car检索发送成功");
    }
    else
    {
        NSLog(@"car检索发送失败");
    }
}

-(void)handleWalkSearch {
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.pt = self.startCoordinate2D;
    
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    end.pt = self.endCoordinate2D;
    
    BMKWalkingRoutePlanOption *walkingRouteSearchOption = [[BMKWalkingRoutePlanOption alloc]init];
    walkingRouteSearchOption.from = start;
    walkingRouteSearchOption.to = end;
    BOOL flag = [_routesearch walkingSearch:walkingRouteSearchOption];
    if(flag)
    {
        NSLog(@"walk检索发送成功");
    }
    else
    {
        NSLog(@"walk检索发送失败");
    }

}

- (void)handleBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleCloseFooterView:(id)sender {
    [self hiddenFooterView];
}

#pragma mark -custom
//创建头部导航
- (UIView *)createHeadView {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_SIZE.width, HeadHeight)];
    view.backgroundColor = [UIColor clearColor];
    UIView *bgView  =[[UIView alloc] initWithFrame:view.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.alpha = 0.9;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:bgView.bounds];
    
    bgView.layer.masksToBounds = NO;
    
    bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    bgView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    
    bgView.layer.shadowOpacity = 0.5f;
    
    bgView.layer.shadowPath = shadowPath.CGPath;
    [view addSubview:bgView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(LeftSpace, topSpace, BackWH, BackWH);
    [backButton setImage:[UIImage imageNamed:@"poi_1.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(handleBack:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backButton];
    
    UILabel *fromLabel = [[UILabel alloc] initWithFrame:CGRectMake(backButton.frame.size.width + backButton.frame.origin.x + LeftSpace, topSpace, LabelW, LabelH)];
    fromLabel.textAlignment = NSTextAlignmentCenter;
    fromLabel.textColor = [UIColor lightGrayColor];
    fromLabel.font = [UIFont systemFontOfSize:10];
    fromLabel.text = @"从";
    [view addSubview:fromLabel];
    
    UILabel *toLabel = [[UILabel alloc] initWithFrame:CGRectMake(backButton.frame.size.width + backButton.frame.origin.x + LeftSpace, topSpace + LabelH + DefaultSpace, LabelW, LabelH)];
    toLabel.textAlignment = NSTextAlignmentCenter;
    toLabel.textColor = [UIColor lightGrayColor];
    toLabel.font = [UIFont systemFontOfSize:10];
    toLabel.text = @"到";
    [view addSubview:toLabel];
    
    float labelW = MAIN_SCREEN_SIZE.width - (BackWH * 2 + LeftSpace * 3) - (fromLabel.frame.size.width + fromLabel.frame.origin.x);
    
    UILabel *fromAddress = [[UILabel alloc] initWithFrame:CGRectMake(fromLabel.frame.size.width + fromLabel.frame.origin.x , topSpace, labelW, LabelH)];
    fromAddress.textAlignment = NSTextAlignmentLeft;
    fromAddress.textColor = [UIColor blackColor];
    fromAddress.font = [UIFont systemFontOfSize:12];
    fromAddress.text = @"我的位置";
    [view addSubview:fromAddress];
    
    UILabel *toAddress = [[UILabel alloc] initWithFrame:CGRectMake(fromLabel.frame.size.width + fromLabel.frame.origin.x, topSpace + LabelH + DefaultSpace, labelW, LabelH)];
    toAddress.textAlignment = NSTextAlignmentLeft;
    toAddress.textColor = [UIColor blackColor];
    toAddress.font = [UIFont systemFontOfSize:12];
    toAddress.text = self.toAddress;
    [view addSubview:toAddress];
    
    UIButton *walkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    walkButton.frame = CGRectMake(toAddress.frame.size.width + toAddress.frame.origin.x + LeftSpace, topSpace, BackWH, BackWH);
    [walkButton setImage:[UIImage imageNamed:@"poi_1.png"] forState:UIControlStateNormal];
    [walkButton addTarget:self action:@selector(handleWalkSearch) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:walkButton];
    
    UIButton *driveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    driveButton.frame = CGRectMake(walkButton.frame.size.width + walkButton.frame.origin.x + LeftSpace, topSpace, BackWH, BackWH);
    [driveButton setImage:[UIImage imageNamed:@"poi_1.png"] forState:UIControlStateNormal];
    [driveButton addTarget:self action:@selector(handleDriveSearch) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:driveButton];
    
    [self.view addSubview:view];
    [self.view bringSubviewToFront:view];
    return view;
}

- (void)createFooterView {
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - FooterHeight, MAIN_SCREEN_SIZE.width, FooterHeight)];
    self.footerView.backgroundColor = [UIColor clearColor];
    UIView *bgView  =[[UIView alloc] initWithFrame:self.footerView.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
   // bgView.alpha = 0.9;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:bgView.bounds];
    
    bgView.layer.masksToBounds = NO;
    
    bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    bgView.layer.shadowOffset = CGSizeMake(0.0f, -5.0f);
    
    bgView.layer.shadowOpacity = 0.5f;
    
    bgView.layer.shadowPath = shadowPath.CGPath;
    [self.footerView addSubview:bgView];
    [self.view addSubview:self.footerView];
    
    self.mileageLabel = [[RTLabel alloc] initWithFrame: CGRectMake(10,10,200,40)]; //CGRectMake(LeftSpace, (FooterHeight - LabelH) / 2, MAIN_SCREEN_SIZE.width - 2*LeftSpace, LabelH)];
    [self.mileageLabel setTextAlignment:RTTextAlignmentLeft];
    self.mileageLabel.font = [UIFont systemFontOfSize:13];
    [self.mileageLabel setParagraphReplacement:@""];
//
   self.mileageLabel.backgroundColor = [UIColor clearColor];
    [self.footerView addSubview:self.mileageLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(MAIN_SCREEN_SIZE.width - LeftSpace - BackWH, 0, BackWH, BackWH);
    [button setImage:[UIImage imageNamed:@"poi_1.png"] forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(handleCloseFooterView:)
     forControlEvents:UIControlEventTouchUpInside];
    
    [self.footerView addSubview:button];
}

- (void)setFooterText:(NSInteger)mile withMin:(BMKTime*)time withType:(RouteType)type{
    NSString *message = nil;
    if (type == Walk_type) {
        message = [NSString stringWithFormat:@"<p><font size=13>步行<font color=red>%ld</font>米   约%@</font></p>",mile,[self getTime:time]];
    } else if (type == Drive_type) {
        message = [NSString stringWithFormat:@"<p><font>步行</font><font color=red>%ld</font><font>米</font>   <font>约</font><font color=red>%@</font></p>",mile,[self getTime:time]];

    } else {
        message = [NSString stringWithFormat:@"<p><font>步行</font><font color=red>%ld</font><font>米</font>   <font>约</font><font color=red>%@</font></p>",mile,[self getTime:time]];
    }
    self.mileageLabel.text = message;
}

- (NSString *)getTime:(BMKTime *)time {
    if (time == nil) {
        return nil;
    }
    NSString *timeMessage = nil;
    if (time.hours > 0) {
        timeMessage = [NSString stringWithFormat:@"<font color=red>%d</font>小时 <font color=red>%d</font>分钟",time.hours,time.minutes];
    } else {
      timeMessage = [NSString stringWithFormat:@"<font color=red>%d</font>分钟",time.minutes];
    }
    return timeMessage;
}

- (void)hiddenFooterView {
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.footerView.frame = CGRectMake(0,
                                                            MAIN_SCREEN_SIZE.height,
                                                            self.footerView.frame.size.width,
                                                            self.footerView.frame.size.height);
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (NSString*)getMyBundlePath1:(NSString *)filename
{
    
    NSBundle * libBundle =  MYBUNDLE ;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        return s;
    }
    return nil ;
}

- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
    BMKAnnotationView* view = nil;
    switch (routeAnnotation.type) {
        case 0:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 1:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 2:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 3:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 4:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"];
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.annotation = routeAnnotation;
            
        }
            break;
        case 5:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"waypoint_node"];
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_waypoint.png"]];
            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.annotation = routeAnnotation;
        }
            break;
        default:
            break;
    }
    
    return view;
}


#pragma mark -BMKRouteSearchDelegate
- (void)onGetTransitRouteResult:(BMKRouteSearch*)searcher result:(BMKTransitRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKTransitRouteLine* plan = (BMKTransitRouteLine*)[result.routes objectAtIndex:0];
        [self setFooterText:plan.distance withMin:plan.duration withType:Bud_type];

        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
        NSInteger planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKTransitStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.instruction;
            item.type = 3;
            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKTransitStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
    }
    
}
- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        [self setFooterText:plan.distance withMin:plan.duration withType:Drive_type];
        NSInteger size = [plan.steps count];
        NSInteger planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        // 添加途经点
        if (plan.wayPoints) {
            for (BMKPlanNode* tempNode in plan.wayPoints) {
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item = [[RouteAnnotation alloc]init];
                item.coordinate = tempNode.pt;
                item.type = 5;
                item.title = tempNode.name;
                [_mapView addAnnotation:item];
            }
        }
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        
        
    }
}

- (void)onGetWalkingRouteResult:(BMKRouteSearch*)searcher result:(BMKWalkingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKWalkingRouteLine* plan = (BMKWalkingRouteLine*)[result.routes objectAtIndex:0];
        [self setFooterText:plan.distance withMin:plan.duration withType:Walk_type];

        NSInteger size = [plan.steps count];
        NSInteger planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
    }
    
}

#pragma mark -BMKMapViewDelegate

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        return [self getRouteAnnotationView:view viewForAnnotation:(RouteAnnotation*)annotation];
    }
    return nil;
}

/**
 *根据overlay生成对应的View
 *@param mapView 地图View
 *@param overlay 指定的overlay
 *@return 生成的覆盖物View
 */
- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 5.0;
        return polylineView;
    }
    return nil;
}

@end
