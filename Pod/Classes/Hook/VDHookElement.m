//
//  VDHookElement.m
//  objcTempUtilities
//
//  Created by Deng on 16/6/17.
//  Copyright © Deng. All rights reserved.
//

#import "VDHookElement.h"


@interface VDHookElement ()

@property (nonatomic, assign, readwrite) BOOL autoRemove;
@property (nonatomic, assign, readwrite) BOOL isDisposed;

@end


@implementation VDHookElement

#pragma mark Public Method
+ (instancetype)elementWithTarget:(id)target selector:(SEL)selector block:(void (^)(VDHookInvocationInfo *))block {
    return [self elementWithTarget:target selector:selector block:block autoRemove:NO];
}

+ (instancetype)elementWithTarget:(id)target selector:(SEL)selector block:(void (^)(VDHookInvocationInfo *))block autoRemove:(BOOL)autoRemove {
    VDHookElement *element = [[VDHookElement alloc] init];
    element.target = target;
    element.selector = selector;
    element.block = block;
    element.autoRemove = autoRemove;
    return element;
}

- (void)invokeBlock:(VDHookInvocationInfo *)invocationInfo {
    if (self.block) {
        self.block(invocationInfo);
    }
}

- (void)dispose {
    self.isDisposed = YES;
}

#pragma mark Properties


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

@end
