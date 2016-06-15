//
//  UIImage+VDEnhance.h
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (VDEnhance)

#pragma mark Public Method
+ (UIImage *)vd_loadImageWithFilePath:(NSString *)filePath withType:(NSString *)type;

+ (UIImage *)vd_imageWithColor:(UIColor *)color;

+ (UIImage *)vd_imageWithColor:(UIColor *)color withImageSize:(CGSize)size;

+ (UIImage *)vd_imageWithColor:(UIColor *)color withImageSize:(CGSize)size withCornerRadius:(float)cornerRadius;

+ (UIImage *)vd_resizeImage:(UIImage *)image withProportion:(CGFloat)proportion;

+ (UIImage *)vd_imageWithView:(UIView *)view;

@end
