//
//  UIView+VDGesture.m
//  objcTempUtilities
//
//  Created by Deng on 16/6/16.
//  Copyright © Deng. All rights reserved.
//

#import "UIView+VDGesture.h"

#import <objc/runtime.h>

#import "NSObject+VDEnhance.h"


@implementation UIView (VDGesture)

#pragma mark Public Method
- (void)vd_performActionOnTap:(void (^)(void) )block {
    [self vd_internalActiveOnTap];
    [self setVd_tapBlock:block];
}

- (void)vd_performSelectorOnTapWithTarget:(id)target selector:(SEL)selector {
	[self vd_internalActiveOnTap];
    [self setVd_tapTarget:target];
    [self setVd_TapSelector:selector];
}

#pragma mark Properties
- (id)vd_tapTarget {
    VDWeakObjectCarrier *carrier = objc_getAssociatedObject(self, @selector(vd_tapTarget));
    id tapTarget = carrier.weakObject;
    return tapTarget;
}

- (void)setVd_tapTarget:(id)tapTarget {
    VDWeakObjectCarrier *carrier = [VDWeakObjectCarrier carrierWithWeakObject:tapTarget];
    objc_setAssociatedObject(self, @selector(vd_tapTarget), carrier, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SEL)vd_tapSelector {
    NSString *selectorString = objc_getAssociatedObject(self, @selector(vd_tapSelector));
    SEL tapSelector = NSSelectorFromString(selectorString);
    return tapSelector;
}

- (void)setVd_TapSelector:(SEL)selector {
    NSString *selectorString = NSStringFromSelector(selector);
    objc_setAssociatedObject(self, @selector(vd_tapSelector), selectorString, OBJC_ASSOCIATION_COPY);
}

- (void (^)(void))vd_tapBlock {
    void (^tapBlock)(void) = objc_getAssociatedObject(self, @selector(vd_tapBlock));
    return tapBlock;
}

- (void)setVd_tapBlock:(void (^)(void))tapBlock {
    objc_setAssociatedObject(self, @selector(vd_tapBlock), tapBlock, OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)vd_isOnTapActive {
    BOOL isActive = [objc_getAssociatedObject(self, @selector(vd_isOnTapActive)) boolValue];
    return isActive;
}

- (void)setVd_isOnTapActive:(BOOL)isActive {
    objc_setAssociatedObject(self, @selector(vd_isOnTapActive), @(isActive), OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark Private Method
- (void)vd_internalActiveOnTap {
    if (![self vd_isOnTapActive]) {
        [self setVd_isOnTapActive:YES];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(vd_internalHandleTapAction:)];
        [self addGestureRecognizer:tapGestureRecognizer];
    }
}

- (void)vd_internalHandleTapAction:(UITapGestureRecognizer *)tapGestureRecognizer {
    [[self vd_tapTarget] vd_performSelector:[self vd_tapSelector]];
    if ([self vd_tapBlock]) {
        [self vd_tapBlock]();
    }
}

@end
