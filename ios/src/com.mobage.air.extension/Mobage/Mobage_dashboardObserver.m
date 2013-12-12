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

#import "Mobage_dashboardObserver.h"

NSString *const MBG_Notification_OnLaunchingDashboard = @"MBG_Notification_OnLaunchingDashboard";
NSString *const MBG_Notification_OnDismissDashboard = @"MBG_Notification_OnDismissingDashboard";

static Mobage_dashboardObserver *_dashboardObserver = nil;
@implementation Mobage_dashboardObserver
#pragma mark - Initializer
+ (void)initialize {
    LOG_METHOD;
    
    if (!_dashboardObserver) {
        _dashboardObserver = [[Mobage_dashboardObserver alloc] init];
    }
}

+ (Mobage_dashboardObserver *)shardDashboardObserver {
    LOG_METHOD;
    
    return _dashboardObserver;
}

#pragma mark - MBG_Notification_OnLaunchingDashboard
- (void)onLaunchingDashboard {
    LOG_METHOD;
    
    FREContext context = [ContextOwner sharedContext];
    FREResult result = TCDispatch(context,
                                @"PlatformListener.DashboardLanched",
                                nil);
    
    if(result != FRE_OK) {
        [ArgsParser reportResult:result];
    };
}

#pragma mark - MBG_Notification_OnDismissingDashboard
- (void)onDismissDashboard {
    LOG_METHOD;
    
    FREContext context = [ContextOwner sharedContext];
    FREResult result = TCDispatch(context,
                                @"PlatformListener.DashboardDismiss",
                                nil);
    
    if(result != FRE_OK) {
        [ArgsParser reportResult:result];
    };
}
@end
