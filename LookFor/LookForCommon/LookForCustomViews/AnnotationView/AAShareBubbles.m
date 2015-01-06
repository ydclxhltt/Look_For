
#import "AAShareBubbles.h"
#import <QuartzCore/QuartzCore.h>

#define CircleImageWH      12
#define DefaultSpace       3
#define TitleLabelHeith    12

@interface AAShareBubbles()
@property (nonatomic, strong) NSArray *imageArray;          //图片数组
@property (nonatomic, strong) NSMutableArray *bubbles;      //按钮数组
@property (nonatomic, strong) NSArray *titleArray;          //标题数组
@end

@implementation AAShareBubbles

@synthesize delegate, parentView;

- (id)initWithPoint:(CGPoint)point radius:(int)radiusValue inView:(UIView *)inView withImageArray:(NSArray *)imageArray withTitleArray:(NSArray *)titleArray
{
    self = [super initWithFrame:CGRectMake(point.x - radiusValue, point.y - radiusValue, 2 * radiusValue, 2 * radiusValue)];
    if (self) {
        self.radius = radiusValue;
        self.bubbleRadius = 40;
        self.parentView = inView;
        self.imageArray = imageArray;
        self.titleArray = titleArray;
    }
    return self;
}

#pragma mark -
#pragma mark Actions

- (void)handleClick:(id)sender {
    [self hide];
    if([self.delegate respondsToSelector:@selector(shareBubbles:buttonTag:)]) {
        UIButton *button = (UIButton *)sender;
        [self.delegate shareBubbles:self buttonTag:button.tag];
    }
}


#pragma mark -
#pragma mark Methods

-(void)show
{
    if(!self.isAnimating)
    {
        self.isAnimating = YES;
        
        [self.parentView addSubview:self];
        [self.parentView bringSubviewToFront:self];
        // Create background
        UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareViewBackgroundTapped:)];
        [self addGestureRecognizer:tapges];

        // --
        
        if(self.bubbles) {
            self.bubbles = nil;
        }
        self.bubbles = [[NSMutableArray alloc] init];
        
        //创建弹出的按钮
        for (NSInteger index = 0; index < [self.titleArray count]; index++) {
            if (index < [self.imageArray count]) {
                UIView *button = [self shareButtonWithIcon:[self.imageArray objectAtIndex:index] withTitle:[self.titleArray objectAtIndex:index] withTag:index];
                [self.bubbles addObject:button];
            }
        }
        
        if(self.bubbles.count == 0) return;
        
        //计算按钮位置
        float bubbleDistanceFromPivot = self.radius - self.bubbleRadius;
        
        float bubblesBetweenAngel = 180 / (self.bubbles.count - 1);
        //其实角度，从180度开始
        float startAngel = 180;
        
        NSMutableArray *coordinates = [NSMutableArray array];
        
        for (int i = 0; i < self.bubbles.count; ++i)
        {
            UIButton *bubble = [self.bubbles objectAtIndex:i];
            float angle = startAngel + i * bubblesBetweenAngel;
            float x = cos(angle * M_PI / 180) * bubbleDistanceFromPivot + self.radius;
            float y = sin(angle * M_PI / 180) * bubbleDistanceFromPivot + self.radius;
            
            [coordinates addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:x], @"x", [NSNumber numberWithFloat:y], @"y", nil]];
            
            bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
            bubble.center = CGPointMake(self.radius, self.radius);
            bubble.tag = i;
        }
        
        int inetratorI = 0;
        for (NSDictionary *coordinate in coordinates)
        {
            UIButton *bubble = [self.bubbles objectAtIndex:inetratorI];
            float delayTime = inetratorI * 0.1;
            [self performSelector:@selector(showBubbleWithAnimation:) withObject:[NSDictionary dictionaryWithObjectsAndKeys:bubble, @"button", coordinate, @"coordinate", nil] afterDelay:delayTime];
            ++inetratorI;
        }
    }
}

-(void)hide
{
    if(!self.isAnimating)
    {
        self.isAnimating = YES;
        int inetratorI = 0;
        for (UIButton *bubble in self.bubbles)
        {
            float delayTime = inetratorI * 0.1;
            [self performSelector:@selector(hideBubbleWithAnimation:) withObject:bubble afterDelay:delayTime];
            ++inetratorI;
        }
    }
    
    
}

#pragma mark -
#pragma mark Helper functions

-(void)shareViewBackgroundTapped:(UITapGestureRecognizer *)tapGesture {
    [self hide];
}

-(void)showBubbleWithAnimation:(NSDictionary *)info
{
    UIButton *bubble = (UIButton *)[info objectForKey:@"button"];
    NSDictionary *coordinate = (NSDictionary *)[info objectForKey:@"coordinate"];
    
    [UIView animateWithDuration:0.25 animations:^{
        bubble.center = CGPointMake([[coordinate objectForKey:@"x"] floatValue], [[coordinate objectForKey:@"y"] floatValue]);
        bubble.alpha = 1;
        bubble.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            bubble.transform = CGAffineTransformMakeScale(0.8, 0.8);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                bubble.transform = CGAffineTransformMakeScale(1, 1);
            } completion:^(BOOL finished) {
                if(bubble.tag == self.bubbles.count - 1) {
                  self.isAnimating = NO;
                }
                bubble.layer.shadowColor = [UIColor blackColor].CGColor;
                bubble.layer.shadowOpacity = 0.2;
                bubble.layer.shadowOffset = CGSizeMake(0, 1);
                bubble.layer.shadowRadius = 2;
            }];
        }];
    }];
}

-(void)hideBubbleWithAnimation:(UIButton *)bubble
{
    [UIView animateWithDuration:0.2 animations:^{
        bubble.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            bubble.center = CGPointMake(self.radius, self.radius);
            bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
            bubble.alpha = 0;
        } completion:^(BOOL finished) {
            if(bubble.tag == self.bubbles.count - 1) {
                self.isAnimating = NO;
                self.hidden = YES;
                
                if ([self.delegate respondsToSelector:@selector(hiddenShareBubbles:)]) {
                    [self.delegate hiddenShareBubbles:self];
                }
                [self removeFromSuperview];
            }
            [bubble removeFromSuperview];
        }];
    }];
}

//创建button
-(UIView *)shareButtonWithIcon:(NSString *)iconName withTitle:(NSString *)title withTag:(NSInteger)tag
{
    // Circle background
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2 * self.bubbleRadius, 2 * self.bubbleRadius)];
    circle.backgroundColor = [UIColor clearColor];
    circle.layer.cornerRadius = self.bubbleRadius;
    circle.layer.masksToBounds = YES;
    [self addSubview:circle];
    
    UIView *bgView = [[UIView alloc] initWithFrame:circle.frame];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.6;
    [circle addSubview:bgView];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 2 * self.bubbleRadius, 2 * self.bubbleRadius);
    button.backgroundColor = [UIColor clearColor];
    button.tag = tag;
    [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];

    // Circle icon
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CircleImageWH, CircleImageWH)];
    icon.backgroundColor = [UIColor clearColor];
    CGRect f = icon.frame;
    f.origin.x = (circle.frame.size.width - f.size.width) / 2;
    f.origin.y = DefaultSpace;
    icon.frame = f;
    icon.image = [UIImage imageNamed:iconName];
    [button addSubview:icon];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, icon.frame.origin.y + icon.frame.size.height , circle.frame.size.width, TitleLabelHeith)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    label.text = title;
    [button addSubview:label];
    [circle addSubview:button];
    return circle;
}

-(UIColor *)colorFromRGB:(int)rgb {
    return [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:1.0];
}

-(UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
