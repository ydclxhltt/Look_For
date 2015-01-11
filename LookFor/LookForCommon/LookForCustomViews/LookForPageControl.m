//
//  psgeCtrl.m
//  bookingSystem
//
//  Created by chenmingguo on 11-9-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LookForPageControl.h"

@interface LookForPageControl (UIPageControlCategory)

@end

@implementation LookForPageControl (UIPageControlCategory)

//- (void)drawRect:(CGRect)rect
//{
//	UIImage *img = [UIImage imageNamed:@"pageBg.png"];
//	if(img)
//	{
//		[img drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//	}
//	else
//	{
//		[super drawRect:rect];
//	}
//}

@end


@implementation LookForPageControl

- (void)updateDots
{
	for (int i = 0; i < [self.subviews count]; i++) {
		UIImageView *dot = [self.subviews objectAtIndex:i];
        if ([dot isKindOfClass:[UIImageView class]]) {
            if (i == self.currentPage) {
                if (nil != activeImage)
                    dot.image = activeImage;
            } else {
                if (nil != inactiveImage)
                    dot.image = inactiveImage;
            }
        } else {
            NSArray *array = dot.subviews;
            for (int index = 0; index <[array count]; index++) {
                id v = [array objectAtIndex:index];
                [v removeFromSuperview];
            }
            dot.backgroundColor = [UIColor clearColor];
            if (i == self.currentPage) {
                if (nil != activeImage) {
                    UIImageView *imageV = [[UIImageView alloc] initWithFrame:dot.bounds];
                    imageV.image = activeImage;
                    [dot addSubview:imageV];
                    
                }
            } else {
                if (nil != inactiveImage)
                {
                    UIImageView *imageV = [[UIImageView alloc] initWithFrame:dot.bounds];
                    imageV.image = inactiveImage;
                    [dot addSubview:imageV];
                }
                
            }
            
            [dot setNeedsDisplay];
        }
	}
}

- (void)setDotsImageAcitvie:(UIImage *)active andInactive:(UIImage *)inactive
{
	if (nil != active)
	{
		activeImage = active;
	}
	if (nil != inactive)
	{
		inactiveImage = inactive;
	}
	[self updateDots];
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
	[super addTarget:target action:action forControlEvents:controlEvents];
	[super addTarget:self action:@selector(updateDots) forControlEvents:controlEvents];
}

- (void)setCurrentPage:(NSInteger)page
{
	[super setCurrentPage:page];
	[self updateDots];
}

-(void)setNumberOfPages:(NSInteger)numberOfPages
{
    [super setNumberOfPages:numberOfPages];
    [self updateDots];
}



@end
