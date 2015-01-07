/**
 * The MIT License (MIT)
 * Copyright (c) 2013 DeNA Co., Ltd.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 **/

#import "AppDelegatePatch.h"

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#import "MBGPlatform.h"
#import "MBGRemoteNotificationPayload.h"

#import "Mobage_addPlatformListener.h"
#import "ArgsParser.h"

#pragma mark - IMPContainer
// In order to insert "IMP" in the "NSDictionary"
@interface IMPContainer : NSObject {
@public
	IMP methodPointer;
}
@end
@implementation IMPContainer

@end

#pragma mark - define
typedef BOOL(*BOOL_IMP_1ID)(id, SEL, id);
typedef BOOL(*BOOL_IMP_2ID)(id, SEL, id, id);
typedef BOOL(*BOOL_IMP_3ID)(id, SEL, id, id, id);
typedef BOOL(*BOOL_IMP_4ID)(id, SEL, id, id, id, id);
typedef void(*VOID_IMP_1ID)(id, SEL, id);
typedef void(*VOID_IMP_2ID)(id, SEL, id, id);
typedef void(*VOID_IMP_3ID)(id, SEL, id, id, id);
typedef void(*VOID_IMP_4ID)(id, SEL, id, id, id, id);

enum {
	APP_setDelegate,
	APP_PATCH_COUNT
};

static char* _applicationTargets[APP_PATCH_COUNT] = {
	"setDelegate:",
};

static IMP _appSupracedent[APP_PATCH_COUNT];

enum {
    DELEGATE_applicationDidBecomeActive,
    DELEGATE_didFinishLaunchingWithOptions,
//	DELEGATE_openURLSourceApplicationAnnotation,
	DELEGATE_didReceiveRemoteNotification,
//	DELEGATE_didRegisterForRemoteNotificationsWithDeviceToken,
	DELEGATE_PATCH_COUNT
};

static char* _applicationDelegateTargets[DELEGATE_PATCH_COUNT] = {
    "applicationDidBecomeActive:",
	"application:didFinishLaunchingWithOptions:",
//	"application:openURL:sourceApplication:annotation:",
	"application:didReceiveRemoteNotification:",
//	"application:didRegisterForRemoteNotificationsWithDeviceToken:",
};


static AppDelegatePatch *_appDelegatePatch = nil;

static BOOL method_swizzling(Class destClass, Class sourceClass, SEL selector, IMP *replacedIMP) {
    LOG_METHOD;
    Method patchMethod = class_getInstanceMethod(sourceClass, selector);
    Method defaultMethod = class_getInstanceMethod(destClass, selector);
    
    BOOL result = NO;
    
    *replacedIMP = defaultMethod ? method_getImplementation(defaultMethod) : NULL;
    if (defaultMethod) {
        IMP imp = method_getImplementation(patchMethod);
        method_setImplementation(defaultMethod, imp);
        result = YES;
    } else {
        IMP imp = method_getImplementation(patchMethod);
        const char *types = method_getTypeEncoding(patchMethod);
        result = class_addMethod(destClass, selector, imp, types);
    }

    return result;
}

static NSMutableDictionary *_PatchedDelegateIMPs = nil;

IMP getMethodImplementation(id obj, SEL sel);
IMP getMethodImplementation(id obj, SEL sel) {
    LOG_METHOD;
    
	NSDictionary *cd = [_PatchedDelegateIMPs objectForKey:NSStringFromClass([obj class])];
	if (cd) {
		IMPContainer *impContainer = [cd objectForKey:NSStringFromSelector(sel)];
		return impContainer ? impContainer->methodPointer : NULL;
	}
	return NULL;
}

#pragma mark -
// include UIApplicationDelegate protocol
@interface AppDelegatePatch()<UIApplicationDelegate>

@end

@implementation AppDelegatePatch
#pragma mark Notification listener method
+ (void)load {
    LOG_METHOD;
    
    @autoreleasepool {
		
		_PatchedDelegateIMPs = [[NSMutableDictionary alloc] initWithCapacity:1];
		
		for (int i = 0; i < APP_PATCH_COUNT; i++) {
			SEL swapSel = sel_getUid(_applicationTargets[i]);
            method_swizzling([UIApplication class],
                             self,
                             swapSel,
                             &_appSupracedent[i]);
            
		}
		
	}
}

+ (void)initialize {
    LOG_METHOD;
    if (!_appDelegatePatch) {
        _appDelegatePatch = [[AppDelegatePatch alloc] init];
    }
}

+ (AppDelegatePatch *)sharedAppDelegatePatch {
    return _appDelegatePatch;
}

#pragma mark - UIApplication Hook
- (void)setDelegate:(id)delegate {
    LOG_METHOD;
    
    if (delegate && ![_PatchedDelegateIMPs objectForKey:NSStringFromClass([delegate class])]) {
        NSMutableDictionary *classMethods = [[[NSMutableDictionary alloc] initWithCapacity:DELEGATE_PATCH_COUNT] autorelease];
		for (int i = 0; i < DELEGATE_PATCH_COUNT; i++) {
			SEL swapSel = sel_registerName(_applicationDelegateTargets[i]);
			IMPContainer *impDest = [[[IMPContainer alloc] init] autorelease];
			method_swizzling([delegate class],
                             [AppDelegatePatch class],
                             swapSel,
                             &(impDest->methodPointer));
			[classMethods setObject:impDest forKey:NSStringFromSelector(swapSel)];
		}
		[_PatchedDelegateIMPs setObject:classMethods forKey:NSStringFromClass([delegate class])];
    }
    
    VOID_IMP_1ID func = (VOID_IMP_1ID)_appSupracedent[APP_setDelegate];
	if (func) func(self, _cmd, delegate);
    
}

#pragma mark - UIAppDelegate Hook
- (void)applicationDidBecomeActive:(UIApplication *)application {
    LOG_METHOD;
    
    LOG(@"UIApplicationState : %ld", (long)[application applicationState]);
    if ([application applicationState] == UIApplicationStateActive) {
        VOID_IMP_1ID func = (VOID_IMP_1ID)getMethodImplementation(self, _cmd);
        if (func) func(self,_cmd,application);
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    LOG_METHOD;
    if ([launchOptions count] > 0) {
        _appDelegatePatch.launchOptions = launchOptions;
    }
    
    BOOL_IMP_2ID func = (BOOL_IMP_2ID)getMethodImplementation(self,_cmd);
	if (func) return func(self, _cmd, application, launchOptions);
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    LOG_METHOD;
    LOG(@"userInfo = %@", userInfo);
    
    MBGRemoteNotificationPayload *payload = [MBGRemoteNotificationPayload payload];
    payload.badge = [[userInfo valueForKeyPath:@"aps.badge"] integerValue];
    payload.message = [userInfo valueForKeyPath:@"aps.alert"] ? [userInfo valueForKeyPath:@"aps.alert"] : @"";
    payload.sound = [userInfo valueForKeyPath:@"aps.sound"] ? [userInfo valueForKeyPath:@"aps.sound"] : @"";
    if (((NSArray *)[userInfo valueForKey:@"x"]).count >= 3) {
        payload.extras = [[userInfo valueForKey:@"x"] objectAtIndex:3];
    } else {
        payload.extras = [NSDictionary dictionary];
    }
    
    NSString *state = @"";
    switch ([[UIApplication sharedApplication] applicationState]) {
        case UIApplicationStateActive:
            state = @"Active";
            break;
        case UIApplicationStateInactive:
            state = @"Inactive";
            break;
        case UIApplicationStateBackground:
        default:
            break;
    }
    
    NSMutableDictionary *payloadDic = [NSMutableDictionary dictionaryWithDictionary:[ArgsParser payloadToJSON:payload]];
    [payloadDic setObject:state forKey:@"state"];
    
    [Mobage_addPlatformListener handleReceive:payloadDic];
    
    
	VOID_IMP_2ID func = (VOID_IMP_2ID)getMethodImplementation(self, _cmd);
    if (func) func(self,_cmd,application,userInfo);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    LOG_METHOD;
    LOG(@"deviceToken = %@", deviceToken);
    
    [MBGPlatform registerForRemoteNotification:deviceToken];
    VOID_IMP_2ID func = (VOID_IMP_2ID)getMethodImplementation(self, _cmd);
	if (func) func(self, _cmd, application, deviceToken);
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    LOG_METHOD;
    LOG(@"url = %@", url);
    
    if (url && ([[[url scheme] lowercaseString] hasPrefix:@"mobage-jp"] || [[[url scheme] lowercaseString] hasPrefix:@"mobage-kr"])) {
        return [MBGPlatform handleOpenURL:url];
    }
    
    VOID_IMP_4ID func = (VOID_IMP_4ID)getMethodImplementation(self, _cmd);
    if (func) func(self, _cmd, application, url, sourceApplication, annotation);
    return YES;
}

@end


