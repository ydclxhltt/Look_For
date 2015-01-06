//
//  LookForRouteSearchViewController.h
//  LookFor
//
//  Created by chenmingguo on 15-1-6.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#import "BasicViewController.h"
#import "BMapKit.h"

@interface LookForRouteSearchViewController : BasicViewController

- (id)initWithStart:(CLLocationCoordinate2D)start withEnd:(CLLocationCoordinate2D)end;
@end
