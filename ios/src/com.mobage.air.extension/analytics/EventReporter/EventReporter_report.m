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

#import "EventReporter_report.h"

@interface EventReporter_report()
FREObject ANE4MBG_analytics_EventReporter_report(FREContext cxt,
                                                 void* functionData,
                                                 uint32_t argc,
                                                 FREObject argv[]);
@end

@implementation EventReporter_report
+ (void)ContextInitializer:(FunctionSets *)funcSets {
    LOG_METHOD;
    [funcSets addFuncSet:@"ANE4MBG_analytics_EventReporter_report"
                 pointer:&ANE4MBG_analytics_EventReporter_report];
    
}

FREObject ANE4MBG_analytics_EventReporter_report(FREContext cxt,
                                                 void* functionData,
                                                 uint32_t argc,
                                                 FREObject argv[]) {
    LOG_METHOD;
    ArgsParser *parser = [ArgsParser sharedParser];
    [parser setArgc:argc argv:argv];
    NSString *eventName = [parser nextString];
    NSDictionary *payload = [parser nextDictionary];
    NSDictionary *playerState  = [parser nextDictionary];
    
    if (payload.count == 0) {
        payload = nil;
    }
    
    if (playerState.count == 0) {
        playerState = nil;
    }
    
    MBGGameEvent *gameEvent = [[[MBGGameEvent alloc] initWithId:eventName
                                                        payload:payload
                                                    playerState:playerState] autorelease];
    [MBGEventReporter report:gameEvent];
    
    return NULL;
}
@end