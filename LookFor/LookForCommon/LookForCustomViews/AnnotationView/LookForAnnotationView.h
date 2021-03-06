//
//  LookForAnnotationView.h
//  IphoneMapSdkDemo
//
//  Created by chenmingguo on 15-1-5.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import "BMKPinAnnotationView.h"
#import "AAShareBubbles.h"
#import <CoreLocation/CoreLocation.h>

@class LookForAnnotationView;
@protocol LookForAnnotationViewDelegate <NSObject>

- (void)selectAnnotation:(LookForAnnotationView *)annotationView;
@end

@interface LookForAnnotationView : BMKPinAnnotationView <AAShareBubblesDelegate>

@property (nonatomic, assign) BOOL  isSelect;   //是否被选中，默认NO
@property (nonatomic, assign) id<LookForAnnotationViewDelegate>delegate;
@property (nonatomic, strong) NSArray *bubbleArray;
@property (nonatomic, assign) int tag;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

//初始化
- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier defaultImage:(UIImage *)image selectedImage:(UIImage *)selectedImage;

//初始化界面
- (void)initView;


//设置数据
- (void)setAnnotationDataWithImageUrl:(NSString *)imageUrl placeholderImage:(NSString *)placeImage  nikeName:(NSString *)name;

//默认选中
- (void)showFriendItem;

//设置初始状态
- (void)setState;
@end
