//
//  NSString+VDRegex.h
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import <Foundation/Foundation.h>

// check ip regex e.g. 192.168.1.1
#define VDRegexIP \
[NSString stringWithFormat:@"^(25[0-5]|2[0-4][0-9]|1{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|1{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|1{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|1{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$"]

// check port regex 0-65535
#define VDRegexPort \
[NSString stringWithFormat:@"^6553[0-5]|655[0-2][0-9]|65[0-4][0-9]{2}|6[0-4][0-9]{3}|[1-5][0-9]{4}|[1-9][0-9]{0,3}$"]

// check chinese name regex, 2-15 chinese character
#define VDRegexChineseName \
[NSString stringWithFormat:@"^[\\u4e00-\\u9fa5]{2,15}$"]

// check chinese cell number and tel number e.g. 83238832 13177881122
#define VDRegexPhoneNumberInChina \
[NSString stringWithFormat:@"^(((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8})|((\\d{3,4}-)?\\d{7,8}(-\\d{1,4})?)$"]

// check only has letter number and underscore e.g. hello_1
#define VDRegexRegularCharacter(MinSize, MaxSize) \
[NSString stringWithFormat:@"^\\w{%d,%d}$", MinSize, MaxSize]


@interface NSString (VDRegex)

#pragma mark Public Method
- (BOOL)vd_isRegexMatched:(NSString *)regex;

@end
