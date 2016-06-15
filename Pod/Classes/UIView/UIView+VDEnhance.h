//
//  UIView+VDEnhance.h
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (VDEnhance)

#pragma mark Public Method
+ (instancetype)vd_viewFromNib;
+ (instancetype)vd_viewFromNibWithNibName:(NSString *)nibName;

- (NSArray *)vd_addSubview:(UIView *)view scaleToFill:(BOOL)scaleToFill;
- (void)vd_removeAllSubviews;

@end
