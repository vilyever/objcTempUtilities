//
//  UILabel+VDVerticalAlignment.m
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import "UILabel+VDVerticalAlignment.h"

#import <objc/runtime.h>


typedef NS_ENUM(NSInteger, VDTextVerticalAlignment) {
    VDTextVerticalAlignmentTop,
    VDTextVerticalAlignmentCenter,
    VDTextVerticalAlignmentBottom
};


@implementation UILabel (VDVerticalAlignment)

#pragma mark Public Method
- (void)vd_setVerticalAligmentToTop {
    [self setVd_textVerticalAlignment:VDTextVerticalAlignmentTop];
}

- (void)vd_setVerticalAligmentToCenter {
    [self setVd_textVerticalAlignment:VDTextVerticalAlignmentCenter];
}

- (void)vd_setVerticalAligmentToBottom {
    [self setVd_textVerticalAlignment:VDTextVerticalAlignmentBottom];
}

#pragma mark Properties
- (VDTextVerticalAlignment)vd_textVerticalAlignment
{
    NSNumber *alignment = objc_getAssociatedObject(self, @selector(vd_textVerticalAlignment));
    
    if (alignment)
    {
        return [alignment integerValue];
    }
    
    alignment = [NSNumber numberWithInt:VDTextVerticalAlignmentCenter];
    objc_setAssociatedObject(self, @selector(vd_textVerticalAlignment), alignment, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return VDTextVerticalAlignmentCenter;
}

- (void)setVd_textVerticalAlignment:(VDTextVerticalAlignment)vd_textVerticalAlignment
{
    NSNumber *alignment = [NSNumber numberWithInt:vd_textVerticalAlignment];
    objc_setAssociatedObject(self, @selector(vd_textVerticalAlignment), alignment, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setNeedsDisplay];
}

#pragma mark Overrides
+ (void)load
{
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(textRectForBounds:limitedToNumberOfLines:) ), class_getInstanceMethod(self, @selector(vd_verticalAlignmentTextRectForBounds:limitedToNumberOfLines:) ) );
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(drawTextInRect:) ), class_getInstanceMethod(self, @selector(vd_verticalAlignmentDrawTextInRect:) ) );
}

#pragma mark Private Method
- (CGRect)vd_verticalAlignmentTextRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect textRect = [self vd_verticalAlignmentTextRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    switch ([self vd_textVerticalAlignment]) {
        case VDTextVerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VDTextVerticalAlignmentCenter:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0f;
            break;
            
        case VDTextVerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
            
        default:
            break;
    }
    
    return textRect;
}

- (void)vd_verticalAlignmentDrawTextInRect:(CGRect)rect
{
    CGRect textRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    [self vd_verticalAlignmentDrawTextInRect:textRect];
}

@end
