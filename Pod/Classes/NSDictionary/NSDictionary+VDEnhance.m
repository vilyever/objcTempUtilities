//
//  NSDictionary+VDEnhance.m
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import "NSDictionary+VDEnhance.h"

//#import <objc/runtime.h>


@implementation NSDictionary (VDEnhance)

#pragma mark Public Method
+ (NSDictionary *)vd_dictionaryWithDictionary:(NSDictionary *)firstDictionary mergeWithDictionary:(NSDictionary *)secondDictionary
{
    NSMutableDictionary *resultDictionary = [NSMutableDictionary dictionaryWithDictionary:firstDictionary];
    
    [secondDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (![firstDictionary objectForKey:key] )
        {
            [resultDictionary setObject:obj forKey:key];
        }
    } ];
    
    return [NSDictionary dictionaryWithDictionary:resultDictionary];
}

+ (NSDictionary *)vd_switchKeyObjectWithDictionary:(NSDictionary *)dictionary
{
    NSMutableDictionary *resultDictionary = [NSMutableDictionary dictionaryWithCapacity:dictionary.count];
    
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [resultDictionary setObject:key forKey:obj];
    } ];
    
    return [NSDictionary dictionaryWithDictionary:resultDictionary];
}

#pragma Public Instance Method
- (NSDictionary *)vd_mergeWithDictionary:(NSDictionary *)dictionary
{
    return [self.class vd_dictionaryWithDictionary:self mergeWithDictionary:dictionary];
}

- (NSDictionary *)vd_switchKeyObject
{
    return [self.class vd_switchKeyObjectWithDictionary:self];
}


#pragma mark Private Method


@end
