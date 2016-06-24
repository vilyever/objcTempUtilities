//
//  VDHookRecorder.m
//  objcTempUtilities
//
//  Created by Deng on 16/6/16.
//  Copyright © Deng. All rights reserved.
//

#import "VDHookRecorder.h"
#import <objc/runtime.h>


@interface VDHookRecorder ()


@end


@implementation VDHookRecorder

#pragma mark Public Method
static char VDHookRecordersAssociatedObjectKey;
+ (VDHookRecorder *)recorderForTarget:(id)target selector:(SEL)selector {
    NSMutableDictionary *recorders = objc_getAssociatedObject(target, &VDHookRecordersAssociatedObjectKey);
    if (!recorders) {
        recorders = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(target, &VDHookRecordersAssociatedObjectKey, recorders, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    VDHookRecorder *recorder = [recorders objectForKey:NSStringFromSelector(selector)];
    if (!recorder) {
        recorder = [[VDHookRecorder alloc] init];
        [recorders setObject:recorder forKey:NSStringFromSelector(selector)];
    }
    return recorder;
}

- (void)addBeforeElement:(VDHookElement *)element {
    NSParameterAssert(element);
    [self.beforeElements addObject:element];
}

- (void)addInsteadElement:(VDHookElement *)element {
    NSParameterAssert(element);
    [self.insteadElements addObject:element];
}

- (void)addAfterElement:(VDHookElement *)element {
    NSParameterAssert(element);
    [self.afterElements addObject:element];
}

- (void)removeElement:(VDHookElement *)element {
    NSParameterAssert(element);
    [self.beforeElements removeObject:element];
    [self.insteadElements removeObject:element];
    [self.afterElements removeObject:element];
}

- (BOOL)hasElement {
    return self.beforeElements.count > 0 || self.insteadElements.count > 0 || self.afterElements.count > 0;
}

- (void)invokeBeforeElements:(VDHookInvocationInfo *)invocationInfo {
    [self internalInvokeElements:self.beforeElements invocationInfo:invocationInfo];
}

- (void)invokeInsteadElements:(VDHookInvocationInfo *)invocationInfo {
    [self internalInvokeElements:self.insteadElements invocationInfo:invocationInfo];
}

- (void)invokeAfterElements:(VDHookInvocationInfo *)invocationInfo {
    [self internalInvokeElements:self.afterElements invocationInfo:invocationInfo];
}

#pragma mark Properties
- (NSMutableArray *)beforeElements {
    if (!_beforeElements) {
        _beforeElements = [NSMutableArray new];
    }
    
    [self internalRemoveDisposedElements:_beforeElements];
    
    return _beforeElements;
}

- (NSMutableArray *)insteadElements {
    if (!_insteadElements) {
        _insteadElements = [NSMutableArray new];
    }
    
    [self internalRemoveDisposedElements:_insteadElements];
    
    return _insteadElements;
}

- (NSMutableArray *)afterElements {
    if (!_afterElements) {
        _afterElements = [NSMutableArray new];
    }
    
    [self internalRemoveDisposedElements:_afterElements];
    
    return _afterElements;
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

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, before:%@, instead:%@, after:%@>", self.class, self, self.beforeElements, self.insteadElements, self.afterElements];
}

#pragma mark Delegates


#pragma mark Private Method
- (void)internalInit {
    
}

- (void)internalRemoveDisposedElements:(NSMutableArray *)elements {
    NSMutableArray *willRemovedElements = [NSMutableArray new];
    for (VDHookElement *element in elements) {
        if (element.autoRemove || element.isDisposed) {
            [willRemovedElements addObject:element];
        }
    }
    
    if (willRemovedElements.count > 0) {
        [elements removeObjectsInArray:willRemovedElements];
    }
}

- (void)internalInvokeElements:(NSMutableArray *)elements invocationInfo:(VDHookInvocationInfo *)invocationInfo {
    NSMutableArray *willRemovedElements = [NSMutableArray new];
    for (VDHookElement *element in elements) {
        if (!element.isDisposed) {
            [element invokeBlock:invocationInfo];
        }
        
        if (element.autoRemove || element.isDisposed) {
            [willRemovedElements addObject:element];
        }
    }
    
    if (willRemovedElements.count > 0) {
        [elements removeObjectsInArray:willRemovedElements];
    }
}

@end
