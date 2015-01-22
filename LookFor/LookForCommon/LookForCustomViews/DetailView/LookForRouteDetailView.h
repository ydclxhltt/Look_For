//
//  LookForRouteDetailView.h
//  LookFor
//
//  Created by clei on 15/1/22.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "LookForBaseDetailView.h"

@interface LookForRouteDetailView : LookForBaseDetailView

/*
 *  设置数据
 *
 *  @pram distance  距离
 *  @pram hour      所需小时
 *  @pram minute    所需分钟
 *  @pram type      去那的方式(步行,驾车)
 */
- (void)setDetailTextWithDistance:(int)distance goThereTimeHour:(int)hour  goThereTimeMinute:(int)minute goThereType:(NSString *)type;
@end
