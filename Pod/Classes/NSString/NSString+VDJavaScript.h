//
//  NSString+VDJavaScript.h
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (VDJavaScript)

#pragma mark Public Method
+ (NSString *)vd_javaScriptGetHtml;

+ (NSString *)vd_javaScriptTextScale:(float)scale;

/**
 *  resize image size to fit current content
 *
 *  @param maxWidth     max width, the height will be auto resize by
 *  @param functionName a name for call, like xxx() , the brackets is necessary
 *
 *  @return a string use for stringByEvaluatingJavaScriptFromString
 */
+ (NSString *)vd_javaScriptImageMaxWidth:(float)maxWidth functionName:(NSString *)functionName;

+ (NSString *)vd_javaScriptImageRenameWithPrefix:(NSString *)prefix functionName:(NSString *)functionName;

- (NSString *)vd_replaceAllHtmlCharacters;

@end
