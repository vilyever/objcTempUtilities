//
//  UIScrollView+VDEnhance.h
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIScrollView (VDEnhance)

#pragma mark Public Method
- (BOOL)vd_isReachTop;
- (BOOL)vd_isReachBottom;
- (void)vd_scrollToBottom:(BOOL)animated;

@end
