//
//  VDHookInvocationInfo.h
//  objcTempUtilities
//
//  Created by Deng on 16/6/17.
//  Copyright © Deng. All rights reserved.
//

#import <Foundation/Foundation.h>


@class VDHookInvocationInfo;


@interface VDHookInvocationInfo : NSObject

#pragma mark Public Method
+ (instancetype)infoWithInvocation:(NSInvocation *)invocation;

- (void)getOriginalReturnValue:(void *)valuePtr;
- (void)setReturnValue:(void *)valuePtr;
- (void)getArgument:(void *)argumentLocation atIndex:(NSInteger)idx;
- (id)getArgumentAtIndex:(NSInteger)idx;
- (NSString *)getStringArgumentAtIndex:(NSInteger)idx;
- (NSInteger)getIntegerArgumentAtIndex:(NSInteger)idx;
- (int)getIntArgumentAtIndex:(NSInteger)idx;
- (BOOL)getBoolArgumentAtIndex:(NSInteger)idx;
- (float)getFloatArgumentAtIndex:(NSInteger)idx;
- (double)getDoubleArgumentAtIndex:(NSInteger)idx;
- (char)getCharArgumentAtIndex:(NSInteger)idx;
- (long)getLongArgumentAtIndex:(NSInteger)idx;
- (SEL)getSELArgumentAtIndex:(NSInteger)idx;

#pragma mark Properties
@property (nonatomic, strong) NSInvocation *invocation;

@end
