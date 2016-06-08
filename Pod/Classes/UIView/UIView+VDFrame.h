//
//  UIView+VDFrame.h
//  VDKit
//
//  Created by FTET on 15/1/28.
//  Copyright (c) 2015年 Vilyever. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (VDFrame)

#pragma Methods
#pragma Public Class Method

#pragma Public Instance Method
- (void)vd_setOriginX:(float)originX;
- (void)vd_setOriginY:(float)originY;
- (void)vd_setOrigin:(CGPoint)origin;

- (void)vd_setWidth:(float)width;
- (void)vd_setHeight:(float)height;
- (void)vd_setSize:(CGSize)size;

@end
