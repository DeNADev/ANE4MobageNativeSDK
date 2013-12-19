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

import android.widget.RelativeLayout;

import com.mobage.android.ad.MobageAdIconListView;
import com.mobage.android.ad.MobageAdOfferwall;
import com.mobage.android.ad.MobageAdPopupDialog;
import com.mobage.android.notification.MobageDashboardObserver;
import com.mobage.android.social.BalanceButton;

public class SharedInstance {
	private static SharedInstance _instance;
	
	// For Remote Notification
	public boolean isPaused;
	public BalanceButton balanceButton;
	public boolean isBalanceButtonCalled;
	
	// For MobageDashBoard
	public MobageDashboardObserver mObserver;
	
	// For MobageAd
	public MobageAdIconListView iconListView;
	public boolean isIconListViewCalled;
	public MobageAdPopupDialog popupDialog;
	public MobageAdOfferwall offerwall;
	public RelativeLayout rlayout;
	
	
	private SharedInstance(){
		isPaused = false;
		isBalanceButtonCalled = false;
		isIconListViewCalled = false;
	}
	
	public static void initInstance(){
		if (_instance == null)
		{
			_instance = new SharedInstance();
		}
	}
	
	public static SharedInstance getInstance()
	{
		return _instance;
	}

}
