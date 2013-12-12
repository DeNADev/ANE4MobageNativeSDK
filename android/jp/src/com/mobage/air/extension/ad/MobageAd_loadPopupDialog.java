/*******************************************************************************
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
 ******************************************************************************/
package com.mobage.air.extension.ad;


import org.json.JSONArray;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.mobage.air.extension.ArgsParser;
import com.mobage.air.extension.Dispatcher;
import com.mobage.air.extension.SharedInstance;
import com.mobage.android.ad.MobageAd;
import com.mobage.android.ad.MobageAdListener;
import com.mobage.android.ad.MobageAdPopupDialog;
import com.mobage.air.extension.Convert;

public class MobageAd_loadPopupDialog implements FREFunction {
	final String adType = "PopupDialog";
	

	@Override
	public FREObject call(final FREContext context, FREObject[] args) {
		SharedInstance.initInstance();
		try{
			ArgsParser a = new ArgsParser(args);
			final MobageAd.FrameId frameId =a.nextFrameId();
			String extraParam = null;
			if(args.length == 2){
				extraParam = a.nextString();
				}
			a.finish();
			
			if(SharedInstance.getInstance().popupDialog == null){
				SharedInstance.getInstance().popupDialog = new MobageAdPopupDialog(context.getActivity());
				SharedInstance.getInstance().popupDialog.setAdListener(new MobageAdListener() {
					@Override
					public void onReceiveAd(MobageAd ad) {
						Dispatcher.dispatch(context,"AdListener.onReceiveAd", adType);
					}

					@Override
					public void onFailedToReceiveAd(MobageAd ad, MobageAd.ErrorCode errorCode) {
						try{
							JSONArray args = new JSONArray();
							args.put(Convert.convertMobageAdErrorToJSON(adType, errorCode));
							Dispatcher.dispatch(context, "AdListener.onFailedToReceiveAd", args);
						}catch (Exception e) {
							Dispatcher.exception(context, e);
						}
					}

					@Override
					public void onLeaveApplication(MobageAd ad) {
						Dispatcher.dispatch(context,"AdListener.onLeaveApplication", adType);
					}

					@Override
					public void onPresentScreen(MobageAd ad) {
						Dispatcher.dispatch(context,"AdListener.onPresentScreen", adType);
					}

					@Override
					public void onDismissScreen(MobageAd ad) {
						Dispatcher.dispatch(context,"AdListener.onDismissScreen", adType);
					}
				});
			}
			
			SharedInstance.getInstance().popupDialog.setFrameId(frameId);
			if(extraParam != null) {
			SharedInstance.getInstance().popupDialog.setExtraParam(extraParam);
			}
			SharedInstance.getInstance().popupDialog.loadAd();
			
		}catch (Exception e) {
			Dispatcher.exception(context, e);
		}
		
		
		return null;
	}

}
