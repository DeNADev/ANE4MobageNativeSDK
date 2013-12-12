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

import java.util.ArrayList;

import org.json.JSONArray;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.mobage.air.extension.ArgsParser;
import com.mobage.air.extension.Convert;
import com.mobage.air.extension.Dispatcher;
import com.mobage.android.social.common.Service;

public class Service_openFriendPicker implements FREFunction {

	@Override
	public FREObject call(final FREContext context, FREObject[] args) {
		try {
			ArgsParser a = new ArgsParser(args);
			int maxFiendsToSelect = a.nextInt();
			final String onDissmissId = a.nextString();
			final String onInviteSentId = a.nextString();
			final String onPickedId = a.nextString();
			a.finish();

			Service.OnFriendPickerComplete cb = new Service.OnFriendPickerComplete() {
				@Override
				public void onDismiss() {
					Dispatcher.dispatch(context, onDissmissId);
				}

				@Override
				public void onInviteSent(ArrayList<String> userIds) {
					try {
						JSONArray args = new JSONArray();
						args.put(Convert.stringListToJSON(userIds));
						Dispatcher.dispatch(context, onInviteSentId, args);
					} catch (Exception e) {
						Dispatcher.exception(context, e);
					}
				}

				@Override
				public void onPicked(ArrayList<String> pickedUserIds) {
					try {
						JSONArray args = new JSONArray();
						args.put(Convert.stringListToJSON(pickedUserIds));
						Dispatcher.dispatch(context, onPickedId, args);
					} catch (Exception e) {
						Dispatcher.exception(context, e);
					}
				}
			};
			Service.openFriendPicker(maxFiendsToSelect, cb);
		} catch (Exception e) {
			Dispatcher.exception(context, e);
		}
		return null;
	}
}
