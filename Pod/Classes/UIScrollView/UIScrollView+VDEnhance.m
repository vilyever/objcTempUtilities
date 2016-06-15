//
//  UIScrollView+VDEnhance.m
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import "UIScrollView+VDEnhance.h"

//#import <objc/runtime.h>


@implementation UIScrollView (VDEnhance)

#pragma mark Public Method
- (BOOL)vd_isReachTop
{
    return self.contentOffset.y <= 0;
}

- (BOOL)vd_isReachBottom
{
    return self.contentOffset.y >= (self.contentSize.height - self.bounds.size.height);
}

- (void)vd_scrollToBottom:(BOOL)animated
{
    if (self.contentSize.height <= self.bounds.size.height)
    {
        return;
    }
    
    [self setContentOffset:CGPointMake(self.contentOffset.x, (self.contentSize.height - self.bounds.size.height)) animated:animated];
}

#pragma mark Private Method


@end
