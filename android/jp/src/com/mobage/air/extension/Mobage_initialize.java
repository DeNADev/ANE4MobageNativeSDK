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

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.mobage.android.Mobage;

public class Mobage_initialize implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		ArgsParser a = new ArgsParser(args);
		Mobage.Region region = a.nextRegion();
		Mobage.ServerMode serverMode = a.nextServerMode();
		String consumerKey = a.nextString();
		String consumerSecret = a.nextString();
		String appId = a.nextString();
		a.next(); // application instance
		a.finish();
		Activity rootActivity = context.getActivity();

		// reflection
		Class<?> r;
		try {
			r = Class.forName(rootActivity.getClass().getPackage().getName() + ".R");
		} catch (ClassNotFoundException e) {
			throw new UnexpectedException(e);
		}

		Class<?> layoutClass = null;
		Class<?> drawableClass = null;

		for (Class<?> c : r.getClasses()) {
			if (c.getSimpleName().equals("layout")) {
				layoutClass = c;
			} else if (c.getSimpleName().equals("drawable")) {
				drawableClass = c;
			}
		}
		assert layoutClass != null;
		assert drawableClass != null;

		Mobage.initialize(region, serverMode, consumerKey, consumerSecret, appId, rootActivity);
		// Life cycle event
		Mobage.onCreate(context.getActivity());
		Mobage.onStart(context.getActivity());
		Mobage.onResume(context.getActivity());
		return null;
	}
}
