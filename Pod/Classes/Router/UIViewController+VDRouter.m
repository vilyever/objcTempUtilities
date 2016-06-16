//
//  UIViewController+VDRouter.m
//  objcTempUtilities
//
//  Created by Deng on 16/6/16.
//  Copyright © Deng. All rights reserved.
//

#import "UIViewController+VDRouter.h"

#import <objc/runtime.h>


@implementation UIViewController (VDRouter)

#pragma mark Public Method
- (void)vd_setRouterParamsObject:(id)object forKey:(NSString *)key {
    [[self vd_routerParamsDictionary] setObject:object forKey:key];
}

- (id)vd_routerParamsObjectForKey:(NSString *)key {
    return [[self vd_routerParamsDictionary] objectForKey:key];
}

#pragma mark Properties
- (NSMutableDictionary *)vd_routerParamsDictionary {
    NSMutableDictionary *dictionary = objc_getAssociatedObject(self, @selector(vd_routerParamsDictionary));
    if (!dictionary) {
        dictionary = [NSMutableDictionary new];
        [self setVd_routerParamsDictionary:dictionary];
    }
    return dictionary;
}

- (void)setVd_routerParamsDictionary:(NSMutableDictionary *)vd_routerParamsDictionary {
    objc_setAssociatedObject(self, @selector(vd_routerParamsDictionary), vd_routerParamsDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark Private Method


@end
