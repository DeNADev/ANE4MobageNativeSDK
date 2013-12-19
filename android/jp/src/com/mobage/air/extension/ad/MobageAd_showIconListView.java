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

import android.util.Log;
import android.widget.FrameLayout;
import android.widget.RelativeLayout;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.mobage.air.extension.ArgsParser;
import com.mobage.air.extension.Dispatcher;
import com.mobage.air.extension.SharedInstance;
import com.mobage.android.ad.MobageAdIconListView;

public class MobageAd_showIconListView implements FREFunction {

	@Override
	public FREObject call(final FREContext context, FREObject[] args) {
		SharedInstance.initInstance();
		if(SharedInstance.getInstance().iconListView != null && 
				SharedInstance.getInstance().isIconListViewCalled == false){
		try{
			ArgsParser a = new ArgsParser(args);
			String position = a.nextString();
			a.finish();
			
			RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT, MobageAdIconListView.getHeightPixels(context.getActivity()));
			Log.i("showIconListView", "position is :" + position);
			if(position.equals("BOTTOM")){
			Log.i("showIconListView", "Align to Bottom");
			params.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
			} else{
				params.addRule(RelativeLayout.ALIGN_PARENT_TOP);
			}
			
			SharedInstance.getInstance().rlayout = new RelativeLayout(context.getActivity().getBaseContext());
			
			
			FrameLayout flayout = (FrameLayout) context.getActivity()
					.getWindow().getDecorView()
					.findViewById(android.R.id.content);
			flayout.addView(SharedInstance.getInstance().rlayout);
			SharedInstance.getInstance().rlayout.addView(SharedInstance.getInstance().iconListView, params);
			SharedInstance.getInstance().isIconListViewCalled = true;
		}catch (Exception e) {
			Dispatcher.exception(context, e);
		}}
		return null;
	}

}
