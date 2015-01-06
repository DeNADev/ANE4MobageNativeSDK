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
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.adobe.fre.FREASErrorException;
import com.adobe.fre.FREArray;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FRENoSuchNameException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;
import com.mobage.android.Mobage;
import com.mobage.android.ad.MobageAd;
import com.mobage.android.ad.MobageAd.FrameId;
import com.mobage.android.bank.Debit;
import com.mobage.android.bank.ItemData;
import com.mobage.android.social.PagingOption;
import com.mobage.android.social.PagingResult;
import com.mobage.android.social.User;
import com.mobage.android.social.common.Leaderboard;
import com.mobage.android.social.common.LeaderboardResponse;
import com.mobage.android.social.common.LeaderboardTopScore;
import com.mobage.android.social.common.RemoteNotificationPayload;
import com.mobage.android.social.common.RemoteNotificationResponse;
import com.mobage.android.social.jp.Service;

public final class Convert {

	public static Mobage.Region region(FREObject object) throws IllegalStateException, FRETypeMismatchException, FREInvalidObjectException, FREWrongThreadException, FREASErrorException,
			FRENoSuchNameException {
		String name = object.callMethod("toString", null).getAsString();
		return Mobage.Region.valueOf(name);
	}

	public static Mobage.ServerMode serverMode(FREObject object) throws IllegalStateException, FRETypeMismatchException, FREInvalidObjectException, FREWrongThreadException, FREASErrorException,
			FRENoSuchNameException {
		String name = object.callMethod("toString", null).getAsString();
		return Mobage.ServerMode.valueOf(name);
	}
	
	public static Mobage.TargetUserGrade targetUserGrade(FREObject object) throws IllegalStateException, FRETypeMismatchException, FREInvalidObjectException, FREWrongThreadException, FREASErrorException, 
			FRENoSuchNameException {
		String name = object.callMethod("toString", null).getAsString();
		return Mobage.TargetUserGrade.valueOf(name);
	}
	
	public static Service.Gravity gravity(FREObject object) throws IllegalStateException, FRETypeMismatchException, FREInvalidObjectException, FREWrongThreadException, FREASErrorException, FRENoSuchNameException {
		String name = object.callMethod("toString", null).getAsString();
		return Service.Gravity.valueOf(name);
	}

	public static User.Field userField(FREObject object) throws IllegalStateException, FRETypeMismatchException, FREInvalidObjectException, FREWrongThreadException {
		return User.Field.valueOf(object.getAsString());
	}

	public static User.Field[] userFields(FREObject object) throws FREInvalidObjectException, FREWrongThreadException, IllegalStateException, IllegalArgumentException, FRETypeMismatchException {
		if (object == null) {
			return null;
		}
		FREArray array = (FREArray) object;
		long length = array.getLength();
		User.Field[] target = new User.Field[(int) length];

		for (int i = 0; i < length; ++i) {
			target[i] = userField(array.getObjectAt(i));
		}
		return target;
	}

	public static PagingOption pagingOption(FREObject object) throws IllegalStateException, FRETypeMismatchException, FREInvalidObjectException, FREWrongThreadException, FREASErrorException,
			FRENoSuchNameException {
		if (object == null) {
			return null;
		}

		PagingOption option = new PagingOption();
		option.count = object.getProperty("start").getAsInt();
		option.count = object.getProperty("count").getAsInt();
		return option;
	}
	
	public static MobageAd.FrameId frameId(FREObject object) throws FRETypeMismatchException, FRENoSuchNameException, IllegalStateException, FREInvalidObjectException, FREWrongThreadException, FREASErrorException {
		String name = object.callMethod("toString", null).getAsString();
		return FrameId.valueOf(name);
	}

	public static com.mobage.android.social.jp.Service.DocumentType jpDocumentType(FREObject object) throws IllegalStateException, FRETypeMismatchException, FREInvalidObjectException,
			FREWrongThreadException, FREASErrorException, FRENoSuchNameException {
		String name = object.callMethod("toString", null).getAsString();
		return com.mobage.android.social.jp.Service.DocumentType.valueOf(name);
	}

	public static ArrayList<String> stringArrayList(FREObject object) throws FREInvalidObjectException, FREWrongThreadException, IllegalStateException, IllegalArgumentException,
			FRETypeMismatchException {
		FREArray array = (FREArray) object;
		long length = array.getLength();
		ArrayList<String> target = new ArrayList<String>((int) length);

		for (int i = 0; i < length; ++i) {
			target.add(i, array.getObjectAt(i).getAsString());
		}
		return target;
	}

	// AssocArray ( [ [key0, value0], [key1, value1], ... ] ) to HashMap
	public static HashMap<String, String> keyValueMap(FREObject object) throws FREInvalidObjectException, FREWrongThreadException, IllegalStateException, IllegalArgumentException,
			FRETypeMismatchException, FREASErrorException, FRENoSuchNameException {
		FREArray array = (FREArray) object;
		long length = array.getLength();
		HashMap<String, String> target = new HashMap<String, String>();

		for (int i = 0; i < length; ++i) {
			FREArray pair = (FREArray) array.getObjectAt(i);
			FREObject keyObject = pair.getObjectAt(0).callMethod("toString", null);
			FREObject valueObject = pair.getObjectAt(1).callMethod("toString", null);
			target.put(keyObject.getAsString(), valueObject.getAsString());
		}
		return target;
	}
	
	public static JSONObject keyValueMapAsJsonObject(FREObject object) throws FREInvalidObjectException, FREWrongThreadException, IllegalStateException, IllegalArgumentException,
			FRETypeMismatchException, FREASErrorException, FRENoSuchNameException, JSONException {
		FREArray array = (FREArray) object;
		long length = array.getLength();
		JSONObject target = new JSONObject();
		
		for (int i = 0; i < length; ++i) {
			FREArray pair = (FREArray) array.getObjectAt(i);
			FREObject keyObject = pair.getObjectAt(0).callMethod("toString", null);
			FREObject valueObject = pair.getObjectAt(1).callMethod("toString", null);
			target.put(keyObject.getAsString(), valueObject.getAsString());
		}
		return target;
	}

	public static ArrayList<Debit.BillingItem> billingItems(FREObject object) throws FREInvalidObjectException, FREWrongThreadException, IllegalStateException, FRETypeMismatchException,
			FREASErrorException, FRENoSuchNameException, JSONException {
		FREArray array = (FREArray) object;
		long length = array.getLength();
		ArrayList<Debit.BillingItem> target = new ArrayList<Debit.BillingItem>((int) length);

		for (int i = 0; i < length; ++i) {
			FREObject itemObject = array.getObjectAt(i);
			String itemJSONString = itemObject.callMethod("toString", null).getAsString();
			JSONObject itemJSONObject = new JSONObject(itemJSONString);
			target.add(i, Debit.BillingItem.createFromJson(itemJSONObject));
		}
		return target;
	}

	public static com.mobage.android.social.jp.Textdata.TextdataEntry jpTextdataEntry(FREObject object) throws IllegalStateException, FRETypeMismatchException, FREInvalidObjectException,
			FREWrongThreadException, FREASErrorException, FRENoSuchNameException, JSONException {
		String jsonString = object.callMethod("toString", null).getAsString();
		JSONObject jsonObject = new JSONObject(jsonString);
		return com.mobage.android.social.jp.Textdata.TextdataEntry.createFromJson(jsonObject);
	}
	
	public static RemoteNotificationPayload remotePayload(FREObject object) throws FREInvalidObjectException, FREWrongThreadException, IllegalStateException, FRETypeMismatchException, 
			FREASErrorException, FRENoSuchNameException, JSONException {
		String jsonString = object.callMethod("toString", null).getAsString();
		JSONObject payloadJSONObject = new JSONObject(jsonString);
		RemoteNotificationPayload rmPayload = new RemoteNotificationPayload();
		rmPayload.fromJsonObject(payloadJSONObject);
		
		return rmPayload;	
	}
	
	public static Leaderboard.Field leaderField(FREObject object) throws IllegalStateException, FRETypeMismatchException, FREInvalidObjectException, FREWrongThreadException {
		return Leaderboard.Field.valueOf(object.getAsString());
	}
	
	public static Leaderboard.Field[] leaderFields(FREObject object) throws IllegalStateException, IllegalArgumentException, FRETypeMismatchException, FREInvalidObjectException, FREWrongThreadException {
		if (object == null) {
			return null;
		}
		FREArray array = (FREArray) object;
		long length = array.getLength();
		Leaderboard.Field[] target = new Leaderboard.Field[(int) length];

		for (int i = 0; i < length; ++i) {
			target[i] = leaderField(array.getObjectAt(i));
		}
		return target;
	}
	

	public static JSONObject pagingResultToJSON(PagingResult result) throws JSONException {
		return result.toJsonObject().put(".class", "com.mobage.air.social.PagingResult");
	}

	public static JSONObject itemDataToJSON(ItemData item) throws JSONException {
		return item.toJsonObject().put(".class", "com.mobage.air.bank.ItemData");
	}
	
	public static JSONObject remotePayloadToJSON(RemoteNotificationPayload remotePayload) throws JSONException {
		return remotePayload.toJsonObject().put(".class", "com.mobage.air.social.common.RemoteNotificationPayload");
	}
	
	public static JSONObject customRemotePayloadToJSON(RemoteNotificationPayload remotePayload, String state) throws JSONException {
		JSONObject json = remotePayload.toJsonObject();
		json.put("state", state);
		json.put(".class", "com.mobage.air.social.common.RemoteNotificationPayload");
		
		return json;
	}

	public static JSONObject transactionToJSON(Debit.Transaction txn) throws JSONException {
		JSONObject json = new JSONObject();
		json.put("id", txn.getId());

		JSONArray items = new JSONArray();
		for (Debit.BillingItem item : txn.getItems()) {
			items.put(item.toJsonObject());
		}
		json.put("items", items);
		json.put("comment", txn.getComment());
		json.put("published", txn.getPublished());
		json.put("state", txn.getState());
		json.put("updated", txn.getUpdated());
		json.put(".class", "com.mobage.air.bank.Transaction");
		return json;
	}

	public static JSONArray userListToJSON(ArrayList<User> users) throws JSONException {
		JSONArray jsonArray = new JSONArray();
		for (User user : users) {
			jsonArray.put(user.toJson().put(".class", "com.mobage.air.social.User"));
		}
		return jsonArray;
	}
	
	public static JSONArray leaderListToJSON(ArrayList<LeaderboardResponse> leaders) throws JSONException {
		JSONArray jsonArray = new JSONArray();
		for (LeaderboardResponse leader : leaders){
			jsonArray.put(transactionToJSON(leader));
		}
		return jsonArray;
	}
	
	public static JSONObject transactionToJSON(LeaderboardResponse lrpns) throws JSONException {
		JSONObject json = new JSONObject();
		
		json.put("allowLowerScore", lrpns.getAllowLowerScore());
		json.put("appId", lrpns.getAppId());
		json.put("archived", lrpns.getArchived());
		json.put("defaultScore", lrpns.getDefaultScore());
		json.put("iconUrl", lrpns.getIconUrl());		
		json.put("id", lrpns.getId());
		json.put("published", lrpns.getPublished());
		json.put("reverse", lrpns.getReverse());
		json.put("scoreFormat", lrpns.getScoreFormat());
		json.put("scorePrecision", lrpns.getScorePrecision());
		json.put("title", lrpns.getTitle());
		json.put("updated", lrpns.getUpdated());
		json.put(".class", "com.mobage.air.social.common.LeaderboardData");
		return json;
	}
	
	public static JSONArray leaderTopListToJSON(ArrayList<LeaderboardTopScore> topScores) throws JSONException {
		JSONArray jsonArray = new JSONArray();
		for (LeaderboardTopScore topScore : topScores){
			jsonArray.put(transactionToJSON(topScore));
		}
		return jsonArray;
	}
	
	public static JSONObject transactionToJSON(LeaderboardTopScore ltrpns) throws JSONException {
		JSONObject json = new JSONObject();
		
		json.put("displayValue", ltrpns.getDisplayValue());
		json.put("rank", ltrpns.getRank());
		json.put("userId", ltrpns.getUserId());
		json.put("value", ltrpns.getValue());

		json.put(".class", "com.mobage.air.social.common.LeaderboardTopScore");
		return json;
	}
	

	public static JSONArray stringListToJSON(ArrayList<String> list) {
		JSONArray jsonArray = new JSONArray();
		for (String item : list) {
			jsonArray.put(item);
		}
		return jsonArray;
	}
	
	public static JSONArray stringListToJSON(List<String> list) {
		JSONArray jsonArray = new JSONArray();
		for (String item : list) {
			jsonArray.put(item);
		}
		return jsonArray;
	}
	
	public static JSONObject responseToJSON(RemoteNotificationResponse rp) throws JSONException{
		JSONObject json = new JSONObject();
		json.put("payload", rp.getPayload().toJsonObject().put(".class", "com.mobage.air.social.common.RemoteNotificationPayload"));
		json.put("id", rp.getId());
		json.put("publishedTimestamp", rp.getPublishedTimestamp());
		
		return json;
	}

	public static JSONObject jpTextdataEntryToJSON(com.mobage.android.social.jp.Textdata.TextdataEntry entry) throws JSONException {
		return entry.toJsonObject().put(".class", "com.mobage.air.social.jp.TextdataEntry");
	}
	
	public static JSONObject convertMobageAdErrorToJSON(String adType, MobageAd.ErrorCode error) throws JSONException{
		JSONObject json = new JSONObject();
		json.put("adType", adType);
		json.put("error" , error.toString());
		
		json.put(".class", "com.mobage.air.ad.MobageAdError");
		return json;
	}
}
