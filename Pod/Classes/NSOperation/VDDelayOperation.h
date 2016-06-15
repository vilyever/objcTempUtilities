//
//  VDDelayOperation.h
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import <Foundation/Foundation.h>


@class VDDelayOperation;


@interface VDDelayOperation : NSOperation

#pragma mark Public Method
- (instancetype)initWithTarget:(id)target selector:(SEL)sel delay:(NSTimeInterval)delayInterval onMain:(BOOL)onMain;
- (instancetype)initWithBlock:(void(^)(void))block delay:(NSTimeInterval)delayInterval onMain:(BOOL)onMain;

#pragma mark Properties


@end
