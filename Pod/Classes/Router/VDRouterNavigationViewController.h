//
//  VDRouterNavigationViewController.h
//  Ever
//
//  Created by FTET on 16/6/13.
//  Copyright © 2016年 vilyever. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIViewController+VDRouter.h"


@class VDRouterNavigationViewController;

@interface VDRouterNavigationViewController : UINavigationController

#pragma mark Public Method
- (void)changeRootViewController:(UIViewController *)controller;

#pragma mark Properties

@end
