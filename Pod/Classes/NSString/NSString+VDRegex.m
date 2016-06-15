//
//  NSString+VDRegex.m
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import "NSString+VDRegex.h"

//#import <objc/runtime.h>


@implementation NSString (VDRegex)

#pragma mark Public Method
- (BOOL)vd_isRegexMatched:(NSString *)regex
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}


#pragma mark Private Method


@end
