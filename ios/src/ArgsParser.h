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

#import <Foundation/Foundation.h>
#import <FlashRuntimeExtensions.h>

#import "MBGPlatform.h"
#import "MBGBankDebit.h"
#import "MBGLeaderboardResponse.h"
#import "MBGLeaderboardTopScore.h"
#import "MBGUser.h"
#import "MBGRemoteNotificationPayload.h"
#import "MBGRemoteNotificationResponse.h"
#import "MBGSocialJPService.h"
#import "MBGSocialJPTextdata.h"
#ifdef KR
#import "MBGSocialKRTextdata.h"
#endif
#import <MBGADIconListView.h>

@interface ArgsParser : NSObject
#pragma mark - shared argment parser instance
+ (ArgsParser *)sharedParser;

#pragma mark - convert result report
+ (void)reportResult:(FREResult)result;

#pragma mark - convert Objective-C Object => FreObject
// convert NSString to FreObject
+ (FREObject)stringToObject:(NSString *)string;

#pragma mark - convert FreObject => Objective-C Object
// first call method. Before using "nextXXX"
- (void)setArgc:(uint32_t const)argc argv:(FREObject* const)argv;

// convert FreObject to Bool value.
- (BOOL)nextBool;

// convert FreObject to NSInteger value.
- (NSInteger)nextInt;

// convert FreObject to float value.
- (float)nextFloat;

// convert FreObject to double value.
- (double)nextDouble;

// convert FreObject to NSString value.
- (NSString *)nextString;

// convert FreObject to NSArray value.
- (NSArray *)nextArray;

// convert FreObject to NSDictionary value.
- (NSDictionary *)nextDictionary;

// convert FreObject to NSData value.
- (NSData *)nextData;

// convert FreObject to MBG_REGION type.
- (NSInteger)nextRegion;

// convert FreObject to MBG_SERVERMODE type.
- (NSInteger)nextServerMode;

// convert FreObject to MBGOption object.
- (MBGOption *)nextOption;

// convert FreObject to MBGRemoteNotificationPayload object.
- (MBGRemoteNotificationPayload *)nextPayload;

// convert FreObject to MBG_DOCUMENT_TYPE type.
- (NSInteger)nextDocumentType;

// convert FreObject to MBG_Gravity type.
- (MBG_Gravity)nextGravity;

// convert FreObject to MBGJPTextdataEntry object.
- (MBGJPTextdataEntry *)nextJPTextdataEntry;

#ifdef KR
// convert FreObject to MBGKRTextdataEntry object.
- (MBGKRTextdataEntry *)nextKRTextdataEntry;
#endif

// convert FreObject to MBGBillingItem object.
- (MBGBillingItem *)nextBillingItem;

// convert FreObject to MBGBillingItem's Array.
- (NSArray *)nextBillingItems;

#ifdef JP
// convert FreObject to MBGTargetUserGrade type.
- (MBGTargetUserGrade)nextTargetUserGrade;
#endif

// convert FreObject to UserFeild Array
- (NSArray *)nextUserFeilds;

// convert FreObject to LeaderboardFeild Array
- (NSArray *)nextLeaderboardFeilds;

// convert FreObject to MBGADFrameID type.
-(MBGADFrameID)nextFrameID;

// convert FreObject to MBGBannerPosition type.
- (MBGBannerPosition)nextBannerPosition;

#pragma mark - convert Mobage object to JSON
// convert MBGTransaction to NSDictionary
+ (NSDictionary *)transactionToJSON:(MBGTransaction *)transaction;

// convert MBGItemData to NSDictionary
+ (NSDictionary *)itemDataToJSON:(MBGItemData *)itemData;

// convert MBGResult to NSDictionary
+ (NSDictionary *)resultToJSON:(MBGResult *)result;

// convert MBGLeaderboardResponse to NSDictionary
+ (NSDictionary *)leaderboardToJSON:(MBGLeaderboardResponse *)leaderboad;

// convert MBGLeaderboardResponse's Array to NSArray
+ (NSArray *)leaderboardsToJSON:(NSArray *)leaderboards;

// convert MBGLeaderboardTopScore to NSDictionary
+ (NSDictionary *)topScoreToJSON:(MBGLeaderboardTopScore *)topSocre;

// convert MBGLeaderboardTopScore's Array to NSArray
+ (NSArray *)topScoresToJSON:(NSArray *)topSocres;

// convert MBGUser to NSArray
+ (NSDictionary *)userToJSON:(MBGUser *)user;

// convert MBGUser's Array to NSArray
+ (NSArray *)usersToJSON:(NSArray *)users;

// convert MBGRemoteNotificationResponse to NSArray
+ (NSDictionary *)responseToJSON:(MBGRemoteNotificationResponse *)response;

// convert MBGRemoteNotificationPayload to NSArray
+ (NSDictionary *)payloadToJSON:(MBGRemoteNotificationPayload *)payload;

// convert MBGJPTextdataEntry to NSArray
+ (NSDictionary *)jpTextdataEntryToJSON:(MBGJPTextdataEntry *)textEntry;

// convert MBGJPTextdataEntry's Array to NSArray
+ (NSArray *)jpTextdataEntriesToJSON:(NSArray *)textEntries;

// convert MBGBillingItem to NSDictionary
+ (NSDictionary *)billingItemToJSON:(MBGBillingItem *)billingItem;

@end