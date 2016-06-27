//
//  VDRouter.h
//  Ever
//
//  Created by FTET on 16/6/13.
//  Copyright © 2016年 vilyever. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "UIViewController+VDEnhance.h"

#import "UIViewController+VDRouter.h"

#import "NSObject+VDEnhance.h"

@class VDRouter;


@interface VDRouter : NSObject

#pragma mark Public Method
+ (VDRouter *)sharedInstance;

+ (void)setRootViewControllerIdentifier:(NSString *)rootViewControllerIdentifier;

+ (void)bindViewController:(Class)vcClass identifier:(NSString *)identifier;
+ (Class)findBindedViewControllerClass:(NSString *)identifier;

+ (UIViewController *)push:(NSString *)identifier;
+ (UIViewController *)push:(NSString *)identifier withPrepareBlock:(void(^)(UIViewController *controller))block;
+ (UIViewController *)present:(NSString *)identifier;
+ (UIViewController *)present:(NSString *)identifier withPrepareBlock:(void(^)(UIViewController *controller))block;

#pragma mark Properties


@end
