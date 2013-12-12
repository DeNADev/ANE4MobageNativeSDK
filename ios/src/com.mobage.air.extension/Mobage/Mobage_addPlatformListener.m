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

#import "Mobage_addPlatformListener.h"
#import "AppDelegatePatch.h"

static Mobage_addPlatformListener *_listener = nil;

@interface Mobage_addPlatformListener()<MBGPlatformDelegate>

FREObject ANE4MBG_Mobage_addPlatformListener(FREContext cxt,
                                             void* functionData,
                                             uint32_t argc,
                                             FREObject argv[]);

@end

@implementation Mobage_addPlatformListener

#pragma mark - Initializer
+ (void)initialize {
    LOG_METHOD;
    if (!_listener) {
        [AppDelegatePatch initialize];
        _listener = [[Mobage_addPlatformListener alloc] init];
    }
}

+ (void)ContextInitializer:(FunctionSets *)funcSets {
    LOG_METHOD;
    [funcSets addFuncSet:@"ANE4MBG_Mobage_addPlatformListener"
                 pointer:&ANE4MBG_Mobage_addPlatformListener];
}

#pragma mark - MBGPlatformDelegate
- (void) onSplashComplete {
    LOG_METHOD;
    FREContext context = [ContextOwner sharedContext];
    FREResult result = TCDispatch(context,
                                @"PlatformListener.onSplashComplete",
                                nil);
    
    if(result != FRE_OK) {
        [ArgsParser reportResult:result];
    };
}
- (void) onLoginRequired {
    LOG_METHOD;
    FREContext context = [ContextOwner sharedContext];
    FREResult result = TCDispatch(context,
                                @"PlatformListener.onLoginRequired",
                                nil);
    
    if(result != FRE_OK) {
        [ArgsParser reportResult:result];
    };
}
- (void) onLoginComplete:(NSString *)userId {
    LOG_METHOD;
    FREContext context = [ContextOwner sharedContext];
    FREResult result = TCDispatch(context,
                                @"PlatformListener.onLoginComplete",
                                userId);
    
    if(result != FRE_OK) {
        [ArgsParser reportResult:result];
    };
}
- (void) onLoginCancel {
    LOG_METHOD;
    FREContext context = [ContextOwner sharedContext];
    FREResult result = TCDispatch(context,
                                @"PlatformListener.onLoginCancel",
                                nil);
    
    if(result != FRE_OK) {
        [ArgsParser reportResult:result];
    };
}
- (void) onLoginError:(MBGError *)error {
    LOG_METHOD;
    FREContext context = [ContextOwner sharedContext];
    FREResult result = TCDispatch(context,
                                @"PlatformListener.onLoginError",
                                error);

    if(result != FRE_OK) {
        [ArgsParser reportResult:result];
    };
}

+ (void)handleReceive:(NSDictionary *)userInfo {
    LOG_METHOD;
    FREContext context = [ContextOwner sharedContext];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    [dic setValue:@"com.mobage.air.social.common.RemoteNotificationPayload_iOS" forKey:@".class"];
    
    FREResult result = TCDispatch(context,
                                @"PlatformListener.handleReceive_iOS",
                                dic);
    
    if(result != FRE_OK) {
        [ArgsParser reportResult:result];
    };
}

@end

#pragma mark - ANE
FREObject ANE4MBG_Mobage_addPlatformListener(FREContext cxt,
                                             void* functionData,
                                             uint32_t argc,
                                             FREObject argv[]) {
    LOG_METHOD;
    MBGPlatform *platform = [MBGPlatform sharedPlatform];
    [platform setDelegate:_listener];
    return NULL;
}