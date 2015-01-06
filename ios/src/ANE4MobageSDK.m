/**
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
 **/

#import "ANE4MobageSDK.h"

// Mobage.as
#import "Mobage_initialize.h"
#import "Mobage_addPlatformListener.h"
#import "Mobage_removePlatformListener.h"
#import "Mobage_checkLoginStatus.h"
#import "Mobage_getSdkVersion.h"
#import "Mobage_onPause.h"
#import "Mobage_onResume.h"
#import "Mobage_showLoginDialog.h"
#import "Mobage_showLogoutDialog.h"
#import "Mobage_hideSplashScreen.h"
#import "Mobage_tick.h"
#import "Mobage_registerTick.h"
#ifdef JP
#import "Mobage_openUpgradeDialog.h"
#import "Mobage_addDashboardObserver.h"
#import "Mobage_removeDashboardObserver.h"
#import "Mobage_showNicknameRegistrationDialog.h"
#endif

// analytics Analytics.as
#ifdef JP
#import "EventReporter_report.h"
#endif

// ad MobageAd.as
#import "MobageAd_hideIconListView.h"
#import "MobageAd_showIconListView.h"
#import "MobageAd_loadIconListView.h"
#import "MobageAd_showPopupDialog.h"
#import "MobageAd_loadPopupDialog.h"
#import "MobageAdEventReporter_sendCustomEvent.h"
#ifdef JP
#import "MobageAd_loadOfferwall.h"
#import "MobageAd_showOfferwall.h"
#endif

// bank Account.as
#import "Account_getBalance.h"

// bank Debit.as
#import "Debit_cancelTransaction.h"
#import "Debit_closeTransaction.h"
#import "Debit_continueTransaction.h"
#import "Debit_createTransaction.h"
#import "Debit_getPendingTransaction.h"
#import "Debit_getTransaction.h"
#import "Debit_openTransaction.h"

// bank Inventory.as
#import "Inventory_getItem.h"

// social common Appdata.as
#import "common_Appdata_deleteEntries.h"
#import "common_Appdata_getEntries.h"
#import "common_Appdata_updateEntries.h"

// social common Auth.as
#import "common_Auth_authorizeToken.h"

// social common Blacklist.as
#import "common_Blacklist_checkBlacklist.h"

// social common Leaderboard.as
#import "common_Leaderboard_deleteCurrentUserScore.h"
#import "common_Leaderboard_getAllLeaderboards.h"
#import "common_Leaderboard_getFriendsScoresList.h"
#import "common_Leaderboard_getLeaderboard.h"
#import "common_Leaderboard_getLeaderboards.h"
#import "common_Leaderboard_getScore.h"
#import "common_Leaderboard_getTopScoresList.h"
#import "common_Leaderboard_updateCurrentUserScore.h"

// social common People.as
#import "common_People_getCurrentUser.h"
#import "common_People_getFriends.h"
#import "common_People_getFriendsWithGame.h"
#import "common_People_getUser.h"
#import "common_People_getUsers.h"

// social common Profanity.as
#import "common_Profanity_checkProfanity.h"

// social common RemoteNotification.as
#import "common_RemoteNotification_getRemoteNotificationsEnabled.h"
#import "common_RemoteNotification_setRemoteNotificationsEnabled.h"
#import "common_RemoteNotification_send_iOS.h"
#import "common_RemoteNotification_SetListener.h"

// social common Service.as
#import "common_Service_getBalanceButton.h"
#import "common_Service_updateBalanceButton.h"
#import "common_Service_removeBalanceButton.h"
#import "common_Service_launchPortalApp.h"
#import "common_Service_openFriendPicker.h"
#import "common_Service_openPlayerInviter.h"
#import "common_Service_openUserProfile.h"
#import "common_Service_showBankUi.h"
#import "common_Service_showCommunityUI.h"

// social jp Service.as
#import "jp_Service_openDocument.h"
#import "jp_Service_showCommunityButton.h"
#import "jp_Service_hideCommunityButton.h"
#import "jp_Service_shareMessage.h"

// social jp Textdata.as
#import "jp_Textdata_createEntry.h"
#import "jp_Textdata_getEntries.h"
#import "jp_Textdata_updateEntry.h"
#import "jp_Textdata_deleteEntry.h"

#ifdef KR
// social kr Service.as
#import "kr_Service_openDocument.h"
#import "kr_Service_showCommunityButton.h"
#import "kr_Service_hideCommunityButton.h"
#import "kr_Service_shareMessage.h"
#import "kr_Service_openFriendRequestSender.h"

// social kr Textdata.as
#import "kr_Textdata_createEntry.h"
#import "kr_Textdata_getEntries.h"
#import "kr_Textdata_updateEntry.h"
#import "kr_Textdata_deleteEntry.h"
#endif

// AlertDialog.as
#import "AlertDialog_show.h"

// Log.as
#import "Log_print.h"

// Objects
#import "FunctionSets.h"
#import "ContextOwner.h"

/*******************************************************************************
 *
 * Air Native Extension For Mobage SDK
 * iOS Sample
 *
 ******************************************************************************/
@interface ANE4MobageSDK()
// function name -> action script call name
+ (const uint8_t*)funcNameToASCallName:(NSString *)funcName;

@end

@implementation ANE4MobageSDK

+ (const uint8_t*)funcNameToASCallName:(NSString *)funcName {
    LOG_METHOD;
    funcName = [funcName stringByReplacingOccurrencesOfString:@"ANE4MBG_"
                                                   withString:@"com.mobage.air.extension."];
    funcName = [funcName stringByReplacingOccurrencesOfString:@"_"
                                                   withString:@"."];
    return (const uint8_t*)[funcName UTF8String];
}

#pragma mark - ANE4MobageSDKInitializer & ANE4MobageSDKFinalizer
void ANE4MobageSDKInitializer(void** const extDataToSet,
                              FREContextInitializer* const cxInitializerToSet,
                              FREContextFinalizer* const cxFinalizerToSet) {
    
    LOG_METHOD;
    *extDataToSet = NULL;
    *cxInitializerToSet = &ANE4MobageSDKContextInitializer;
    *cxFinalizerToSet   = &ANE4MobageSDKContextFinalizer;
}

void ANE4MobageSDKFinalizer(void* extData) {
    LOG_METHOD;
    (void)extData;
}

#pragma mark - ANE4MobageSDKContextInitializer & ANE4MobageSDKContextFinalizer
void ANE4MobageSDKContextInitializer(void* extData,
                                     const uint8_t* ctxType,
                                     FREContext ctx,
                                     uint32_t* numFunctionsToTest,
                                     const FRENamedFunction** functionsToSet) {
    LOG_METHOD;
    
    [ContextOwner setContext:ctx];
    
    FunctionSets *funcSets = [[[FunctionSets alloc] init] autorelease];
    
    // ContextInitializer
    // Mobage.as
    [Mobage_initialize ContextInitializer:funcSets];
    [Mobage_addPlatformListener ContextInitializer:funcSets];
    [Mobage_removePlatformListener ContextInitializer:funcSets];
    [Mobage_checkLoginStatus ContextInitializer:funcSets];
    [Mobage_getSdkVersion ContextInitializer:funcSets];
    [Mobage_onPause ContextInitializer:funcSets];
    [Mobage_onResume ContextInitializer:funcSets];
    [Mobage_showLoginDialog ContextInitializer:funcSets];
    [Mobage_showLogoutDialog ContextInitializer:funcSets];
    [Mobage_hideSplashScreen ContextInitializer:funcSets];
    [Mobage_tick ContextInitializer:funcSets];
    [Mobage_registerTick ContextInitializer:funcSets];
#ifdef JP
    [Mobage_openUpgradeDialog ContextInitializer:funcSets];
    [Mobage_addDashboardObserver ContextInitializer:funcSets];
    [Mobage_removeDashboardObserver ContextInitializer:funcSets];
    [Mobage_showNicknameRegistrationDialog ContextInitializer:funcSets];
#endif
    
    // analytics Analytics.as
#ifdef JP
    [EventReporter_report ContextInitializer:funcSets];
#endif
    
    // ad MobageAd.as
    [MobageAd_hideIconListView ContextInitializer:funcSets];
    [MobageAd_showIconListView ContextInitializer:funcSets];
    [MobageAd_loadIconListView ContextInitializer:funcSets];
    [MobageAd_showPopupDialog ContextInitializer:funcSets];
    [MobageAd_loadPopupDialog ContextInitializer:funcSets];
#ifdef JP
    [MobageAd_loadOfferwall ContextInitializer:funcSets];
    [MobageAd_showOfferwall ContextInitializer:funcSets];
#endif
    
    [MobageAdEventReporter_sendCustomEvent ContextInitializer:funcSets];
    
    // bank Account.as
    [Account_getBalance ContextInitializer:funcSets];
    
    // bank Debit.as
    [Debit_cancelTransaction ContextInitializer:funcSets];
    [Debit_closeTransaction ContextInitializer:funcSets];
    [Debit_continueTransaction ContextInitializer:funcSets];
    [Debit_createTransaction ContextInitializer:funcSets];
    [Debit_getPendingTransaction ContextInitializer:funcSets];
    [Debit_getTransaction ContextInitializer:funcSets];
    [Debit_openTransaction ContextInitializer:funcSets];
    
    // bank Inventory.as
    [Inventory_getItem ContextInitializer:funcSets];
    
    // social common Appdata.as
    [common_Appdata_deleteEntries ContextInitializer:funcSets];
    [common_Appdata_getEntries ContextInitializer:funcSets];
    [common_Appdata_updateEntries ContextInitializer:funcSets];
    
    // social common Auth.as
    [common_Auth_authorizeToken ContextInitializer:funcSets];
    
    // social common Blacklist.as
    [common_Blacklist_checkBlacklist ContextInitializer:funcSets];
    
    // social common Leaderboard.as
    [common_Leaderboard_deleteCurrentUserScore ContextInitializer:funcSets];
    [common_Leaderboard_getAllLeaderboards ContextInitializer:funcSets];
    [common_Leaderboard_getFriendsScoresList ContextInitializer:funcSets];
    [common_Leaderboard_getLeaderboard ContextInitializer:funcSets];
    [common_Leaderboard_getLeaderboards ContextInitializer:funcSets];
    [common_Leaderboard_getScore ContextInitializer:funcSets];
    [common_Leaderboard_getTopScoresList ContextInitializer:funcSets];
    [common_Leaderboard_updateCurrentUserScore ContextInitializer:funcSets];
    
    // social common People.as
    [common_People_getCurrentUser ContextInitializer:funcSets];
    [common_People_getFriends ContextInitializer:funcSets];
    [common_People_getFriendsWithGame ContextInitializer:funcSets];
    [common_People_getUser ContextInitializer:funcSets];
    [common_People_getUsers ContextInitializer:funcSets];
    
    // social common Profanity.as
    [common_Profanity_checkProfanity ContextInitializer:funcSets];
    
    // social common RemoteNotification.as
    [common_RemoteNotification_getRemoteNotificationsEnabled ContextInitializer:funcSets];
    [common_RemoteNotification_setRemoteNotificationsEnabled ContextInitializer:funcSets];
    [common_RemoteNotification_send_iOS ContextInitializer:funcSets];
    [common_RemoteNotification_SetListener ContextInitializer:funcSets];
    
    // social common Service.as
    [common_Service_getBalanceButton ContextInitializer:funcSets];
    [common_Service_updateBalanceButton ContextInitializer:funcSets];
    [common_Service_removeBalanceButton ContextInitializer:funcSets];
    [common_Service_launchPortalApp ContextInitializer:funcSets];
    [common_Service_openFriendPicker ContextInitializer:funcSets];
	[common_Service_openPlayerInviter ContextInitializer:funcSets];
    [common_Service_openUserProfile ContextInitializer:funcSets];
    [common_Service_showBankUi ContextInitializer:funcSets];
    [common_Service_showCommunityUI ContextInitializer:funcSets];
    
    // social jp Service.as
    [jp_Service_openDocument ContextInitializer:funcSets];
    [jp_Service_showCommunityButton ContextInitializer:funcSets];
    [jp_Service_hideCommunityButton ContextInitializer:funcSets];
    [jp_Service_shareMessage ContextInitializer:funcSets];
    
    // social jp Textdata.as
    [jp_Textdata_createEntry ContextInitializer:funcSets];
    [jp_Textdata_getEntries ContextInitializer:funcSets];
    [jp_Textdata_updateEntry ContextInitializer:funcSets];
    [jp_Textdata_deleteEntry ContextInitializer:funcSets];
    
#ifdef KR
    // social kr Service.as
    [kr_Service_openDocument ContextInitializer:funcSets];
    [kr_Service_showCommunityButton ContextInitializer:funcSets];
    [kr_Service_hideCommunityButton ContextInitializer:funcSets];
    [kr_Service_shareMessage ContextInitializer:funcSets];
    [kr_Service_openFriendRequestSender ContextInitializer:funcSets];
    
    // social kr Textdata.as
    [kr_Textdata_createEntry ContextInitializer:funcSets];
    [kr_Textdata_getEntries ContextInitializer:funcSets];
    [kr_Textdata_updateEntry ContextInitializer:funcSets];
    [kr_Textdata_deleteEntry ContextInitializer:funcSets];
#endif
    
    // AlertDialog.as
    [AlertDialog_show ContextInitializer:funcSets];
    
    // Log.as
    [Log_print ContextInitializer:funcSets];
    
    FRENamedFunction* const func = (FRENamedFunction*)malloc(sizeof(FRENamedFunction) * funcSets.count);
    for (int index = 0; index < funcSets.count; index++) {
        FunctionSet *funcSet = [funcSets.functionSets objectAtIndex:index];
        func[index].name = [ANE4MobageSDK funcNameToASCallName:funcSet.name];
        func[index].functionData = NULL;
        func[index].function = funcSet.func;
        
        LOG(@"[%d/(%d + 1)]name [%s] func [%p]", index, funcSets.count, func[index].name, func[index].function);
    }
    
    *functionsToSet = func;
    *numFunctionsToTest = funcSets.count;
}

void ANE4MobageSDKContextFinalizer(FREContext ctx) {
    LOG_METHOD;
}

@end