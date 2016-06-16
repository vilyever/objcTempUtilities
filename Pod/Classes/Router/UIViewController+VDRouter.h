//
//  UIViewController+VDRouter.h
//  objcTempUtilities
//
//  Created by Deng on 16/6/16.
//  Copyright © Deng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (VDRouter)

#pragma mark Public Method
- (void)vd_setRouterParamsObject:(id)object forKey:(NSString *)key;
- (id)vd_routerParamsObjectForKey:(NSString *)key;

@end
