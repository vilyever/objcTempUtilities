//
//  VDWeakRef.h
//  objcTempUtilities
//
//  Created by Deng on 16/6/28.
//  Copyright © Deng. All rights reserved.
//

#import <Foundation/Foundation.h>


@class VDWeakRef;


@interface VDWeakRef : NSProxy

#pragma mark Public Method
+ (instancetype)refWithObject:(id)object;

#pragma mark Properties
@property (nonatomic, weak, readonly) id object;

@end
