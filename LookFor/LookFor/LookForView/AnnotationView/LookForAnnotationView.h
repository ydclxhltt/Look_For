//
//  LookForAnnotationView.h
//  IphoneMapSdkDemo
//
//  Created by chenmingguo on 15-1-5.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import "BMKPinAnnotationView.h"
#import "AAShareBubbles.h"

@class LookForAnnotationView;
@protocol LookForAnnotationViewDelegate <NSObject>

- (void)selectAnnotation:(LookForAnnotationView *)annotationView;
@end

@interface LookForAnnotationView : BMKPinAnnotationView <AAShareBubblesDelegate>

//图片
@property (nonatomic, strong) UIImageView *annotationImageView;
@property (nonatomic, strong) UILabel *titleLabel;  //标题
@property (nonatomic, strong) AAShareBubbles *shareBubbles;

@property (nonatomic, assign) BOOL  isSelect;   //是否被选中，默认NO
@property (nonatomic, assign) id<LookForAnnotationViewDelegate>delegate;

//初始化界面
- (void)initView;

//隐藏周边按钮
- (void)hiddenShareBubbles;
@end
