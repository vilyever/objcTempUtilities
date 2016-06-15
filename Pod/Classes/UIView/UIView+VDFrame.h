//
//  UIView+VDFrame.h
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (VDFrame)

#pragma mark Public Method
@property (nonatomic, assign, readonly) CGPoint vd_frameOrigin;
@property (nonatomic, assign, readonly) CGSize vd_frameSize;
@property (nonatomic, assign, readonly) float vd_frameX;
@property (nonatomic, assign, readonly) float vd_frameY;
@property (nonatomic, assign, readonly) float vd_frameWidth;
@property (nonatomic, assign, readonly) float vd_frameHeight;

@end
