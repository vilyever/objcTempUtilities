//
//  VDHook.h
//  objcTempUtilities
//
//  Created by Deng on 16/6/16.
//  Copyright © Deng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VDHookRecorder.h"
#import "VDHookInvocationInfo.h"

@class VDHook;


@interface VDHook : NSObject

#pragma mark Public Method
+ (VDHook *)sharedInstance;

+ (VDHookElement *)hookInstance:(id)instance selector:(SEL)selector beforeBlock:(void (^)(VDHookInvocationInfo *))block;
+ (VDHookElement *)hookInstance:(id)instance selector:(SEL)selector insteadBlock:(void (^)(VDHookInvocationInfo *))block;
+ (VDHookElement *)hookInstance:(id)instance selector:(SEL)selector afterBlock:(void (^)(VDHookInvocationInfo *))block;

+ (VDHookElement *)hookInstance:(id)instance selector:(SEL)selector beforeBlock:(void (^)(VDHookInvocationInfo *))block autoRemove:(BOOL)autoRemove;
+ (VDHookElement *)hookInstance:(id)instance selector:(SEL)selector insteadBlock:(void (^)(VDHookInvocationInfo *))block autoRemove:(BOOL)autoRemove;
+ (VDHookElement *)hookInstance:(id)instance selector:(SEL)selector afterBlock:(void (^)(VDHookInvocationInfo *))block autoRemove:(BOOL)autoRemove;

//+ (VDHookElement *)hookClass:(Class)clazz selector:(SEL)selector beforeBlock:(void (^)(VDHookInvocationInfo *))block;
//+ (VDHookElement *)hookClass:(Class)clazz selector:(SEL)selector insteadBlock:(void (^)(VDHookInvocationInfo *))block;
//+ (VDHookElement *)hookClass:(Class)clazz selector:(SEL)selector afterBlock:(void (^)(VDHookInvocationInfo *))block;
//
//+ (VDHookElement *)hookClass:(Class)clazz selector:(SEL)selector beforeBlock:(void (^)(VDHookInvocationInfo *))block autoRemove:(BOOL)autoRemove;
//+ (VDHookElement *)hookClass:(Class)clazz selector:(SEL)selector insteadBlock:(void (^)(VDHookInvocationInfo *))block autoRemove:(BOOL)autoRemove;
//+ (VDHookElement *)hookClass:(Class)clazz selector:(SEL)selector afterBlock:(void (^)(VDHookInvocationInfo *))block autoRemove:(BOOL)autoRemove;

#pragma mark Properties


@end
