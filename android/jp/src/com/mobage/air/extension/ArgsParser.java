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

import java.util.ArrayList;
import java.util.HashMap;

import org.json.JSONException;
import org.json.JSONObject;

import com.adobe.fre.FREASErrorException;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FRENoSuchNameException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;
import com.mobage.android.Mobage;
import com.mobage.android.ad.MobageAd;
import com.mobage.android.bank.Debit;
import com.mobage.android.social.PagingOption;
import com.mobage.android.social.User;
import com.mobage.android.social.common.Leaderboard;
import com.mobage.android.social.common.RemoteNotificationPayload;
import com.mobage.android.social.jp.Service;

public class ArgsParser {

	private int cur = 0;

	private FREObject[] args;

	public ArgsParser(FREObject[] args) {
		this.args = args;
	}

	public void finish() {
		if (args.length != cur) {
			throw new UnexpectedException("ArgsParser finished but the argument size mismatched " + "(argc=" + args.length + ",cur=" + cur + ")");
		}
	}

	public FREObject next() {
		return args[cur++];
	}

	public String nextString() {
		try {
			return next().getAsString();
		} catch (IllegalStateException e) {
			throw new UnexpectedException(e);
		} catch (FRETypeMismatchException e) {
			throw new UnexpectedException(e);
		} catch (FREInvalidObjectException e) {
			throw new UnexpectedException(e);
		} catch (FREWrongThreadException e) {
			throw new UnexpectedException(e);
		}
	}

	public int nextInt() {
		try {
			return next().getAsInt();
		} catch (IllegalStateException e) {
			throw new UnexpectedException(e);
		} catch (FRETypeMismatchException e) {
			throw new UnexpectedException(e);
		} catch (FREInvalidObjectException e) {
			throw new UnexpectedException(e);
		} catch (FREWrongThreadException e) {
			throw new UnexpectedException(e);
		}
	}
	
	public double nextDouble() {
		try {
			return next().getAsDouble();
		} catch (IllegalStateException e) {
			throw new UnexpectedException(e);
		} catch (FRETypeMismatchException e) {
			throw new UnexpectedException(e);
		} catch (FREInvalidObjectException e) {
			throw new UnexpectedException(e);
		} catch (FREWrongThreadException e) {
			throw new UnexpectedException(e);
		}
	}

	public boolean nextBool() {
		try {
			return next().getAsBool();
		} catch (IllegalStateException e) {
			throw new UnexpectedException(e);
		} catch (FRETypeMismatchException e) {
			throw new UnexpectedException(e);
		} catch (FREInvalidObjectException e) {
			throw new UnexpectedException(e);
		} catch (FREWrongThreadException e) {
			throw new UnexpectedException(e);
		}
	}

	public ArrayList<String> nextStringArrayList() {
		try {
			return Convert.stringArrayList(next());
		} catch (IllegalStateException e) {
			throw new UnexpectedException(e);
		} catch (IllegalArgumentException e) {
			throw new UnexpectedException(e);
		} catch (FREInvalidObjectException e) {
			throw new UnexpectedException(e);
		} catch (FREWrongThreadException e) {
			throw new UnexpectedException(e);
		} catch (FRETypeMismatchException e) {
			throw new UnexpectedException(e);
		}
	}

	public HashMap<String, String> nextKeyValueMap() {
		try {
			return Convert.keyValueMap(next());
		} catch (IllegalStateException e) {
			throw new UnexpectedException(e);
		} catch (IllegalArgumentException e) {
			throw new UnexpectedException(e);
		} catch (FREInvalidObjectException e) {
			throw new UnexpectedException(e);
		} catch (FREWrongThreadException e) {
			throw new UnexpectedException(e);
		} catch (FRETypeMismatchException e) {
			throw new UnexpectedException(e);
		} catch (FREASErrorException e) {
			throw new UnexpectedException(e);
		} catch (FRENoSuchNameException e) {
			throw new UnexpectedException(e);
		}
	}
	
	public JSONObject nextJsonKeyValueMap(){
		try {
			return Convert.keyValueMapAsJsonObject(next());
		} catch (IllegalStateException e) {
			throw new UnexpectedException(e);
		} catch (IllegalArgumentException e) {
			throw new UnexpectedException(e);
		} catch (FREInvalidObjectException e) {
			throw new UnexpectedException(e);
		} catch (FREWrongThreadException e) {
			throw new UnexpectedException(e);
		} catch (FRETypeMismatchException e) {
			throw new UnexpectedException(e);
		} catch (FREASErrorException e) {
			throw new UnexpectedException(e);
		} catch (FRENoSuchNameException e) {
			throw new UnexpectedException(e);
		} catch (JSONException e) {
			throw new UnexpectedException(e);
		}
	}

	public Mobage.Region nextRegion() {
		try {
			return Convert.region(next());
		} catch (IllegalStateException e) {
			throw new UnexpectedException(e);
		} catch (FRETypeMismatchException e) {
			throw new UnexpectedException(e);
		} catch (FREInvalidObjectException e) {
			throw new UnexpectedException(e);
		} catch (FREWrongThreadException e) {
			throw new UnexpectedException(e);
		} catch (FREASErrorException e) {
			throw new UnexpectedException(e);
		} catch (FRENoSuchNameException e) {
			throw new UnexpectedException(e);
		}
	}

	public Mobage.ServerMode nextServerMode() {
		try {
			return Convert.serverMode(next());
		} catch (IllegalStateException e) {
			throw new UnexpectedException(e);
		} catch (FRETypeMismatchException e) {
			throw new UnexpectedException(e);
		} catch (FREInvalidObjectException e) {
			throw new UnexpectedException(e);
		} catch (FREWrongThreadException e) {
			throw new UnexpectedException(e);
		} catch (FREASErrorException e) {
			throw new UnexpectedException(e);
		} catch (FRENoSuchNameException e) {
			throw new UnexpectedException(e);
		}
	}
	
	public Mobage.TargetUserGrade nextTargetUserGrade(){
		try {
			return Convert.targetUserGrade(next());
		} catch (IllegalStateException e) {
			throw new UnexpectedException(e);
		} catch (FRETypeMismatchException e) {
			throw new UnexpectedException(e);
		} catch (FREInvalidObjectException e) {
			throw new UnexpectedException(e);
		} catch (FREWrongThreadException e) {
			throw new UnexpectedException(e);
		} catch (FREASErrorException e) {
			throw new UnexpectedException(e);
		} catch (FRENoSuchNameException e) {
			throw new UnexpectedException(e);
		}
	}
	
	public Service.Gravity nextGravity(){
		try {
			return Convert.gravity(next());
		} catch (IllegalStateException e) {
			throw new UnexpectedException(e);
		} catch (FRETypeMismatchException e) {
			throw new UnexpectedException(e);
		} catch (FREInvalidObjectException e) {
			throw new UnexpectedException(e);
		} catch (FREWrongThreadException e) {
			throw new UnexpectedException(e);
		} catch (FREASErrorException e) {
			throw new UnexpectedException(e);
		} catch (FRENoSuchNameException e) {
			throw new UnexpectedException(e);
		}
	}

	public User.Field[] nextUserFields() {
		try {
			return Convert.userFields(next());
		} catch (IllegalStateException e) {
			throw new UnexpectedException(e);
		} catch (IllegalArgumentException e) {
			throw new UnexpectedException(e);
		} catch (FREInvalidObjectException e) {
			throw new UnexpectedException(e);
		} catch (FREWrongThreadException e) {
			throw new UnexpectedException(e);
		} catch (FRETypeMismatchException e) {
			throw new UnexpectedException(e);
		}
	}
	
	public Leaderboard.Field[] nextLeaderFields(){
		try{
			return Convert.leaderFields(next());
		} catch (IllegalStateException e) {
			throw new UnexpectedException(e);
		} catch (IllegalArgumentException e) {
			throw new UnexpectedException(e);
		} catch (FREInvalidObjectException e) {
			throw new UnexpectedException(e);
		} catch (FREWrongThreadException e) {
			throw new UnexpectedException(e);
		} catch (FRETypeMismatchException e) {
			throw new UnexpectedException(e);
		}
	}

	public PagingOption nextPagingOption() {
		try {
			return Convert.pagingOption(next());
		} catch (IllegalStateException e) {
			throw new UnexpectedException(e);
		} catch (FRETypeMismatchException e) {
			throw new UnexpectedException(e);
		} catch (FREInvalidObjectException e) {
			throw new UnexpectedException(e);
		} catch (FREWrongThreadException e) {
			throw new UnexpectedException(e);
		} catch (FREASErrorException e) {
			throw new UnexpectedException(e);
		} catch (FRENoSuchNameException e) {
			throw new UnexpectedException(e);
		}
	}

	public ArrayList<Debit.BillingItem> nextBillingItems() {
		try {
			return Convert.billingItems(next());
		} catch (IllegalStateException e) {
			throw new UnexpectedException(e);
		} catch (FREInvalidObjectException e) {
			throw new UnexpectedException(e);
		} catch (FREWrongThreadException e) {
			throw new UnexpectedException(e);
		} catch (FRETypeMismatchException e) {
			throw new UnexpectedException(e);
		} catch (FREASErrorException e) {
			throw new UnexpectedException(e);
		} catch (FRENoSuchNameException e) {
			throw new UnexpectedException(e);
		} catch (JSONException e) {
			throw new UnexpectedException(e);
		}
	}
	
	public RemoteNotificationPayload nextRemotePayload(){
		try{
			return Convert.remotePayload(next());
		} catch (IllegalStateException e) {
			throw new UnexpectedException(e);
		} catch (FREInvalidObjectException e) {
			throw new UnexpectedException(e);
		} catch (FREWrongThreadException e) {
			throw new UnexpectedException(e);
		} catch (FRETypeMismatchException e) {
			throw new UnexpectedException(e);
		} catch (FREASErrorException e) {
			throw new UnexpectedException(e);
		} catch (FRENoSuchNameException e) {
			throw new UnexpectedException(e);
		} catch (JSONException e) {
			throw new UnexpectedException(e);
		}
		
	}

	public com.mobage.android.social.jp.Service.DocumentType nextJpDocumentType() {
		try {
			return Convert.jpDocumentType(next());
		} catch (IllegalStateException e) {
			throw new UnexpectedException(e);
		} catch (FRETypeMismatchException e) {
			throw new UnexpectedException(e);
		} catch (FREInvalidObjectException e) {
			throw new UnexpectedException(e);
		} catch (FREWrongThreadException e) {
			throw new UnexpectedException(e);
		} catch (FREASErrorException e) {
			throw new UnexpectedException(e);
		} catch (FRENoSuchNameException e) {
			throw new UnexpectedException(e);
		}
	}

	public com.mobage.android.social.jp.Textdata.TextdataEntry nextJpTextdataEntry() {
		try {
			return Convert.jpTextdataEntry(next());
		} catch (IllegalStateException e) {
			throw new UnexpectedException(e);
		} catch (FRETypeMismatchException e) {
			throw new UnexpectedException(e);
		} catch (FREInvalidObjectException e) {
			throw new UnexpectedException(e);
		} catch (FREWrongThreadException e) {
			throw new UnexpectedException(e);
		} catch (FREASErrorException e) {
			throw new UnexpectedException(e);
		} catch (FRENoSuchNameException e) {
			throw new UnexpectedException(e);
		} catch (JSONException e) {
			throw new UnexpectedException(e);
		}
	}
	
	public MobageAd.FrameId nextFrameId() {
		try {
			return Convert.frameId(next());
		}catch (IllegalStateException e) {
			throw new UnexpectedException(e);
		} catch (FRETypeMismatchException e) {
			throw new UnexpectedException(e);
		} catch (FREInvalidObjectException e) {
			throw new UnexpectedException(e);
		} catch (FREWrongThreadException e) {
			throw new UnexpectedException(e);
		} catch (FRENoSuchNameException e) {
			throw new UnexpectedException(e);
		} catch (FREASErrorException e) {
			throw new UnexpectedException(e);
		}
	}
}
