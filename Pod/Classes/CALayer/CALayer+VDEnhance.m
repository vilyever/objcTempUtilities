//
//  CALayer+VDEnhance.m
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import "CALayer+VDEnhance.h"

//#import <objc/runtime.h>


@implementation CALayer (VDEnhance)

#pragma mark Public Method
- (void)vd_addShadow
{
    self.shadowColor = [UIColor blackColor].CGColor;
    self.shadowOffset = CGSizeMake(0.0f, 3.0f);
    self.shadowOpacity = 0.6f;
}

- (void)vd_clearShadow
{
    self.shadowColor = [UIColor clearColor].CGColor;
    self.shadowOffset = CGSizeZero;
    self.shadowOpacity = 0.0f;
}

#pragma mark Private Method


@end
