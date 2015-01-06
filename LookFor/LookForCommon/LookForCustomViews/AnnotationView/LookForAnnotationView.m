//
//  LookForAnnotationView.m
//  IphoneMapSdkDemo
//
//  Created by chenmingguo on 15-1-5.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import "LookForAnnotationView.h"

#define TitleLabelWith      50
#define TitleLabelHeith     15
#define ImageWH             30

#define SELFWH              120
#define SELFMINWH           60

@implementation LookForAnnotationView

@synthesize annotationImageView;
@synthesize titleLabel;
@synthesize shareBubbles;

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bounds = CGRectMake(0, 0, SELFMINWH, SELFMINWH);

        self.clipsToBounds = YES;
        self.isSelect = NO;
        [self initView];
    }
    return self;
}

- (void)initView {
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - TitleLabelWith)/ 2, 0 , TitleLabelWith, TitleLabelHeith)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.text = @"11111";
    self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;

    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.titleLabel];
    
    self.annotationImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - ImageWH) / 2,self.titleLabel.frame.size.height, ImageWH, ImageWH)];
    self.annotationImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin  |UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:self.annotationImageView];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.frame = self.annotationImageView.frame;
    [self addSubview:button];
    [button addTarget:self action:@selector(handleSelect:) forControlEvents:UIControlEventTouchUpInside];
    [annotationImageView bringSubviewToFront:button];
}

- (void)handleSelect:(id)sender {
    
    
    if (shareBubbles != nil) {
        [shareBubbles hide];
        self.shareBubbles = nil;
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(selectAnnotation:)]) {
        [self.delegate selectAnnotation:self];
    }
      NSLog(@"33333");
    self.bounds =   CGRectMake(0, 0, SELFWH, SELFWH);
    self.isSelect = YES;
    self.titleLabel.hidden = YES;
    
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    [imageArray addObject:@"poi_21.png"];
    [imageArray addObject:@"poi_21.png"];
    [imageArray addObject:@"poi_21.png"];
    [imageArray addObject:@"poi_21.png"];
    [imageArray addObject:@"poi_21.png"];
    
    NSMutableArray *titleArrar = [[NSMutableArray alloc] init];
    [titleArrar addObject:@"111"];
    [titleArrar addObject:@"222"];
    [titleArrar addObject:@"333"];
    [titleArrar addObject:@"444"];
    [titleArrar addObject:@"555"];
    
    shareBubbles = [[AAShareBubbles alloc] initWithPoint:self.annotationImageView.center radius:60 inView:self withImageArray:imageArray withTitleArray:titleArrar];
    shareBubbles.delegate = self;
    shareBubbles.bubbleRadius = 15;
    [shareBubbles show];
}

#pragma mark AAShareBubbles

- (void)shareBubbles:(AAShareBubbles *)shareBubbles buttonTag:(NSInteger)tag {
    switch (tag) {
        case 0:
            NSLog(@"Facebook");
            break;
        case 1:
            NSLog(@"Twitter");
            break;
        case 2:
            NSLog(@"Email");
            break;
        case 3:
            NSLog(@"Google+");
            break;
        case 4:
            NSLog(@"Tumblr");
            break;
            
        default:
            break;
    }
}

- (void)hiddenShareBubbles:(AAShareBubbles *)shareBubble {
    self.isSelect = NO;
    self.titleLabel.hidden = NO;
    self.shareBubbles = nil;
    self.bounds = CGRectMake(0, 0, SELFMINWH, SELFMINWH);
}

- (void)hiddenShareBubbles {
    if (self.shareBubbles != nil) {
        [self.shareBubbles hide];
    }
}
@end
