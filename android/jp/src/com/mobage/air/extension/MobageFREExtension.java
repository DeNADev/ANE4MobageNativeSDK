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

import android.app.Activity;
import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public final class MobageFREExtension implements FREExtension {

	public static String TAG = "MobageFREExtension";

	private static FREContext context;

	/**
	 * Naming rules: <br>
	 * Foo__bar => Foo#bar (bar() is an instance method of Foo)<br>
	 * Foo_bar => Foo.bar (bar() is a class method of Foo)<br>
	 * 
	 * @param className
	 * @return
	 */
	public static String name(String className) {
		return className.replaceAll("__", "#").replaceAll("_", ".");
	}

	@Override
	public FREContext createContext(String type) {
		Log.i(TAG, "MobageFREExtension#createContext(" + type + ")");
		context = new MobageFREContext();
		return context;
	}

	@Override
	public void initialize() {
		Log.i(TAG, "MobageFREExtension#initialize()");
	}

	@Override
	public void dispose() {
		Log.i(TAG, "MobageFREExtension#dispose()");
	}

	public String fixupResourceClassName(String resourceClassName) {
		try {
			Activity activity = context.getActivity();
			// package name in AndroidManifest.xml
			String manifestPackageName = activity.getPackageName();

			if (resourceClassName.equals(manifestPackageName + ".R")) {
				return activity.getClass().getPackage().getName() + ".R";
			} else {
				return resourceClassName; // fallback
			}
		} catch (Exception e) {
			return resourceClassName; // fallback
		}
	}
    
    public static Activity getActivity() {
		return context.getActivity();
	}

}
