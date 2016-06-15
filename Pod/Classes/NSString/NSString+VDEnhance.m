//
//  NSString+VDEnhance.m
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import "NSString+VDEnhance.h"

//#import <objc/runtime.h>


@implementation NSString (VDEnhance)

#pragma mark Public Method
+ (NSString *)vd_stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息 +0000。
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss GMT+0800"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

+ (NSString *)vd_stringFromSeconds:(NSInteger)seconds prefix:(NSString *)prefix
{
    NSInteger hours = 0;
    NSInteger minutes = 0;
    
    hours = seconds / 3600;
    minutes = (seconds - hours * 3600) / 60;
    seconds = seconds - hours * 3600 - minutes * 60;
    
    NSString *formatter = hours < 10 ? @"0%d" : @"%d";
    NSString *strHour = [NSString stringWithFormat:formatter, hours];
    
    formatter = minutes < 10 ? @"0%d" : @"%d";
    NSString *strMinute = [NSString stringWithFormat:formatter, minutes];
    
    formatter = seconds < 10 ? @"0%d" : @"%d";
    NSString *strSecond = [NSString stringWithFormat:formatter, seconds];
    
    return [NSString stringWithFormat:@"%@%@:%@:%@", prefix, strHour, strMinute, strSecond];
}

- (BOOL)vd_isEmptyIncludeSpaces
{
    if (self.length == 0)
    {
        return YES;
    }
    
    NSString *regex = @"^\\s*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (NSInteger)vd_integerValue:(NSInteger)defaultValue
{
    if ( [self vd_isEmptyIncludeSpaces] )
    {
        return defaultValue;
    }
    
    return [self integerValue];
}

- (BOOL)vd_boolValue:(NSString *)defaultYesValue
{
    if ( [self vd_isEmptyIncludeSpaces] )
    {
        return NO;
    }
    
    if (!defaultYesValue) {
        defaultYesValue = @"YES";
    }
    
    return [self caseInsensitiveCompare:defaultYesValue] == NSOrderedSame;
}

- (NSDate *)vd_dateValue
{
    NSDateFormatter *dateFormatter = [ [NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *destDate= [dateFormatter dateFromString:self];
    
    return destDate;
}

- (NSString *)vd_cleanExcessSpace
{
    NSCharacterSet *whiteSpaces = [NSCharacterSet whitespaceCharacterSet];
    NSPredicate *noEmptyString = [NSPredicate predicateWithFormat:@"SELF != ''"];
    
    NSArray *parts = [self componentsSeparatedByCharactersInSet:whiteSpaces];
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyString];
    return [filteredArray componentsJoinedByString:@" "];
}

- (CGRect)vd_frameWithFont:(UIFont *)font withMaxBoundsWidth:(float)width
{
    if (!font || width <= 0)
    {
        return CGRectZero;
    }
    NSDictionary *attributes = @{NSFontAttributeName : font};
    CGRect textFrame = [self boundingRectWithSize:CGSizeMake(width, HUGE_VALF) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:attributes context:nil];
    return textFrame;
}

- (CGRect)vd_frameWithFont:(UIFont *)font withMaxBoundsWidth:(float)width withLineBreakMode:(NSLineBreakMode)lineBreakMode
{
    if (!font || width <= 0)
    {
        return CGRectZero;
    }
    NSMutableParagraphStyle *paragraphStyle = [ [NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = lineBreakMode;
    NSDictionary *attributes = @{NSFontAttributeName : font,
                                 NSParagraphStyleAttributeName : paragraphStyle};
    CGRect textFrame = [self boundingRectWithSize:CGSizeMake(width, HUGE_VALF) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:attributes context:nil];
    return textFrame;
}

- (UIFont *)vd_fixFontWithFont:(UIFont *)font withMaxBoundsSize:(CGSize)boundsSize
{
    if (!font || CGSizeEqualToSize(boundsSize, CGSizeZero))
    {
        return nil;
    }
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGRect textFrame = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    if (textFrame.size.width > (boundsSize.width - 1.0f) || textFrame.size.height > boundsSize.height)
    {
        NSDictionary *nextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:(font.pointSize - 0.1f) ] };
        CGRect nextTextFrame = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:nextAttributes context:nil];
        
        if (nextTextFrame.size.width > (boundsSize.width - 1.0f) || nextTextFrame.size.height > boundsSize.height)
        {
            return [self vd_fixFontWithFont:[UIFont systemFontOfSize:(font.pointSize - 0.1f) ] withMaxBoundsSize:boundsSize];
        }
        else
        {
            return font;
        }
    }
    else
    {
        NSDictionary *nextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:(font.pointSize + 0.1f) ] };
        CGRect nextTextFrame = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:nextAttributes context:nil];
        
        if (nextTextFrame.size.width <= (boundsSize.width + 1.0f) && nextTextFrame.size.height <= boundsSize.height)
        {
            return [self vd_fixFontWithFont:[UIFont systemFontOfSize:(font.pointSize + 0.1f) ] withMaxBoundsSize:boundsSize];
        }
        else
        {
            return font;
        }
    }
}

#pragma mark Private Method


@end
