//
//  VDDelayOperation.m
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import "VDDelayOperation.h"


@interface VDDelayOperation ()

@property (nonatomic, assign) BOOL onMain;

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, assign) NSTimeInterval delayInterval;

@property (nonatomic, copy) void(^delayBlock)(void);

@end


@implementation VDDelayOperation

#pragma mark Public Method
- (instancetype)initWithTarget:(id)target selector:(SEL)sel delay:(NSTimeInterval)delayInterval onMain:(BOOL)onMain
{
    self = [self init];
    
    self.target = target;
    self.selector = sel;
    self.delayInterval = delayInterval;
    self.onMain = onMain;
    
    return self;
}

- (instancetype)initWithBlock:(void(^)(void))block delay:(NSTimeInterval)delayInterval onMain:(BOOL)onMain
{
    self = [self init];
    
    self.delayBlock = [block copy];
    self.delayInterval = delayInterval;
    self.onMain = onMain;
    
    return self;
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

- (void)main
{
    [super main];
    
    
    [NSThread sleepForTimeInterval:self.delayInterval];
    
    if (self.isCancelled)
    {
        return;
    }
    
    if (self.onMain)
    {
        [self performSelectorOnMainThread:@selector(excute) withObject:nil waitUntilDone:YES];
    }
    else
    {
        [self excute];
    }
    
}


#pragma mark Delegates


#pragma mark Private Method
- (void)internalInit {
    
}

- (void)excute
{
    if (self.target && self.selector)
    {
        ( (void (*)(id, SEL) )[self methodForSelector:self.selector] )(self, self.selector);
    }
    else if (self.delayBlock)
    {
        self.delayBlock();
    }
}

@end
