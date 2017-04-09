//
//  MOStoreButton.h
//  MODownload
//
//  Created by moath othman on 6/19/14.
//  Copyright (c) 2014 com.w. All rights reserved.
//
#define blueColor_macro [UIColor colorWithRed:156.0/255.0 green:140.0/255.0 blue:103.0/255.0 alpha:1]

#import <UIKit/UIKit.h>

@class MOStoreButton;
@protocol MOStoreButtonDelegate
- (void)storeButtonFired:(MOStoreButton *)button;
@end



@interface MOStoreButton : UIButton{
    
    CAGradientLayer *gradient_;
    CGPoint customPadding_;
    
}

@property(nonatomic,strong)NSArray *titles;
@property (nonatomic, assign) id<MOStoreButtonDelegate> buttonDelegate;
@property(nonatomic,readonly,assign)int  currentIndex;
@property(nonatomic,assign)BOOL isInTestingMode;
@property(nonatomic,strong)NSString *finishedDownloadingButtonTitle;

// Set new progress (0.0f - 1.0f) animated with custom duration
- (void)setProgress:(CGFloat)progress animated:(BOOL)animate;

-(void)startDownloading;

- (id)initWithFrame:(CGRect)frame andColor:(UIColor*)buttonColor;

- (void)setAnchor:(CGPoint)anchor;

- (void)reset;

@end
