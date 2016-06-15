//
//  UILabel+VDEnhance.m
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import "UILabel+VDEnhance.h"

//#import <objc/runtime.h>


@implementation UILabel (VDEnhance)

#pragma mark Public Method
+ (UILabel *)vd_copyWithLabel:(UILabel *)originalLabel
{
    UILabel *copiedLabel = [ [UILabel alloc] init];
    
    copiedLabel.frame = originalLabel.frame;
    copiedLabel.text = [originalLabel.text copy];
    copiedLabel.font = originalLabel.font;
    copiedLabel.textColor = originalLabel.textColor;
    copiedLabel.shadowColor = originalLabel.shadowColor;
    copiedLabel.shadowOffset = originalLabel.shadowOffset;
    copiedLabel.textAlignment = originalLabel.textAlignment;
    copiedLabel.lineBreakMode = originalLabel.lineBreakMode;
    copiedLabel.attributedText = [originalLabel.attributedText copy];
    copiedLabel.highlightedTextColor = originalLabel.highlightedTextColor;
    copiedLabel.highlighted = originalLabel.highlighted;
    copiedLabel.userInteractionEnabled = originalLabel.userInteractionEnabled;
    copiedLabel.enabled = originalLabel.enabled;
    copiedLabel.numberOfLines = originalLabel.numberOfLines;
    copiedLabel.adjustsFontSizeToFitWidth = originalLabel.adjustsFontSizeToFitWidth;
    copiedLabel.baselineAdjustment = originalLabel.baselineAdjustment;
    copiedLabel.minimumScaleFactor = originalLabel.minimumScaleFactor;
    
    return copiedLabel;
}

#pragma mark Private Method


@end
