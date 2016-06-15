//
//  NSDictionary+VDEnhance.h
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (VDEnhance)

#pragma mark Public Method
+ (NSDictionary *)vd_dictionaryWithDictionary:(NSDictionary *)firstDictionary mergeWithDictionary:(NSDictionary *)secondDictionary;
+ (NSDictionary *)vd_switchKeyObjectWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)vd_mergeWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)vd_switchKeyObject;

@end
