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

#import "common_RemoteNotification_setListener.h"
#import <UIKit/UIKit.h>
#import "AppDelegatePatch.h"
#import "Mobage_addPlatformListener.h"

@interface common_RemoteNotification_SetListener()
FREObject ANE4MBG_social_common_RemoteNotification_setListener(FREContext cxt,
                                                               void* functionData,
                                                               uint32_t argc,
                                                               FREObject argv[]);
@end

@implementation common_RemoteNotification_SetListener
+ (void)ContextInitializer:(FunctionSets *)funcSets {
    LOG_METHOD;
    [funcSets addFuncSet:@"ANE4MBG_social_common_RemoteNotification_setListener"
                 pointer:&ANE4MBG_social_common_RemoteNotification_setListener];
    
}

FREObject ANE4MBG_social_common_RemoteNotification_setListener(FREContext cxt,
                                                               void* functionData,
                                                               uint32_t argc,
                                                               FREObject argv[]) {
    LOG_METHOD;
    NSDictionary *launchOptions = [AppDelegatePatch sharedAppDelegatePatch].launchOptions;
    NSDictionary *userInfo = [launchOptions valueForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    
    LOG(@"userInfo = %@", userInfo);
    if ([userInfo count] > 0) {
        MBGRemoteNotificationPayload *payload = [MBGRemoteNotificationPayload payload];
        payload.badge = [[userInfo valueForKeyPath:@"aps.badge"] integerValue];
        payload.message = [userInfo valueForKeyPath:@"aps.alert"] ? [userInfo valueForKeyPath:@"aps.alert"] : @"";
        payload.sound = [userInfo valueForKeyPath:@"aps.sound"] ? [userInfo valueForKeyPath:@"aps.sound"] : @"";
        if (((NSArray *)[userInfo valueForKey:@"x"]).count >= 3) {
            payload.extras = [[userInfo valueForKey:@"x"] objectAtIndex:3];
        } else {
            payload.extras = [NSDictionary dictionary];
        }
        
        NSMutableDictionary *payloadDic = [NSMutableDictionary dictionaryWithDictionary:[ArgsParser payloadToJSON:payload]];
        [payloadDic setObject:@"Launch" forKey:@"state"];
        
        [Mobage_addPlatformListener handleReceive:payloadDic];
    }
    
    [AppDelegatePatch sharedAppDelegatePatch].launchOptions = nil;
    
    return NULL;
}

@end
