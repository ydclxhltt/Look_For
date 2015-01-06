

#import <UIKit/UIKit.h>

@protocol AAShareBubblesDelegate;

@interface AAShareBubbles : UIView {
}

@property (nonatomic, assign) id<AAShareBubblesDelegate> delegate;//这块要改称weak

@property (nonatomic, assign) int radius;
@property (nonatomic, assign) int bubbleRadius;
@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, assign) UIView *parentView; //这块要改称weak

/**
 * @brief   初始化弹出按钮
 * @param 	point           中心点位置
 * @param   radiusValue     半径
 * @param   inView          加入的view
 * @param   imageArray      图片
 * @param   titleArray      标题
 */

- (id)initWithPoint:(CGPoint)point radius:(int)radiusValue inView:(UIView *)inView withImageArray:(NSArray *)imageArray withTitleArray:(NSArray *)titleArray;

-(void)show;
-(void)hide;

@end

@protocol AAShareBubblesDelegate<NSObject>
//tag 当前点击索引，从0开始
- (void)shareBubbles:(AAShareBubbles *)shareBubbles buttonTag:(NSInteger)tag;

- (void)hiddenShareBubbles:(AAShareBubbles *)shareBubble;
@end
