//
//  LookForRightSlideButtonView.h
//  IphoneMapSdkDemo
//
//  Created by chenmingguo on 15-1-6.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LookForRightSlideButtonView;

@protocol LookForRightSlideButtonViewDelegate <NSObject>

//当前选中的button
- (void)selectButton:(LookForRightSlideButtonView *)shareBubbles buttonTag:(NSInteger)tag;


@end

@interface LookForRightSlideButtonView : UIView {
 
}

@property (nonatomic, assign) id<LookForRightSlideButtonViewDelegate>delegate;

/**
 * @brief   初始化弹出按钮
 * @param 	frame           位置
 * @param   inView          加入的view
 * @param   startImage      起始图片
 * @param   imageArray      图片
 * @param   titleArray      标题
 */
- (id)initViewWithFrame:(CGRect)frame withInView:(UIView*)inView withStartImage:(NSString *)startImage withImageArray:(NSArray *)imageArray withTitleArray:(NSArray *)titleArray;
@end
