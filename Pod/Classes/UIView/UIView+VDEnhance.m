//
//  UIView+VDEnhance.m
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import "UIView+VDEnhance.h"

//#import <objc/runtime.h>


@implementation UIView (VDEnhance)

#pragma mark Public Method
+ (instancetype)vd_viewFromNib
{
    return [self vd_viewFromNibWithNibName:NSStringFromClass( [self class] ) ];
}

+ (instancetype)vd_viewFromNibWithNibName:(NSString *)nibName
{
    return [ [ [self class] alloc] initWithNibName:nibName];
}

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

#pragma mark Private Method
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


@end
