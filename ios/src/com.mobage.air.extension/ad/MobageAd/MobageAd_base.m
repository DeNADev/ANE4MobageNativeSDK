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

#import "MobageAd_base.h"
#import "MBGADError+MobageAd_error.h"

static MBGADIconListView *_iconListView = nil;
static MBGADPopupDialog *_popupDialog = nil;
static NSString *_adTypeIconListView = @"IconListView";
static NSString *_adTypePopupDialog = @"PopupDialog";


@implementation MobageAd_base

+ (MBGADIconListView *)sharedIconListView {
    LOG_METHOD;
    if (!_iconListView) {
        _iconListView = [[MBGADIconListView iconListWithFrameID:MBGADFrameID_A] retain];
        
        [_iconListView setDidReceiveAd:^(MBGADIconListView* iconListView){
            LOG_METHOD;
            FREContext context = [ContextOwner sharedContext];
            FREResult result = TCDispatch(context,
                                          @"AdListener.onReceiveAd",
                                          _adTypeIconListView);
            
            if(result != FRE_OK) {
                [ArgsParser reportResult:result];
            };
        }];
        
        [_iconListView setDidFailToReceiveAdWithError:^(MBGADIconListView* iconListView, MBGADError* error) {
            LOG_METHOD;
            FREContext context = [ContextOwner sharedContext];
            
            error.adType = _adTypeIconListView;
            FREResult result = TCDispatch(context,
                                          @"AdListener.onFailedToReceiveAd",
                                          error);

            if(result != FRE_OK) {
                [ArgsParser reportResult:result];
            };
        }];
        
        [_iconListView setWillLeaveApplication:^(MBGADIconListView* iconListView){
            LOG_METHOD;
            FREContext context = [ContextOwner sharedContext];
            FREResult result = TCDispatch(context,
                                          @"AdListener.onLeaveApplication",
                                          _adTypeIconListView);
            
            if(result != FRE_OK) {
                [ArgsParser reportResult:result];
            };
        }];
    }
    
    return _iconListView;
}

+ (MBGADPopupDialog *)sharedPopupDialog {
    if (!_popupDialog) {
        _popupDialog = [[MBGADPopupDialog dialogWithFrameID:MBGADFrameID_A] retain];
        
        [_popupDialog setDidReceiveAd:^(MBGADPopupDialog* popupDialog){
            LOG_METHOD;
            FREContext context = [ContextOwner sharedContext];
            FREResult result = TCDispatch(context,
                                          @"AdListener.onReceiveAd",
                                          _adTypePopupDialog);
            
            if(result != FRE_OK) {
                [ArgsParser reportResult:result];
            };
            
        }];
        
        [_popupDialog setDidFailToReceiveAdWithError:^(MBGADPopupDialog* popupDialog, MBGADError* error) {
            LOG_METHOD;
            FREContext context = [ContextOwner sharedContext];
            
            error.adType = _adTypePopupDialog;
            
            FREResult result = TCDispatch(context,
                                          @"AdListener.onFailedToReceiveAd",
                                          error);
            
            if(result != FRE_OK) {
                [ArgsParser reportResult:result];
            };
        }];
        
        [_popupDialog setWillLeaveApplication:^(MBGADPopupDialog* popupDialog){
            LOG_METHOD;
            FREContext context = [ContextOwner sharedContext];
            FREResult result = TCDispatch(context,
                                          @"AdListener.onLeaveApplication",
                                          _adTypePopupDialog);
            
            if(result != FRE_OK) {
                [ArgsParser reportResult:result];
            };
        }];
        
        [_popupDialog setWillPresentScreen:^(MBGADPopupDialog* popupDialog){
            LOG_METHOD;
            FREContext context = [ContextOwner sharedContext];
            FREResult result = TCDispatch(context,
                                          @"AdListener.onPresentScreen",
                                          _adTypePopupDialog);
            
            if(result != FRE_OK) {
                [ArgsParser reportResult:result];
            };
        }];
        
        [_popupDialog setDidDismissScreen:^(MBGADPopupDialog* popupDialog){
            LOG_METHOD;
            FREContext context = [ContextOwner sharedContext];
            FREResult result = TCDispatch(context,
                                          @"AdListener.onDismissScreen",
                                          _adTypePopupDialog);
            
            if(result != FRE_OK) {
                [ArgsParser reportResult:result];
            };
        }];
    }
    return _popupDialog;
}

@end
