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

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class Log_print implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		ArgsParser parser = new ArgsParser(args);
		String mode = parser.nextString();
		String msg = parser.nextString();
		parser.finish();

		switch (mode.charAt(0)) {
		case 'v':
			Log.v(MobageFREExtension.TAG, msg);
			break;
		case 'i':
			Log.i(MobageFREExtension.TAG, msg);
			break;
		case 'd':
			Log.d(MobageFREExtension.TAG, msg);
			break;
		case 'w':
			Log.d(MobageFREExtension.TAG, msg);
			break;
		case 'e':
			Log.d(MobageFREExtension.TAG, msg);
			break;
		}
		return null;
	}
}
