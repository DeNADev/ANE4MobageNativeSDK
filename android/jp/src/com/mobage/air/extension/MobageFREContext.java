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

import java.util.HashMap;
import java.util.Map;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.mobage.air.extension.ad.MobageAdEventReporter_sendCustomEvent;
import com.mobage.air.extension.ad.MobageAd_hideIconListView;
import com.mobage.air.extension.ad.MobageAd_loadIconListView;
import com.mobage.air.extension.ad.MobageAd_loadOfferwall;
import com.mobage.air.extension.ad.MobageAd_loadPopupDialog;
import com.mobage.air.extension.ad.MobageAd_showIconListView;
import com.mobage.air.extension.ad.MobageAd_showOfferwall;
import com.mobage.air.extension.ad.MobageAd_showPopupDialog;
import com.mobage.air.extension.analytics.EventReporter_report;
import com.mobage.air.extension.bank.Account_getBalance;
import com.mobage.air.extension.bank.Debit_cancelTransaction;
import com.mobage.air.extension.bank.Debit_closeTransaction;
import com.mobage.air.extension.bank.Debit_continueTransaction;
import com.mobage.air.extension.bank.Debit_createTransaction;
import com.mobage.air.extension.bank.Debit_getPendingTransactions;
import com.mobage.air.extension.bank.Debit_getTransaction;
import com.mobage.air.extension.bank.Debit_openTransaction;
import com.mobage.air.extension.bank.Inventory_getItem;
import com.mobage.air.extension.social.common.Appdata_deleteEntries;
import com.mobage.air.extension.social.common.Appdata_getEntries;
import com.mobage.air.extension.social.common.Appdata_updateEntries;
import com.mobage.air.extension.social.common.Auth_authorizeToken;
import com.mobage.air.extension.social.common.Blacklist_checkBlacklist;
import com.mobage.air.extension.social.common.Leaderboard_deleteCurrentUserScore;
import com.mobage.air.extension.social.common.Leaderboard_getAllLeaderboards;
import com.mobage.air.extension.social.common.Leaderboard_getFriendsScoresList;
import com.mobage.air.extension.social.common.Leaderboard_getLeaderboard;
import com.mobage.air.extension.social.common.Leaderboard_getLeaderboards;
import com.mobage.air.extension.social.common.Leaderboard_getScore;
import com.mobage.air.extension.social.common.Leaderboard_getTopScoresList;
import com.mobage.air.extension.social.common.Leaderboard_updateCurrentUserScore;
import com.mobage.air.extension.social.common.People_getCurrentUser;
import com.mobage.air.extension.social.common.People_getFriends;
import com.mobage.air.extension.social.common.People_getFriendsWithGame;
import com.mobage.air.extension.social.common.People_getUser;
import com.mobage.air.extension.social.common.People_getUsers;
import com.mobage.air.extension.social.common.Profanity_checkProfanity;
import com.mobage.air.extension.social.common.RemoteNotification_getRemoteNotificationsEnabled;
import com.mobage.air.extension.social.common.RemoteNotification_send;
import com.mobage.air.extension.social.common.RemoteNotification_setListener;
import com.mobage.air.extension.social.common.RemoteNotification_setRemoteNotificationsEnabled;
import com.mobage.air.extension.social.common.Service_getBalanceButton;
import com.mobage.air.extension.social.common.Service_launchPortalApp;
import com.mobage.air.extension.social.common.Service_openFriendPicker;
import com.mobage.air.extension.social.common.Service_openUserProfile;
import com.mobage.air.extension.social.common.Service_removeBalanceButton;
import com.mobage.air.extension.social.common.Service_showBankUi;
import com.mobage.air.extension.social.common.Service_showCommunityUI;
import com.mobage.air.extension.social.common.Service_updateBalanceButton;
import com.mobage.air.extension.social.jp.Service_hideCommunityButton;
import com.mobage.air.extension.social.jp.Service_openDocument;
import com.mobage.air.extension.social.jp.Service_shareMessage;
import com.mobage.air.extension.social.jp.Service_showCommunityButton;
import com.mobage.air.extension.social.jp.Textdata_createEntry;
import com.mobage.air.extension.social.jp.Textdata_deleteEntry;
import com.mobage.air.extension.social.jp.Textdata_getEntries;
import com.mobage.air.extension.social.jp.Textdata_updateEntry;

public class MobageFREContext extends FREContext {

	private Map<String, FREFunction> map = new HashMap<String, FREFunction>();

	public MobageFREContext() {
		super();

		// class Log
		register(Log_print.class);

		// class AlertDialog
		register(AlertDialog_show.class);

		// class Mobage
		register(Mobage_getSdkVersion.class);
		register(Mobage_initialize.class);
		register(Mobage_addPlatformListener.class);
		register(Mobage_removePlatformListener.class);
		register(Mobage_hideSplashScreen.class);
		register(Mobage_showLoginDialog.class);
		register(Mobage_showLogoutDialog.class);
		register(Mobage_onCreate.class);
		register(Mobage_onDestroy.class);
		register(Mobage_onPause.class);
		register(Mobage_onRestart.class);
		register(Mobage_onResume.class);
		register(Mobage_onStart.class);
		register(Mobage_onStop.class);
		register(Mobage_checkLoginStatus.class);
		register(Mobage_openUpgradeDialog.class);
		register(Mobage_registerTick.class);
		register(Mobage_showNicknameRegistrationDialog.class);

		// class Appdata
		register(Appdata_deleteEntries.class);
		register(Appdata_getEntries.class);
		register(Appdata_updateEntries.class);

		// class Auth
		register(Auth_authorizeToken.class);

		// class Blacklist
		register(Blacklist_checkBlacklist.class);

		// class Profanity
		register(Profanity_checkProfanity.class);

		// class Service
		register(Service_launchPortalApp.class);
		register(Service_openFriendPicker.class);
		register(Service_openUserProfile.class);
		register(Service_showBankUi.class);
		register(Service_getBalanceButton.class);
		register(Service_removeBalanceButton.class);
		register(Service_updateBalanceButton.class);
		register(Service_showCommunityUI.class);

		// class People
		register(People_getCurrentUser.class);
		register(People_getFriends.class);
		register(People_getFriendsWithGame.class);
		register(People_getUser.class);
		register(People_getUsers.class);

		// class Bank
		register(Debit_cancelTransaction.class);
		register(Debit_closeTransaction.class);
		register(Debit_continueTransaction.class);
		register(Debit_createTransaction.class);
		register(Debit_getPendingTransactions.class);
		register(Debit_getTransaction.class);
		register(Debit_openTransaction.class);
		register(Account_getBalance.class);

		// class Inentory
		register(Inventory_getItem.class);
		
		// class RemoteNotification
		register(RemoteNotification_getRemoteNotificationsEnabled.class);
		register(RemoteNotification_send.class);
		register(RemoteNotification_setRemoteNotificationsEnabled.class);
		register(RemoteNotification_setListener.class);
		
		// class LeaderBoard
		register(Leaderboard_deleteCurrentUserScore.class);
		register(Leaderboard_getAllLeaderboards.class);
		register(Leaderboard_getFriendsScoresList.class);
		register(Leaderboard_getLeaderboard.class);
		register(Leaderboard_getLeaderboards.class);
		register(Leaderboard_getScore.class);
		register(Leaderboard_getTopScoresList.class);
		register(Leaderboard_updateCurrentUserScore.class);

		// namespace social.jp
		register(Service_openDocument.class);
		register(Textdata_createEntry.class);
		register(Textdata_getEntries.class);
		register(Textdata_updateEntry.class);
		register(Textdata_deleteEntry.class);
		register(Service_showCommunityButton.class);
		register(Service_hideCommunityButton.class);
		register(Service_shareMessage.class);
		
		// class Notification
		register(Mobage_addDashboardObserver.class);
		register(Mobage_removeDashboardObserver.class);
		
		// class MobageAd
		register(MobageAd_showIconListView.class);
		register(MobageAd_hideIconListView.class);
		register(MobageAd_loadIconListView.class);
		register(MobageAd_loadPopupDialog.class);
		register(MobageAd_showPopupDialog.class);
		register(MobageAdEventReporter_sendCustomEvent.class);
		register(MobageAd_loadOfferwall.class);
		register(MobageAd_showOfferwall.class);
		
		// class analytics
		register(EventReporter_report.class);

	}

	@Override
	public Map<String, FREFunction> getFunctions() {
		return map;
	}

	@Override
	public void dispose() {
		Log.i(MobageFREExtension.TAG, "MobageFREContext#dispose()");
	}

	private void register(Class<? extends FREFunction> klass) {
		String name = MobageFREExtension.name(klass.getName());
		try {
			map.put(name, klass.newInstance());
		} catch (Exception e) {
			Dispatcher.exception(this, e);
		}
		Log.v(MobageFREExtension.TAG, "register: " + name);
	}

}
