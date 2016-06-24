//
//  VDHook.m
//  objcTempUtilities
//
//  Created by Deng on 16/6/16.
//  Copyright © Deng. All rights reserved.
//

#import "VDHook.h"

#import <objc/runtime.h>
#import <objc/message.h>
#include <dlfcn.h>


#if !VDHookInstanceSubclassSuffix
#define VDHookInstanceSubclassSuffix \
@"_vdhook_"
#endif

#if !VDHookSelectorPrefix
#define VDHookSelectorPrefix \
@"vdhook_"
#endif

#if !VDHookForwardInvocationSelectorName
#define VDHookForwardInvocationSelectorName \
@"__vdhook_forwardInvocation:"
#endif

#if !VDHookGetSwizzleSelector
#define VDHookGetSwizzleSelector(selector) \
NSSelectorFromString([NSString stringWithFormat:@"%@_%@", VDHookSelectorPrefix, NSStringFromSelector(selector)])
#endif


static void VDHookedForwardInvocationMethod(__unsafe_unretained NSObject *target, SEL selector, NSInvocation *invocation) {
    NSCParameterAssert(target);
    NSCParameterAssert(invocation);
    SEL originalSelector = invocation.selector;
    SEL swizzleSelector = VDHookGetSwizzleSelector(invocation.selector);
    invocation.selector = swizzleSelector;
    
    VDHookRecorder *recorder = [VDHookRecorder recorderForTarget:target selector:originalSelector];
    VDHookInvocationInfo *invocationInfo = [VDHookInvocationInfo infoWithInvocation:invocation];
    
    [recorder invokeBeforeElements:invocationInfo];
    
    if (recorder.insteadElements.count > 0) {
        [recorder invokeInsteadElements:invocationInfo];
    }
    else {
        Class clazz = object_getClass(invocation.target);
        do {
            if ([clazz instancesRespondToSelector:swizzleSelector]) {
                [invocation invoke];
                break;
            }
        } while ((clazz = class_getSuperclass(clazz)));
    }
    
    [recorder invokeAfterElements:invocationInfo];
}


@interface VDHook ()

@end


@implementation VDHook

#pragma mark Public Method
+ (VDHook *)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [ [ [self class] alloc] init];
    } );
    
    return _sharedInstance;
}

+ (VDHookElement *)hookInstance:(id)instance selector:(SEL)selector beforeBlock:(void (^)(VDHookInvocationInfo *))block {
    return [self hookInstance:instance selector:selector beforeBlock:block autoRemove:NO];
}

+ (VDHookElement *)hookInstance:(id)instance selector:(SEL)selector insteadBlock:(void (^)(VDHookInvocationInfo *))block {
    return [self hookInstance:instance selector:selector insteadBlock:block autoRemove:NO];
}

+ (VDHookElement *)hookInstance:(id)instance selector:(SEL)selector afterBlock:(void (^)(VDHookInvocationInfo *))block {
    return [self hookInstance:instance selector:selector afterBlock:block autoRemove:NO];
}

+ (VDHookElement *)hookInstance:(id)instance selector:(SEL)selector beforeBlock:(void (^)(VDHookInvocationInfo *))block autoRemove:(BOOL)autoRemove {
    VDHookElement *element = [VDHookElement elementWithTarget:instance selector:selector block:block autoRemove:autoRemove];
    [[VDHookRecorder recorderForTarget:instance selector:selector] addBeforeElement:element];
    [self internalHookInstance:instance selector:selector];
    return element;
}

+ (VDHookElement *)hookInstance:(id)instance selector:(SEL)selector insteadBlock:(void (^)(VDHookInvocationInfo *))block autoRemove:(BOOL)autoRemove {
    VDHookElement *element = [VDHookElement elementWithTarget:instance selector:selector block:block autoRemove:autoRemove];
    [[VDHookRecorder recorderForTarget:instance selector:selector] addInsteadElement:element];
    [self internalHookInstance:instance selector:selector];
    return element;
}

+ (VDHookElement *)hookInstance:(id)instance selector:(SEL)selector afterBlock:(void (^)(VDHookInvocationInfo *))block autoRemove:(BOOL)autoRemove {
    VDHookElement *element = [VDHookElement elementWithTarget:instance selector:selector block:block autoRemove:autoRemove];
    [[VDHookRecorder recorderForTarget:instance selector:selector] addAfterElement:element];
    [self internalHookInstance:instance selector:selector];
    return element;
}

#pragma mark Properties

#pragma mark Overrides
- (instancetype)init {
    self = [super init];
    if (self) {
        [self internalInit];
    }
    
    return self;
}

- (void)dealloc {
    
}


#pragma mark Delegates


#pragma mark Private Method
- (void)internalInit {
    
}

+ (void)internalHookInstance:(id)instance selector:(SEL)selector {
    Class hookClazz = [self internalHookClassForInstance:instance error:nil];
    
    Method targetMethod = class_getInstanceMethod(hookClazz, selector);
    IMP targetMethodIMP = method_getImplementation(targetMethod);
    
    // 是否hook过
    if (![self internalCheckIsHookedTarget:instance selector:selector]) {
        SEL swizzleSelector = VDHookGetSwizzleSelector(selector);
        
        NSCAssert(![hookClazz instancesRespondToSelector:swizzleSelector], @"Alias method name %@ to hook selctor %@ on %@ is being possessed", NSStringFromSelector(swizzleSelector),  NSStringFromSelector(selector), hookClazz);
        
        BOOL isHookedByOther = ![self internalCheckIsImp:targetMethodIMP fitSelector:selector];
        
        // 是否selector的实现imp被替换，若是，查找所有方法的实现imp尝试找出selector的原imp
        if (isHookedByOther) {
            targetMethod = nil;
            unsigned int methodsCount;
            Method *methods = class_copyMethodList(hookClazz, &methodsCount);
            while (methodsCount--) {
                Method method = methods[methodsCount];
                IMP imp = method_getImplementation(method);
                if ([self internalCheckIsImp:imp fitSelector:selector]) {
                    targetMethod = method;
                    break;
                }
            }
        }
        
        NSCAssert(targetMethod, @"Original implementation for %@ cannot find, maybe swizzle by others and no make a alias method on %@", NSStringFromSelector(selector), hookClazz);
        
        // 增加imp实现为selector的别名方法， selector方法的imp替换为消息转发_objc_msgForward
        const char *typeEncoding = method_getTypeEncoding(targetMethod);
        __unused BOOL added = class_addMethod(hookClazz, swizzleSelector, method_getImplementation(targetMethod), typeEncoding);
        NSCAssert(added, @"Original implementation for %@ is already copied to %@ on %@", NSStringFromSelector(selector), NSStringFromSelector(swizzleSelector), hookClazz);
        
        class_replaceMethod(hookClazz, selector, _objc_msgForward, typeEncoding);

        [self internalMarkHookedTarget:instance selector:selector];
    }
}

+ (Class)internalHookClassForInstance:(NSObject *)instance error:(NSError **)error {
    NSCParameterAssert(instance);
    Class statedClass = [instance class];
    Class baseClass = object_getClass(instance);
    NSString *className = NSStringFromClass(baseClass);
    
    // 已经hook成功
    if ([className hasSuffix:VDHookInstanceSubclassSuffix]) {
        return baseClass;
    }
    
    // kvo或其它工具已经对该instance的class进行过hook，直接使用该hook子类，防止crash
    if (statedClass != baseClass) {
        [self internalSwizzleForwardInvocation:baseClass];
        return baseClass;
    }
    
    // 创建一个子类，类名为当前类加上后缀
    const char *subclassName = [className stringByAppendingString:VDHookInstanceSubclassSuffix].UTF8String;
    Class subclass = objc_getClass(subclassName);
    
    // 若子类还未声明，动态声明
    if (subclass == nil) {
        // 创建类
        subclass = objc_allocateClassPair(baseClass, subclassName, 0);
        // 失败
        if (subclass == nil) {
            NSString *errrorDesc = [NSString stringWithFormat:@"objc_allocateClassPair failed to allocate class %s.", subclassName];
            NSLog(@"%@", errrorDesc);
            return nil;
        }
        
        // 替换消息转发方法 ForwardInvocatio 为自定义方法以便实现hook
        [self internalSwizzleForwardInvocation:subclass];
        // 替换subclass的class方法，使之返回当前instance的class
        [self internalHookClassMethodForClass:subclass replacedClass:statedClass];
        // 替换subclass的metaClass的class方法，使之返回当前instance的class，kvo中未如此做，暂时取消
//        [self internalHookClassMethodForClass:object_getClass(subclass) replacedClass:statedClass];
        objc_registerClassPair(subclass);
    }
    
    // 替换当前instance的class为subclass
    object_setClass(instance, subclass);
    return subclass;
}

+ (void)internalSwizzleForwardInvocation:(Class)clazz {
    NSCParameterAssert(clazz);
    if ([clazz instancesRespondToSelector:NSSelectorFromString(VDHookForwardInvocationSelectorName)]) {
        return;
    }
    
    // TODO:如果forwardInvocation:被hook过（e.g. Aspects)，可记录该hook实现，在VDHookedForwardInvocationMethod合理调用，暂时先直接替换。
    
    IMP originalImplementation = class_replaceMethod(clazz, @selector(forwardInvocation:), (IMP)VDHookedForwardInvocationMethod, "v@:@");
    if (originalImplementation) {
        class_addMethod(clazz, NSSelectorFromString(VDHookForwardInvocationSelectorName), originalImplementation, "v@:@");
    }
}

+ (void)internalUnswizzleForwardInvocation:(Class)clazz {
    NSCParameterAssert(clazz);
    Method hookedMethod = class_getInstanceMethod(clazz, NSSelectorFromString(VDHookForwardInvocationSelectorName));
    Method originalMethod = class_getInstanceMethod(NSObject.class, @selector(forwardInvocation:));
    // There is no class_removeMethod, so the best we can do is to retore the original implementation, or use a dummy.
    IMP originalImplementation = method_getImplementation(hookedMethod ?: originalMethod);
    class_replaceMethod(clazz, @selector(forwardInvocation:), originalImplementation, "v@:@");
}

+ (void)internalHookClassMethodForClass:(Class)clazz replacedClass:(Class)replacedClazz {
    NSCParameterAssert(clazz);
    NSCParameterAssert(replacedClazz);
    Method method = class_getInstanceMethod(clazz, @selector(class));
    IMP newIMP = imp_implementationWithBlock(^(id self) {
        return replacedClazz;
    });
    class_replaceMethod(clazz, @selector(class), newIMP, method_getTypeEncoding(method));
}

static char VDHookMarkDicAssociatedObjectKey;
+ (BOOL)internalCheckIsHookedTarget:(id)target selector:(SEL)selector {
    NSMutableDictionary *hookDic = objc_getAssociatedObject(target, &VDHookMarkDicAssociatedObjectKey);
    if (!hookDic) {
        hookDic = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(target, &VDHookMarkDicAssociatedObjectKey, hookDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    BOOL isHooked = [[hookDic objectForKey:NSStringFromSelector(selector)] boolValue];
    return isHooked;
}

+ (void)internalMarkHookedTarget:(id)target selector:(SEL)selector {
    NSMutableDictionary *hookDic = objc_getAssociatedObject(target, &VDHookMarkDicAssociatedObjectKey);
    if (!hookDic) {
        hookDic = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(target, &VDHookMarkDicAssociatedObjectKey, hookDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [hookDic setObject:@(YES) forKey:NSStringFromSelector(selector)];
}

+ (BOOL)internalCheckIsImp:(IMP)imp fitSelector:(SEL)selector {
    BOOL result = NO;
    Dl_info dlInfo;
    if (dladdr(imp, &dlInfo)) {
        NSString *symbol = [NSString stringWithUTF8String:dlInfo.dli_sname];
        
        if ([symbol rangeOfString:@"-["].location == 0) {
            symbol = [symbol substringFromIndex:2];
        }
        if ([symbol rangeOfString:@"]"].location == symbol.length - 1) {
            symbol = [symbol substringToIndex:symbol.length - 1];
        }
        
        NSArray *symbolComponents = [symbol componentsSeparatedByString:@" "];
        if (symbolComponents.count == 0) {
            NSString *selectorName = symbol;
            
            result = [NSStringFromSelector(selector) isEqualToString:selectorName];
        }
        else if (symbolComponents.count == 1) {
            NSString *selectorName = symbolComponents[0];
            
            result = [NSStringFromSelector(selector) isEqualToString:selectorName];
        }
        else if (symbolComponents.count == 2) {
            NSString *selectorName = symbolComponents[1];
            
            result = [NSStringFromSelector(selector) isEqualToString:selectorName];
        }
        else {
            result = NO;
        }
        
    }
    
    return result;
}

@end
