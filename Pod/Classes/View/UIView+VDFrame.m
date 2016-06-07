//
//  UIView+VDFrame.m
//  VDKit
//
//  Created by FTET on 15/1/28.
//  Copyright (c) 2015年 Vilyever. All rights reserved.
//

#import "UIView+VDFrame.h"

//#import <objc/runtime.h>

//#import <VDUtil/VDUtil.h>


//static char _Associated_Object_Key;


@implementation UIView (VDFrame)

#pragma Accessors
#pragma Private Accessors

#pragma Public Accessors


#pragma Methods
#pragma Private Class Method

#pragma Private Instance Method

#pragma Public Class Method

#pragma Public Instance Method
- (void)vd_setOriginX:(float)originX
{
    [self vd_setOrigin:CGPointMake(originX, self.frame.origin.y) ];
}

- (void)vd_setOriginY:(float)originY
{
    [self vd_setOrigin:CGPointMake(self.frame.origin.x, originY) ];
}

- (void)vd_setOrigin:(CGPoint)origin
{
    [self setFrame:CGRectMake(origin.x, origin.y, self.frame.size.width, self.frame.size.height) ];
}

- (void)vd_setWidth:(float)width
{
    [self vd_setSize:CGSizeMake(width, self.frame.size.height) ];
}

- (void)vd_setHeight:(float)height
{
    [self vd_setSize:CGSizeMake(self.frame.size.width, height) ];
}

- (void)vd_setSize:(CGSize)size
{
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height) ];
}

@end
