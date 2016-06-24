//
//  VDFingerPrintViewController.m
//  objcTempUtilities
//
//  Created by Deng on 16/6/16.
//  Copyright © Deng. All rights reserved.
//

#import "VDFingerPrintViewController.h"

#import <LocalAuthentication/LocalAuthentication.h>
#import "UIView+VDGesture.h"
#import "VDMacros.h"


NSString *const VDFingerPrintViewControllerLock = @"VDFingerPrintViewControllerLock";
NSString *const VDFingerPrintViewControllerUnlock = @"VDFingerPrintViewControllerUnlock";


@interface VDFingerPrintViewController ()

@property (nonatomic, assign) BOOL isShowing;

@property (nonatomic, assign) NSInteger registerCount;

@end


@implementation VDFingerPrintViewController

#pragma mark Public Method
- (void)registerLock {
    self.registerCount += 1;
}

- (void)unregisterLock {
    self.registerCount -= 1;
    self.registerCount = MAX(self.registerCount, 0);
}

- (void)show {
    if (!self.isShowing)
    {
        self.isShowing = YES;
        [VDWindow.rootViewController presentViewController:self animated:YES completion:NULL];
    }
}

- (void)check {
    if (!self.isShowing)
    {
        self.isShowing = YES;
        VDWeakifySelf;
        [VDWindow.rootViewController presentViewController:self animated:YES completion:^{
            VDStrongifySelf;
            [self internalCheckFingerPrint];
        }];
    }
    else {
        [self internalCheckFingerPrint];
    }
}

- (void)onFingerPrintNoSupport {
    
}

#pragma mark Properties
- (void)setIsLock:(BOOL)isLock {
    if (_isLock != isLock) {
        _isLock = isLock;
        if (_isLock) {
            [[NSNotificationCenter defaultCenter] postNotificationName:VDFingerPrintViewControllerLock object:nil];
        }
        else {
            [[NSNotificationCenter defaultCenter] postNotificationName:VDFingerPrintViewControllerUnlock object:nil];
        }
    }
}

#pragma mark Overrides
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self internalInit];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
}


#pragma mark IBActions


#pragma mark Delegates


#pragma mark Private Method
- (void)internalInit {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(internalAppWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(internalAppDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(internalAppWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(internalAppDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [self.view vd_performSelectorOnTapWithTarget:self selector:@selector(internalOnTap)];
}

- (void)internalAppWillResignActive:(NSNotification *)notification {
    if (self.registerCount <= 0) {
        return;
    }
    
    [self internalShow];
}

- (void)internalAppDidEnterBackground:(NSNotification *)notification {
    if (self.registerCount <= 0) {
        return;
    }
    
    self.isLock = YES;
    [self internalShow];
}

- (void)internalAppWillEnterForeground:(NSNotification *)notification {
    if (self.registerCount <= 0) {
        return;
    }
    
    [self internalCheckFingerPrint];
}

- (void)internalAppDidBecomeActive:(NSNotification *)notification {
    if (self.registerCount <= 0) {
        return;
    }
    
    if (self.isShowing && !self.isLock)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        self.isShowing = NO;
    }
}

- (void)internalOnTap {
    if (self.isLock) {
        [self internalCheckFingerPrint];
    }
}

- (void)internalShow {
    if (self.registerCount <= 0) {
        return;
    }
    
    if (!self.isShowing)
    {
        self.isShowing = YES;
        [VDWindow.rootViewController presentViewController:self animated:YES completion:NULL];
    }
}

- (void)internalCheckFingerPrint
{
    self.isLock = YES;
    
    LAContext *context = [ [LAContext alloc] init];
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:NULL])
    {
        VDWeakifySelf;
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:self.checkReason reply:^(BOOL success, NSError *error) {
            VDStrongifySelf;
            if (success)
            {
                [self dismissViewControllerAnimated:YES completion:NULL];
                self.isShowing = NO;
                self.isLock = NO;
            }
        }];
    }
    else {
        [self onFingerPrintNoSupport];
    }
}

@end
