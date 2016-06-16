//
//  VDRouter.m
//  Ever
//
//  Created by FTET on 16/6/13.
//  Copyright © 2016年 vilyever. All rights reserved.
//

#import "VDRouter.h"

#import "VDRouterNavigationViewController.h"

@interface VDRouter ()

@property (nonatomic, strong) VDRouterNavigationViewController *rootNavigationController;
@property (nonatomic, strong) NSMutableDictionary *registeredViewControllers;
@property (nonatomic, assign) BOOL isInitialized;

@end


@implementation VDRouter

#pragma mark Public Method
+ (VDRouter *)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [ [ [self class] alloc] init];
    } );
    
    return _sharedInstance;
}

+ (void)initializeWithAppDelegateWindow:(UIWindow *)appDelegateWindow {
    NSAssert(appDelegateWindow, @"appDelegateWindow can't be nil");
    appDelegateWindow.rootViewController = [self sharedInstance].rootNavigationController;
    [self sharedInstance].isInitialized = YES;
}

+ (void)setRootViewControllerIdentifier:(NSString *)rootViewControllerIdentifier {
    [[self sharedInstance] internalCheckInitialized];
    
    Class viewControllerClass = [[self sharedInstance].registeredViewControllers objectForKey:rootViewControllerIdentifier];
    NSAssert(viewControllerClass, @"rootViewControllerIdentifier must be binded with a ViewController's class");
    
    UIViewController *rootViewController = [[viewControllerClass alloc] init];
    [[self sharedInstance].rootNavigationController changeRootViewController:rootViewController];
}

+ (void)bindViewController:(Class)vcClass identifier:(NSString *)identifier {
    [[self sharedInstance].registeredViewControllers setObject:vcClass forKey:identifier];
}

+ (Class)findBindedViewControllerClass:(NSString *)identifier {
    return [[self sharedInstance].registeredViewControllers objectForKey:identifier];
}

+ (void)push:(NSString *)identifier {
    [[self sharedInstance] internalCheckInitialized];
    
    Class viewControllerClass = [[self sharedInstance].registeredViewControllers objectForKey:identifier];
    if (viewControllerClass) {
        UIViewController *targetViewController = [[viewControllerClass alloc] init];
        [[self sharedInstance].rootNavigationController pushViewController:targetViewController animated:YES];
    }
}

+ (void)present:(NSString *)identifier {
    [[self sharedInstance] internalCheckInitialized];
    
    Class viewControllerClass = [[self sharedInstance].registeredViewControllers objectForKey:identifier];
    if (viewControllerClass) {
        UIViewController *targetViewController = [[viewControllerClass alloc] init];
        [[UIViewController vd_topViewController] presentViewController:targetViewController animated:YES completion:NULL];
    }
}


#pragma mark Properties
- (VDRouterNavigationViewController *)rootNavigationController {
    if (!_rootNavigationController) {
        _rootNavigationController = [[VDRouterNavigationViewController alloc] init];
    }
    
    return _rootNavigationController;
}

- (NSMutableDictionary *)registeredViewControllers {
    if (!_registeredViewControllers) {
        _registeredViewControllers = [NSMutableDictionary new];
    }
    
    return _registeredViewControllers;
}

#pragma mark Overrides
- (instancetype)init {
    self = [super init];
    if (self) {
        [self internalInit];
    }
    
    return self;
}

- (void)dealloc {
    
}


#pragma mark Delegates


#pragma mark Private Method
- (void)internalInit {
    
}

- (void)internalCheckInitialized {
    NSAssert(self.isInitialized, @"VDRouter can't work without initialize");
}

@end
