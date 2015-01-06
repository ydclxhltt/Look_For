//
//  LookForRouteSearchViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-1-6.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "LookForRouteSearchViewController.h"

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

@end

@implementation LookForRouteSearchViewController

- (id)initWithStart:(CLLocationCoordinate2D)start withEnd:(CLLocationCoordinate2D)end {
    self = [super init];
    if (self) {
        self.startCoordinate2D = start;
        self.endCoordinate2D = end;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_SIZE.width, MAIN_SCREEN_SIZE.height)];
    [_mapView setZoomLevel:11];
    
    [self.view addSubview:self.mapView];
}

- (void)dealloc {
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

#pragma mark -routeSearch


- (void)onGetTransitRouteResult:(BMKRouteSearch*)searcher result:(BMKTransitRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKTransitRouteLine* plan = (BMKTransitRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        int size = [plan.steps count];
        int planPointCounts = 0;
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
//        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
//        int i = 0;
//        for (int j = 0; j < size; j++) {
//            BMKTransitStep* transitStep = [plan.steps objectAtIndex:j];
//            int k=0;
//            for(k=0;k<transitStep.pointsCount;k++) {
//                temppoints[i].x = transitStep.points[k].x;
//                temppoints[i].y = transitStep.points[k].y;
//                i++;
//            }
//            
//        }
//        // 通过points构建BMKPolyline
//        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
//        [_mapView addOverlay:polyLine]; // 添加路线overlay
//        delete []temppoints;
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
        int size = [plan.steps count];
        int planPointCounts = 0;
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
//        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
//        int i = 0;
//        for (int j = 0; j < size; j++) {
//            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
//            int k=0;
//            for(k=0;k<transitStep.pointsCount;k++) {
//                temppoints[i].x = transitStep.points[k].x;
//                temppoints[i].y = transitStep.points[k].y;
//                i++;
//            }
//            
//        }
//        // 通过points构建BMKPolyline
//        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
//        [_mapView addOverlay:polyLine]; // 添加路线overlay
//        delete []temppoints;
        
        
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
        int size = [plan.steps count];
        int planPointCounts = 0;
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
//        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
//        int i = 0;
//        for (int j = 0; j < size; j++) {
//            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:j];
//            int k=0;
//            for(k=0;k<transitStep.pointsCount;k++) {
//                temppoints[i].x = transitStep.points[k].x;
//                temppoints[i].y = transitStep.points[k].y;
//                i++;
//            }
//            
//        }
//        // 通过points构建BMKPolyline
//        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
//        [_mapView addOverlay:polyLine]; // 添加路线overlay
//        delete []temppoints;
        
        
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
