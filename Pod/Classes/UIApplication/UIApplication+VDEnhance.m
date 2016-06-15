//
//  UIApplication+VDEnhance.m
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import "UIApplication+VDEnhance.h"

//#import <objc/runtime.h>


@implementation UIApplication (VDEnhance)

#pragma mark Public Method
+ (void)vd_clearNotifications
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

+ (UIView *)vd_statusBar
{
    NSString *key = [ [NSString alloc] initWithData:[NSData dataWithBytes:(unsigned char [] ){0x73, 0x74, 0x61, 0x74, 0x75, 0x73, 0x42, 0x61, 0x72} length:9] encoding:NSASCIIStringEncoding];
    
    id object = [UIApplication sharedApplication];
    
    UIView *statusBar;
    
    if ([object respondsToSelector:NSSelectorFromString(key) ] )
    {
        statusBar = [object valueForKey:key];
    }
    
    return statusBar;
}

#pragma mark Private Method


@end
