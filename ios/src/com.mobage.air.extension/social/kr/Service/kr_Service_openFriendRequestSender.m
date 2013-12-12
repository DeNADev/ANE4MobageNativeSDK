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

#import "kr_Service_openFriendRequestSender.h"

@interface kr_Service_openFriendRequestSender()
FREObject ANE4MBG_social_kr_Service_openFriendRequestSender(FREContext cxt,
                                                            void* functionData,
                                                            uint32_t argc,
                                                            FREObject argv[]);
@end

@implementation kr_Service_openFriendRequestSender
+ (void)ContextInitializer:(FunctionSets *)funcSets {
    LOG_METHOD;
    [funcSets addFuncSet:@"ANE4MBG_social_kr_Service_openFriendRequestSender"
                 pointer:&ANE4MBG_social_kr_Service_openFriendRequestSender];
    
}

FREObject ANE4MBG_social_kr_Service_openFriendRequestSender(FREContext cxt,
                                                            void* functionData,
                                                            uint32_t argc,
                                                            FREObject argv[]) {
    LOG_METHOD;
    ArgsParser *parser = [ArgsParser sharedParser];
    [parser setArgc:argc argv:argv];
    
    NSArray *userIds = [parser nextArray];
    NSString *onDismiss = [parser nextString];
    
    FREContext context = [ContextOwner sharedContext];
    
    [MBGSocialKRService
     openFriendRequestSender:userIds
     onDismiss:^(NSArray *userIds) {
         FREResult result = TCDispatch(context,
                                     onDismiss,
                                     [NSArray arrayWithObject:userIds]);
         if(result != FRE_OK) [ArgsParser reportResult:result];
     }];
    
    return NULL;
}
@end