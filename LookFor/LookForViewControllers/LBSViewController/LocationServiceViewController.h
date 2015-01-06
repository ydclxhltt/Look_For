//
//  LocationServiceViewController.h
//  XSHCar
//
//  Created by clei on 14/12/22.
//  Copyright (c) 2014年 chenlei. All rights reserved.
//

#import "BasicViewController.h"
#import "BMapKit.h"

@interface LocationServiceViewController : BasicViewController

/*
 *  初始化BMKLocationService对象
 */
- (void)setLocation;

/*
 *  开始定位
 */
- (void)startLocation;

/*
 *  停止定位
 */
- (void)stopLocation;

/*
 *  添加map地图
 *
 *  @pram frame   地图尺寸
 *  @pram type    地图类型(GPS/标准/卫星等)
 *  @pram isShow  是否显示当前位置
 *  @pram level   地图比例尺级别
 */
- (void)addMapViewWithFrame:(CGRect)frame mapType:(BMKMapType)type  mapZoomLevel:(float)level   showUserLocation:(BOOL)isShow;
@end
