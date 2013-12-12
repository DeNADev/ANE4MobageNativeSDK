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
package com.mobage.air.extension;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREObject;

import com.mobage.android.Error;
import com.mobage.android.Mobage;

public class PlatformListenerWrapper implements Mobage.PlatformListener {

	private FREContext context;

	private FREObject object;

	public PlatformListenerWrapper(FREContext context, FREObject object) {
		this.context = context;
		this.object = object;
	}

	@Override
	public void onLoginError(Error error) {
		Dispatcher.dispatch(context, "PlatformListener.onLoginError", error);
	}

	@Override
	public void onLoginCancel() {
		Dispatcher.dispatch(context, "PlatformListener.onLoginCancel");
	}

	@Override
	public void onLoginComplete(String userId) {
		Dispatcher.dispatch(context, "PlatformListener.onLoginComplete", userId);
	}

	@Override
	public void onLoginRequired() {
		Dispatcher.dispatch(context, "PlatformListener.onLoginRequired");
	}

	@Override
	public void onSplashComplete() {
		Dispatcher.dispatch(context, "PlatformListener.onSplashComplete");
	}

	@Override
	public int hashCode() {
		return object.hashCode();
	}

	@Override
	public boolean equals(Object other) {
		if (other instanceof PlatformListenerWrapper) {
			return object.equals(other);
		}
		return false;
	}
}
