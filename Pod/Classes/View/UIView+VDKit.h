//
//  UIView+VDKit.h
//  VDKit
//
//  Created by FTET on 15/1/28.
//  Copyright (c) 2015年 Vilyever. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (VDKit)

#pragma Methods
#pragma Public Class Method
+ (instancetype)vd_viewFromNib;
+ (instancetype)vd_viewFromNibWithNibName:(NSString *)nibName;

#pragma Public Instance Method
- (NSArray *)vd_addSubview:(UIView *)view scaleToFill:(BOOL)scaleToFill;
- (void)vd_removeAllSubviews;

@end
