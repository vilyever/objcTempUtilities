//
//  UIViewController+VDEnhance.m
//  VDKit
//
//  Created by FTET on 15/1/28.
//  Copyright (c) 2015年 Vilyever. All rights reserved.
//

#import "UIViewController+VDEnhance.h"

#import <objc/runtime.h>

#import "UIWindow+VDEnhance.h"


static char After_View_Did_Load_Action_Blocks_Associated_Object_Key;


@implementation UIViewController (VDEnhance)

#pragma Accessors
#pragma Private Accessors

#pragma Public Accessors


#pragma Methods
#pragma Private Class Method

#pragma Private Instance Method
//- (void)afterViewDidLoad
//{
//    NSMutableDictionary *blocks = objc_getAssociatedObject(self, &After_View_Did_Load_Action_Blocks_Associated_Object_Key);
//
//    if (blocks)
//    {
//        for (id key in [blocks allKeys] )
//        {
//            void (^block)(void) = [blocks objectForKey:key];
//            block();
//        }
//    }
//
//    [self clearAllActionsAfterViewDidLoad];
//}

#pragma Public Class Method
+ (instancetype)vd_controllerFromNib
{
    return [ [self class] vd_controllerFromNibWithNibName:NSStringFromClass( [self class] ) ];
}

+ (instancetype)vd_controllerFromNibWithNibName:(NSString *)nibName
{
    return [ [ [self class] alloc] initWithNibName:nibName bundle:nil];
}

+ (instancetype)vd_controllerFromStoryboard
{
    return [ [self class] vd_controllerFromStoryboardWithStoryboardName:@"Main" withIdentifier:NSStringFromClass( [self class] ) ];
}

+ (instancetype)vd_controllerFromStoryboardWithStoryboardName:(NSString *)storyboardName
{
    return [ [self class] vd_controllerFromStoryboardWithStoryboardName:storyboardName withIdentifier:NSStringFromClass( [self class] ) ];
}

+ (instancetype)vd_controllerFromStoryboardWithStoryboardName:(NSString *)storyboardName withIdentifier:(NSString *)identifier
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

+ (UIViewController*)vd_topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if (!rootViewController)
    {
        rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    
    if ( [rootViewController isKindOfClass:[UITabBarController class] ] )
    {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self vd_topViewControllerWithRootViewController:tabBarController.selectedViewController];
    }
    else if ( [rootViewController isKindOfClass:[UINavigationController class] ] )
    {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self vd_topViewControllerWithRootViewController:navigationController.visibleViewController];
    }
    else if (rootViewController.presentedViewController)
    {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
//        if (presentedViewController.isBeingDismissed)
//        {
//            return rootViewController;
//        }
        return [self vd_topViewControllerWithRootViewController:presentedViewController];
    }
//    else if (rootViewController.isBeingDismissed)
//    {
//        return [self vd_topViewControllerWithRootViewController:rootViewController.presentingViewController];
//    }
    else
    {
        return rootViewController;
    }
}

+ (void)vd_backToRootViewController
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *presentedViewController = rootViewController;
    while (presentedViewController.presentedViewController) {
        presentedViewController = presentedViewController.presentedViewController;
    }
    
    UIViewController *presentingViewController;
    while (presentedViewController != rootViewController) {
        presentingViewController = presentedViewController.presentingViewController;
        [presentedViewController dismissViewControllerAnimated:NO completion:nil];
        presentedViewController = presentingViewController;
    }
    
    if ( [rootViewController isKindOfClass:[UITabBarController class] ] )
    {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        [tabBarController setSelectedIndex:0];
        
        if ([tabBarController.selectedViewController isKindOfClass:[UINavigationController class]])
        {
            UINavigationController *navigationController = (UINavigationController *)tabBarController.selectedViewController;
            [navigationController popToRootViewControllerAnimated:NO];
        }
    }
    else if ( [rootViewController isKindOfClass:[UINavigationController class] ] )
    {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        [navigationController popToRootViewControllerAnimated:NO];
        
        if ([navigationController.topViewController isKindOfClass:[UITabBarController class]])
        {
            UITabBarController *tabBarController = (UITabBarController *)navigationController.topViewController;
            [tabBarController setSelectedIndex:0];
        }
    }
}

#pragma Public Instance Method
- (void)vd_dismissWithDisplayType:(VDViewControllerDisplayType)displayType
{
    switch (displayType) {
        case VDViewControllerDisplayTypePresented:
            if (self.presentingViewController)
            {
                [self dismissViewControllerAnimated:YES completion:NULL];
            }
            break;
            
        case VDViewControllerDisplayTypePushed:
            if (self.navigationController && self.navigationController.viewControllers.count > 1)
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
            break;
            
        case VDViewControllerDisplayTypeInTab:
            break;
            
        case VDViewControllerDisplayTypePopover:
            
            if ( [self respondsToSelector:@selector(dismissPopoverAnimated:) ] )
            {
                [ (UIPopoverController *)self dismissPopoverAnimated:YES];
            }
            break;
            
        default:
            break;
    }
}

static CGFloat PopoverVerticalOffset = 7.0f;

- (UIPopoverPresentationController *)vd_popoverFromView:(UIView *)view atDirection:(UIPopoverArrowDirection)direction shouldDisplayArrow:(BOOL)shouldDisplayArrow fromViewController:(UIViewController *)controller
{
    self.modalPresentationStyle = UIModalPresentationPopover;
    
    [controller presentViewController:self animated:YES completion:nil];
    UIPopoverPresentationController *popoverPresentationController = self.popoverPresentationController;
    popoverPresentationController.sourceView = view;
    
    if (shouldDisplayArrow)
    {
        popoverPresentationController.sourceRect = view.bounds;
        popoverPresentationController.permittedArrowDirections = direction;
    }
    else
    {
        switch (direction) {
            case UIPopoverArrowDirectionUp:
            case UIPopoverArrowDirectionAny:
            case UIPopoverArrowDirectionUnknown:
                popoverPresentationController.sourceRect = CGRectMake(0.0f, (self.preferredContentSize.height + view.bounds.size.height) / 2.0f + PopoverVerticalOffset, view.bounds.size.width, view.bounds.size.height);
                break;
            case UIPopoverArrowDirectionDown:
                popoverPresentationController.sourceRect = CGRectMake(0.0f, -(self.preferredContentSize.height + view.bounds.size.height) / 2.0f + PopoverVerticalOffset, view.bounds.size.width, view.bounds.size.height);
                break;
            case UIPopoverArrowDirectionLeft:
                popoverPresentationController.sourceRect = CGRectMake( (self.preferredContentSize.width + view.bounds.size.width) / 2.0f, PopoverVerticalOffset, view.bounds.size.width, view.bounds.size.height);
                break;
            case UIPopoverArrowDirectionRight:
                popoverPresentationController.sourceRect = CGRectMake(-(self.preferredContentSize.width + view.bounds.size.width) / 2.0f, PopoverVerticalOffset, view.bounds.size.width, view.bounds.size.height);
                break;
                
            default:
                break;
        }
        popoverPresentationController.permittedArrowDirections = 0;
    }
    
    return popoverPresentationController;
}

- (UIPopoverPresentationController *)vd_popoverInCenterOfWindowFromViewController:(UIViewController *)controller
{
    self.modalPresentationStyle = UIModalPresentationPopover;
    [controller presentViewController:self animated:YES completion:NULL];
    UIPopoverPresentationController *popoverPresentationController = self.popoverPresentationController;
    popoverPresentationController.sourceView = VDWindow;
    popoverPresentationController.sourceRect = VDWindow.bounds;
    popoverPresentationController.permittedArrowDirections = 0;
    
    return popoverPresentationController;
}

- (void)vd_excuteActionAfterViewDidLoad:(void (^)(void))block
{
    [self vd_excuteActionWithTag:nil afterViewDidLoad:block];
}

- (void)vd_excuteActionWithTag:(NSString *)tag afterViewDidLoad:(void (^)(void))block
{
    NSMutableDictionary *blocks = objc_getAssociatedObject(self, &After_View_Did_Load_Action_Blocks_Associated_Object_Key);
    
    if (!blocks)
    {
        blocks = [ [NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, &After_View_Did_Load_Action_Blocks_Associated_Object_Key, blocks, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    if (!tag)
    {
        for (NSUInteger i = [blocks allKeys].count; ; i++)
        {
            tag = [NSString stringWithFormat:@"%lu", (unsigned long)i];
            if (![blocks objectForKey:tag] )
            {
                break;
            }
        }
    }
    
    if (block)
    {
        [blocks setObject:[block copy] forKey:tag];
    }
    else
    {
        [blocks removeObjectForKey:tag];
    }
}

- (void)vd_clearAllActionsAfterViewDidLoad
{
    objc_setAssociatedObject(self, &After_View_Did_Load_Action_Blocks_Associated_Object_Key, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma load
//+ (void)load
//{
//    SEL originSelector = @selector(viewDidLoad);
//    Method originMethod = class_getInstanceMethod(self, originSelector);
//    void (*originalImp)(id, SEL) = (void(*)(id, SEL) )method_getImplementation(originMethod);
//
//    SEL hookSelector = @selector(afterViewDidLoad);
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
