//
//  VDFingerPrintViewController.h
//  objcTempUtilities
//
//  Created by Deng on 16/6/16.
//  Copyright © Deng. All rights reserved.
//

#import <UIKit/UIKit.h>


extern NSString *const VDFingerPrintViewControllerLock;
extern NSString *const VDFingerPrintViewControllerUnlock;

@class VDFingerPrintViewController;

@interface VDFingerPrintViewController : UIViewController

#pragma mark Public Method
- (void)registerLock;
- (void)unregisterLock;
- (void)show;
- (void)check;

- (void)onFingerPrintNoSupport;

#pragma mark Properties
@property (nonatomic, assign) BOOL isLock;
@property (nonatomic, copy) NSString *checkReason;

@end
