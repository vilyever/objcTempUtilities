//
//  AppDelegate.m
//  objcTempUtilities
//
//  Created by FTET on 16/6/7.
//  Copyright © 2016年 vilyever. All rights reserved.
//

#import "AppDelegate.h"
#import "VDHook.h"

#import <objc/runtime.h>
#import "Aspects.h"
#import "VDMacros.h"

#include <dlfcn.h>

@interface AppDelegate ()

@property (nonatomic, assign) int test;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    NSLog(@"self.class %p", self.class);
//    NSLog(@"self.class %@", self.class);
//    NSLog(@"objc_getClass(self) %p", object_getClass(self));
//    NSLog(@"objc_getClass(self) %@", object_getClass(self));
//    NSLog(@"[object_getClass(self) class] %p", [object_getClass(self) class]);
//    NSLog(@"[object_getClass(self) class] %@", [object_getClass(self) class]);
//    
//    
//    self.test = 1;
//    [self addObserver:self forKeyPath:VDKeyPath(self, test) options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
//    self.test = 2;
//
//    NSLog(@"self.class %p", self.class);
//    NSLog(@"self.class %@", self.class);
//    NSLog(@"objc_getClass(self) %p", object_getClass(self));
//    NSLog(@"objc_getClass(self) %@", object_getClass(self));
//    NSLog(@"[object_getClass(self) class] %p", [object_getClass(self) class]);
//    NSLog(@"[object_getClass(self) class] %@", [object_getClass(self) class]);
    
//    [self testtt];
//    
//    
//    [VDHook hookInstance:self selector:@selector(testtt) beforeBlock:^(VDHookInvocationInfo *info) {
//        NSLog(@"before");
//    }];
//    [self testtt];
//
//    [VDHook hookInstance:self selector:@selector(testtt) insteadBlock:^(VDHookInvocationInfo *info) {
//        NSLog(@"instead");
//    }];
//    [self testtt];
    
//    [self aspect_hookSelector:@selector(testtt) withOptions:AspectPositionAfter usingBlock:^{
//        NSLog(@"aspect");
//    } error:NULL];

    [VDHook hookInstance:self selector:@selector(testtt:) afterBlock:^(VDHookInvocationInfo *info) {
        NSInteger x;
        [info getArgument:&x atIndex:0];
        NSString *result;
        [info getOriginalReturnValue:&result];
        
        NSLog(@"after %@ , %@, %d", @(x), result, [info getIntegerArgumentAtIndex:0]);
    } autoRemove:YES];
    [VDHook hookInstance:self selector:@selector(testtt:) beforeBlock:^(VDHookInvocationInfo *info) {
        NSInteger x;
        [info getArgument:&x atIndex:0];
        NSString *result;
        [info getOriginalReturnValue:&result];
        NSLog(@"before %@, %@", @(x), result);
    }];
    
    self.test = 1;
    [self addObserver:self forKeyPath:VDKeyPath(self, test) options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    self.test = 2;

    
    [self testtt:99];
    [self testtt:11];
    
//    self.test = 3;
//    
//    NSLog(@"self.class %p", self.class);
//    NSLog(@"self.class %@", self.class);
//    NSLog(@"objc_getClass(self) %p", object_getClass(self));
//    NSLog(@"objc_getClass(self) %@", object_getClass(self));
//    NSLog(@"[object_getClass(self) class] %p", [object_getClass(self) class]);
//    NSLog(@"[object_getClass(self) class] %@", [object_getClass(self) class]);
    
    
//    SEL selector = @selector(forwardInvocation:);
//    NSLog(@"selecor %@", NSStringFromSelector(selector));
//    Method targetMethod = class_getInstanceMethod([self class], selector);
//    IMP targetMethodIMP = method_getImplementation(targetMethod);
//    Dl_info dlInfo;
//    if (dladdr(targetMethodIMP, &dlInfo)) {
//        NSString *symbol = [NSString stringWithUTF8String:dlInfo.dli_sname];
//        NSLog(@"imp %@", symbol);
//    }
    
    
    return YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    VDLog(@"kvo change %@", change);
}

- (NSString *)testtt:(NSInteger)x {
    NSLog(@"testtt %@", @(x));
    return @"lala";
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
