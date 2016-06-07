//
//  UIView+VDConstraint.m
//  VDKit
//
//  Created by FTET on 15/1/28.
//  Copyright (c) 2015年 Vilyever. All rights reserved.
//

#import "UIView+VDConstraint.h"

//#import <objc/runtime.h>

//static char _Associated_Object_Key;


@implementation UIView (VDConstraint)

#pragma Accessors
#pragma Private Accessors

#pragma Public Accessors
- (CGFloat)vd_constraintTop
{
    for (NSLayoutConstraint *constraint in self.superview.constraints)
    {
        if (constraint.firstItem == self
            && constraint.shouldBeArchived
            && constraint.active)
        {
            if (constraint.firstAttribute == NSLayoutAttributeTop)
            {
                return constraint.constant;
            }
        }
    }
    
    return 0.0f;
}

- (CGFloat)vd_constraintBottom
{
    for (NSLayoutConstraint *constraint in self.superview.constraints)
    {
        if (constraint.secondItem == self
            && constraint.shouldBeArchived
            && constraint.active)
        {
            if (constraint.secondAttribute == NSLayoutAttributeBottom)
            {
                return constraint.constant;
            }
        }
    }
    
    return 0.0f;
}

- (CGFloat)vd_constraintLeading
{
    for (NSLayoutConstraint *constraint in self.superview.constraints)
    {
        if (constraint.firstItem == self
            && constraint.shouldBeArchived
            && constraint.active)
        {
            if (constraint.firstAttribute == NSLayoutAttributeLeading)
            {
                return constraint.constant;
            }
        }
    }
    
    return 0.0f;
}

- (CGFloat)vd_constraintTrailing
{
    for (NSLayoutConstraint *constraint in self.superview.constraints)
    {
        if (constraint.secondItem == self
            && constraint.shouldBeArchived
            && constraint.active)
        {
            if (constraint.secondAttribute == NSLayoutAttributeTrailing)
            {
                return constraint.constant;
            }
        }
    }
    
    return 0.0f;
}

- (CGFloat)vd_constraintWidth
{
    for (NSLayoutConstraint *constraint in self.constraints)
    {
        if (constraint.firstItem == self
            && constraint.shouldBeArchived
            && constraint.active)
        {
            if (constraint.firstAttribute == NSLayoutAttributeWidth && !constraint.secondItem)
            {
                return constraint.constant;
            }
        }
    }
    
    if (self.vd_constraintAspectRatio != -1.0f)
    {
        return self.vd_constraintHeight * self.vd_constraintAspectRatio;
    }
    
    return 0.0f;
}

- (CGFloat)vd_constraintHeight
{
    for (NSLayoutConstraint *constraint in self.constraints)
    {
        if (constraint.firstItem == self
            && constraint.shouldBeArchived
            && constraint.active)
        {
            if (constraint.firstAttribute == NSLayoutAttributeHeight && !constraint.secondItem)
            {
                return constraint.constant;
            }
        }
    }
    
    if (self.vd_constraintAspectRatio != -1.0f)
    {
        return self.vd_constraintWidth / self.vd_constraintAspectRatio;
    }
    
    return 0.0f;
}

- (CGFloat)vd_constraintAspectRatio
{
    for (NSLayoutConstraint *constraint in self.constraints)
    {
        if (constraint.firstItem == self
            && constraint.shouldBeArchived
            && constraint.active)
        {
            if (constraint.secondItem == self)
            {
                if ( (constraint.firstAttribute == NSLayoutAttributeWidth && constraint.secondAttribute == NSLayoutAttributeHeight)
                    || (constraint.firstAttribute == NSLayoutAttributeHeight && constraint.secondAttribute == NSLayoutAttributeWidth) )
                {
                    return constraint.multiplier;
                }
            }
        }
    }
    
    return -1.0f;
}


#pragma Methods
#pragma Private Class Method

#pragma Private Instance Method

#pragma Public Class Method

#pragma Public Instance Method

@end
