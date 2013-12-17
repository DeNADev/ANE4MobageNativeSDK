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

#import "Base.h"
#import "MBGError.h"
#import "MBGADError+MobageAd_error.h"

@implementation Base
+ (void)ContextInitializer:(FunctionSets *)funcSets {
    
}

FREResult TCDispatch(FREContext ctx,
                     NSString *code,
                     id level) {
    LOG_METHOD;
    
    const uint8_t* dispatchCode = (const uint8_t*)[code UTF8String];
    const uint8_t* dispatchLevel = (const uint8_t*)"null";
    
    if (level) {
        NSError *error = nil;
        
        if ([level isKindOfClass:[MBGError class]]) {
            MBGError *error = ((MBGError *)level);
            
            level = [NSDictionary dictionaryWithObjectsAndKeys:
                     @"com.mobage.air.ErrorCode", @".class",
                     [NSNumber numberWithInteger:error.code], @"code",
                     error.description, @"description", nil];
        }
        
        if ([level isKindOfClass:[MBGADError class]]) {
            MBGADError *error = ((MBGADError *)level);
            
            level = [NSDictionary dictionaryWithObjectsAndKeys:
                     @"com.mobage.air.ad.MobageAdError", @".class",
                     error.adType, @"adType",
                     error.description, @"error", nil];
        }
        
        if (![level isKindOfClass:[NSArray class]]) {
            level = [NSArray arrayWithObject:level];
        }
        
        NSData *json = [NSJSONSerialization dataWithJSONObject:level
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
        NSString *jsonString = [[[NSString alloc] initWithData:json
                                                      encoding:NSUTF8StringEncoding] autorelease];
        dispatchLevel = (const uint8_t*)[jsonString UTF8String];
        LOG(@"json : %@", jsonString);
    }
    
    FREResult result = FREDispatchStatusEventAsync(ctx,
                                                   dispatchCode,
                                                   dispatchLevel);
    
    return result;
}

@end
