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
package com.mobage.air.extension.social.common;

import android.widget.FrameLayout;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.mobage.air.extension.ArgsParser;
import com.mobage.air.extension.Dispatcher;
import com.mobage.air.extension.SharedInstance;
import com.mobage.android.social.common.Service;

public class Service_getBalanceButton implements FREFunction {
	@Override
	public FREObject call(final FREContext context, FREObject[] args) {

		SharedInstance.initInstance();

		try {
			ArgsParser a = new ArgsParser(args);
			int x = a.nextInt();
			int y = a.nextInt();
			int width = a.nextInt();
			int height = a.nextInt();
			a.finish();

			if (!SharedInstance.getInstance().isBalanceButtonCalled) {
				SharedInstance.getInstance().balanceButton = Service
						.getBalanceButton(width, height);

				FrameLayout layout = (FrameLayout) context.getActivity()
						.getWindow().getDecorView()
						.findViewById(android.R.id.content);

				FrameLayout.LayoutParams param = new FrameLayout.LayoutParams(
						getLayoutParam());
				param.setMargins(x, y, 0, 0);

				layout.addView(SharedInstance.getInstance().balanceButton,
						param);

				SharedInstance.getInstance().isBalanceButtonCalled = true;
			}

		} catch (Exception e) {
			Dispatcher.exception(context, e);
		}

		return null;
	}

	private FrameLayout.LayoutParams getLayoutParam() {
		return new FrameLayout.LayoutParams(
				FrameLayout.LayoutParams.WRAP_CONTENT,
				FrameLayout.LayoutParams.WRAP_CONTENT);
	}
}
