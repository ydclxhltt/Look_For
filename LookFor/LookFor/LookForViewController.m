//
//  LookForViewController.m
//  LookFor
//
//  Created by chenmingguo on 14-12-29.
//  Copyright (c) 2014年 chenmingguo. All rights reserved.
//

#import "LookForViewController.h"
#import "BMapKit.h"
@interface LookForViewController ()<BMKMapViewDelegate>
@property (nonatomic, strong) BMKMapView* mapView;
@end

@implementation LookForViewController

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_SIZE.width, MAIN_SCREEN_SIZE.height)];
    [self.view addSubview:self.mapView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

#pragma mark - BMKMapViewDelegate

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"BMKMapView控件初始化完成" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
//    [alert show];
//    alert = nil;
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: click blank");
}

- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: double click");
}

@end
