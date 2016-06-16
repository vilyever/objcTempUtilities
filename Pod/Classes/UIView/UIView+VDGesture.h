//
//  UIView+VDGesture.h
//  objcTempUtilities
//
//  Created by Deng on 16/6/16.
//  Copyright © Deng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (VDGesture)

#pragma mark Public Method
- (void)vd_performSelectorOnTapWithTarget:(id)target selector:(SEL)selector;
- (void)vd_performActionOnTap:(void (^)(void) )block;

@end
