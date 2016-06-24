//
//  NSObject+VDHook.h
//  objcTempUtilities
//
//  Created by Deng on 16/6/24.
//  Copyright © Deng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VDHook.h"

@interface NSObject (VDHook)

#pragma mark Public Method
- (VDHookElement *)vd_hookSelector:(SEL)selector beforeBlock:(void (^)(VDHookInvocationInfo *))block;
- (VDHookElement *)vd_hookSelector:(SEL)selector insteadBlock:(void (^)(VDHookInvocationInfo *))block;
- (VDHookElement *)vd_hookSelector:(SEL)selector afterBlock:(void (^)(VDHookInvocationInfo *))block;

- (VDHookElement *)vd_hookSelector:(SEL)selector beforeBlock:(void (^)(VDHookInvocationInfo *))block autoRemove:(BOOL)autoRemove;
- (VDHookElement *)vd_hookSelector:(SEL)selector insteadBlock:(void (^)(VDHookInvocationInfo *))block autoRemove:(BOOL)autoRemove;
- (VDHookElement *)vd_hookSelector:(SEL)selector afterBlock:(void (^)(VDHookInvocationInfo *))block autoRemove:(BOOL)autoRemove;

@end
