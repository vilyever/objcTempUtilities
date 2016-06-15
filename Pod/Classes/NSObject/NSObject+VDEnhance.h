//
//  NSObject+VDEnhance.h
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (VDEnhance)

#pragma mark Public Method
+ (NSString *)vd_className;

- (void)vd_performActionDelay:(float)second action:(void (^)(void) )block;
- (void)vd_performSelector:(SEL)aSelector;
- (void)vd_performSelector:(SEL)aSelector withObject:(id)object;
- (void)vd_performSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2;
- (void)vd_performSelector:(SEL)aSelector withInteger:(NSInteger)integer;

@end

@interface VDWeakObjectCarrier : NSObject

@property (nonatomic, weak, readonly) id weakObject;

#pragma mark Public Method
+ (instancetype)carrierWithWeakObject:(id)object;

- (instancetype)initWithWeakObject:(id)object;

@end