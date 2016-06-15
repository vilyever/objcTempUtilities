//
//  UIViewController+VDEnhance.m
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import "UIViewController+VDEnhance.h"

//#import <objc/runtime.h>


@implementation UIViewController (VDEnhance)

#pragma mark Public Method
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

+ (UIViewController *)vd_topViewController {
    return [self vd_topViewControllerWithRootViewController:nil];
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
    
    if ( [rootViewController isKindOfClass:[UINavigationController class] ] )
    {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        [navigationController popToRootViewControllerAnimated:NO];
    }
}

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
        CGFloat PopoverVerticalOffset = 7.0f;
        
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
    popoverPresentationController.sourceView = [UIApplication sharedApplication].keyWindow;
    popoverPresentationController.sourceRect = [UIApplication sharedApplication].keyWindow.bounds;
    popoverPresentationController.permittedArrowDirections = 0;
    
    return popoverPresentationController;
}

- (void)vd_dismiss {
    [self vd_dismissWithAnimation:YES];
}

- (void)vd_dismissWithAnimation:(BOOL)animated {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:animated completion:nil];
    }
    else if (self.navigationController && self.navigationController.topViewController == self) {
        [self.navigationController popViewControllerAnimated:animated];
    }
}

#pragma mark Private Method
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
        return [self vd_topViewControllerWithRootViewController:presentedViewController];
    }
    else
    {
        return rootViewController;
    }
}

@end
