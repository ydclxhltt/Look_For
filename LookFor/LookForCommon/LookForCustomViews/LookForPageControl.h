//
//  psgeCtrl.h
//  bookingSystem
//
//  Created by chenmingguo on 11-9-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LookForPageControl : UIPageControl
{
	UIImage *activeImage;
	UIImage *inactiveImage;
}

- (void)setDotsImageAcitvie:(UIImage *)active andInactive:(UIImage *)inactive;

@end
