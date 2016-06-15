//
//  NSString+VDJavaScript.m
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import "NSString+VDJavaScript.h"

//#import <objc/runtime.h>


@implementation NSString (VDJavaScript)

#pragma mark Public Method
+ (NSString *)vd_javaScriptGetHtml
{
    return [ [NSString alloc]initWithFormat:@"document.getElementsByTagName('html')[0].innerHTML"];
}

+ (NSString *)vd_javaScriptTextScale:(float)scale
{
    return [ [NSString alloc]initWithFormat:@"document.body.style.webkitTextSizeAdjust='%d%%'", (int)(100 * scale) ];
}

/**
 *  resize image size to fit current content
 *
 *  @param maxWidth     max width, the height will be auto resize by
 *  @param functionName a name for call, like xxx() , the brackets is necessary
 *
 *  @return a string use for stringByEvaluatingJavaScriptFromString
 */
+ (NSString *)vd_javaScriptImageMaxWidth:(float)maxWidth functionName:(NSString *)functionName
{
    return [ [NSString alloc]initWithFormat:   @"var script = document.createElement('script');"
            "script.type = 'text/javascript';"
            "script.text = \"function %@ { "
            "var myimg,oldwidth;"
            "var maxwidth=%d;" //缩放
            "for(i=0;i <document.images.length;i++){"
            "myimg = document.images[i];"
            "if(myimg.width > maxwidth){"
            "oldwidth = myimg.width;"
            "myimg.style.width = '%dpx';"
            "myimg.style.height = 'auto';"
            "}"
            "}"
            "}\";"
            "document.getElementsByTagName('head')[0].appendChild(script);", functionName, (int)maxWidth, (int)maxWidth];
}

+ (NSString *)vd_javaScriptImageRenameWithPrefix:(NSString *)prefix functionName:(NSString *)functionName
{
    return [ [NSString alloc]initWithFormat:   @"var script = document.createElement('script');"
            "script.type = 'text/javascript';"
            "script.text = \"function %@ { "
            "for(i=0;i <document.images.length;i++){"
            "myimg = document.images[i];"
            "myimg.src = '%@' + myimg.src.substring(7, myimg.src.length)"
            "}"
            "}\";"
            "document.getElementsByTagName('head')[0].appendChild(script);", functionName, prefix];
}

- (NSString *)vd_replaceAllHtmlCharacters
{
    NSString *result = [self stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    result = [result stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    result = [result stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    result = [result stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    
    return result;
}

#pragma mark Private Method


@end
