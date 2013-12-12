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

import org.json.JSONArray;
import org.json.JSONObject;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.mobage.android.Error;

public class Dispatcher {

	public static String TAG = "Dispatcher";

	public static void exception(FREContext context, Throwable e) {
		dispatch(context, "fatal", e);
	}

	public static void dispatch(FREContext context, String eventType) {
		context.dispatchStatusEventAsync(eventType, "null");
	}

	public static void dispatch(FREContext context, String eventType, JSONArray args) {
		context.dispatchStatusEventAsync(eventType, args.toString());
	}

	public static void dispatch(FREContext context, String eventType, Throwable exception) {
		try {
			JSONArray args = new JSONArray();

			args.put(exception.toString());
			for (StackTraceElement item : exception.getStackTrace()) {
				args.put(item.toString());
			}

			context.dispatchStatusEventAsync(eventType, args.toString());
		} catch (Exception e) {
			Log.wtf(TAG, e);
		}
	}

	public static void dispatch(FREContext context, String eventType, Error error) {
		try {
			JSONArray args = new JSONArray();
			JSONObject err = new JSONObject();

			err.put(".class", "com.mobage.air.ErrorCode");
			err.put("code", error.getCode());
			err.put("description", error.getDescription());

			args.put(err);
			dispatch(context, eventType, args);
		} catch (Exception e) {
			exception(context, e);
		}
	}

	public static void dispatch(FREContext context, String eventType, String arg) {
		try {
			JSONArray args = new JSONArray();
			args.put(arg);
			dispatch(context, eventType, args);
		} catch (Exception e) {
			exception(context, e);
		}
	}

}
