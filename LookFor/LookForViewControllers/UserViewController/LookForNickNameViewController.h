//
//  LookForNickNameViewController.h
//  LookFor
//
//  Created by chenmingguo on 15-1-22.
//  Copyright (c) 2015年 LookFor. All rights reserved.
//

#import "BasicViewController.h"

typedef enum : NSUInteger {
    ShowTypePush,
    ShowTypeLoginSystem,
} ShowType;

@interface LookForNickNameViewController : BasicViewController

@property(nonatomic, assign) ShowType showType;

@end
