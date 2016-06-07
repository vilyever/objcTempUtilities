//
//  UIView+VDKit.m
//  VDKit
//
//  Created by FTET on 15/1/28.
//  Copyright (c) 2015年 Vilyever. All rights reserved.
//

#import "UIView+VDKit.h"

#import <objc/runtime.h>

//#import <VDUtil/VDUtil.h>


@implementation UIView (VDKit)

#pragma Accessors
#pragma Private Accessors

#pragma Public Accessors


#pragma Methods
#pragma Private Class Method

#pragma Private Instance Method
- (instancetype)initWithNibName:(NSString *)nibName
{
    self = [self init];
    if (self)
    {
        NSArray *nibViews = [ [NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
        self = nibViews[0];
    }
    
    return self;
}

#pragma Public Class Method
+ (instancetype)vd_viewFromNib
{
    return [self vd_viewFromNibWithNibName:NSStringFromClass( [self class] ) ];
}

+ (instancetype)vd_viewFromNibWithNibName:(NSString *)nibName
{
    return [ [ [self class] alloc] initWithNibName:nibName];
}

#pragma Public Instance Method
- (NSArray *)vd_addSubview:(UIView *)view scaleToFill:(BOOL)scaleToFill
{
    if (!view)
    {
        return nil;
    }
    
    [self addSubview:view];
    if (scaleToFill)
    {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[vdsubview]-0-|" options:0 metrics:nil views:@{@"vdsubview" : view} ] ];
        [array addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[vdsubview]-0-|" options:0 metrics:nil views:@{@"vdsubview" : view} ] ];
        
        NSArray *constraints = [NSArray arrayWithArray:array];
        
        [self addConstraints:constraints];
        
        return constraints;
    }
    
    return nil;
}

- (void)vd_removeAllSubviews
{
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
}


#pragma load
//+ (void)load
//{
//    SEL originSelector = @selector(didMoveToSuperview);
//    Method originMethod = class_getInstanceMethod(self, originSelector);
//    void (*originalImp)(id, SEL) = (void(*)(id, SEL) )method_getImplementation(originMethod);
//    
//    SEL hookSelector = @selector(didChangeSuperview);
//    Method hookMethod = class_getInstanceMethod(self, hookSelector);
//    void (*hookImp)(id, SEL) = (void(*)(id, SEL) )method_getImplementation(hookMethod);
//    
//    void (^block)(id) = ^(id _self) {
//        originalImp(_self, originSelector);
//        hookImp(_self, hookSelector);
//    };
//    
//    IMP newImp = imp_implementationWithBlock(block);
//    method_setImplementation(originMethod, newImp);
//}

@end
