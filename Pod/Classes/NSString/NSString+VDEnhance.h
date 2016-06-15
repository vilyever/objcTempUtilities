//
//  NSString+VDEnhance.h
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (VDEnhance)

#pragma mark Public Method
+ (NSString *)vd_stringFromDate:(NSDate *)date;
+ (NSString *)vd_stringFromSeconds:(NSInteger)seconds prefix:(NSString *)prefix;

- (BOOL)vd_isEmptyIncludeSpaces;

- (NSInteger)vd_integerValue:(NSInteger)defaultValue;

- (BOOL)vd_boolValue:(NSString *)defaultYesValue;

- (NSDate *)vd_dateValue;

- (NSString *)vd_cleanExcessSpace;

- (CGRect)vd_frameWithFont:(UIFont *)font withMaxBoundsWidth:(float)width;
- (CGRect)vd_frameWithFont:(UIFont *)font withMaxBoundsWidth:(float)width withLineBreakMode:(NSLineBreakMode)lineBreakMode;

- (UIFont *)vd_fixFontWithFont:(UIFont *)font withMaxBoundsSize:(CGSize)boundsSize;

@end
