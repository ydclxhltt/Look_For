//
//  LookForRouteSearchViewController.m
//  LookFor
//
//  Created by chenmingguo on 15-1-6.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "LookForRouteSearchViewController.h"
#import "BMapKit.h"

@interface LookForRouteSearchViewController () <BMKMapViewDelegate, BMKRouteSearchDelegate>
@property (nonatomic, strong) BMKMapView* mapView;
@property (nonatomic, strong) BMKRouteSearch* routesearch;


@end

@implementation LookForRouteSearchViewController

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
