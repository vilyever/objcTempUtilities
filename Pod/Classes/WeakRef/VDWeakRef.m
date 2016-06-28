//
//  VDWeakRef.m
//  objcTempUtilities
//
//  Created by Deng on 16/6/28.
//  Copyright © Deng. All rights reserved.
//

#import "VDWeakRef.h"


@interface VDWeakRef ()

@property (nonatomic, weak, readwrite) id object;

@end


@implementation VDWeakRef

#pragma mark Public Method
+ (instancetype)refWithObject:(id)object {
    VDWeakRef *ref = [self alloc];
    ref.object = object;
    return ref;
}

#pragma mark Properties


#pragma mark Overrides
- (void)dealloc {
    
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    invocation.target = self.object;
    [invocation invoke];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.object methodSignatureForSelector:sel];
}

- (NSString *)description {
    return [self.object description];
}

- (BOOL)isEqual:(id)object {
    return [object isEqual:self.object];
}


#pragma mark Delegates


#pragma mark Private Method

@end
