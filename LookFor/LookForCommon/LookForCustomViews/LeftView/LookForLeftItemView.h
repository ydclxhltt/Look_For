//
//  LookForLeftItemView.h
//  LookFor
//
//  Created by clei on 15/1/23.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SPACE_X      15.0
#define ICON_WIDTH   44.0
#define ICON_HEIGHT  44.0
#define NORMAL_COLOR RGB(64.0, 64.0, 65.0)
#define SELECT_COLOR RGB(34.0, 204.0, 204.0)

@interface LookForLeftItemView : UIButton

- (void)setImageWithImageName:(NSString *)imageName labelText:(NSString *)text;

@end
