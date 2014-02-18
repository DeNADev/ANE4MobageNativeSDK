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

#import "ArgsParser.h"

static ArgsParser *_argParser = nil;

@interface ArgsParser ()
/**
 * 
 **/
// get next FreObject
- (FREObject)next;

/**
 * covertion stuff
 **/
// convert FreObject to BOOL
+ (BOOL)objectToBool:(FREObject)boolObject;

// convert FreObject to NSInteger
+ (NSInteger)objectToInteger:(FREObject)intObject;

// convert FreObject to double
+ (double)objectToDouble:(FREObject)doubleObject;

// convert FreObject to NSData
+ (NSData *)objectToData:(FREObject)freObject;

// convert FreObject to NSString
+ (NSString *)objectToString:(FREObject)freObject;

// convert FreObject to NSArray
+ (NSArray *)objectToArray:(FREObject)freArray;

// convert FreObject to NSDictionary
+ (NSDictionary *)objectToDictionary:(FREObject)freAssocArray;

// convert FreObject to MBGOption
+ (MBGOption *)objectToOption:(FREObject)freObject;

// convert FreObject to MBGBillingItem
+ (MBGBillingItem *)objectToBillingItem:(FREObject)freObject;

// convert FreObject to MBGItemData
+ (MBGItemData *)objectToItemData:(FREObject)freObject;

// convert FreObject to MBGRemoteNotificationPayload
+ (MBGRemoteNotificationPayload *)objectToPayload:(FREObject)freObject;

// convert FreObject to MBGJPTextdataEntry
+ (MBGJPTextdataEntry *)objectToJPTextdataEntry:(FREObject)freObject;

#ifdef KR
// convert FreObject to MBGKRTextdataEntry
+ (MBGKRTextdataEntry *)objectToKRTextdataEntry:(FREObject)freObject;
#endif

/**
 * convert helper
 **/
// get FreObject property value for key
+ (FREResult)getFREObjectProperty:(FREObject)freObject
                              key:(NSString *)key
                            value:(FREObject *)value;

/**
 * nil check
 **/
+ (id)nilCheck:(id)obj;

@end

@implementation ArgsParser {
    uint32_t _argc;
    FREObject* _argv;
    int _currentIndex;
}

#pragma mark - 
+ (void)initialize {
    // MARK: Initialize ArgPaser instance only one time.
    if (!_argParser) {
        _argParser = [[ArgsParser alloc] init];
    }
}

+ (ArgsParser *)sharedParser {
    return _argParser;
}

#pragma mark - convert result report
#ifdef DEBUG
+ (void)reportResult:(FREResult)result {
    LOG_METHOD;
    NSString *resultString = nil;
    switch (result) {
        case FRE_OK:
            resultString = @"FRE_OK";
            break;
        case FRE_NO_SUCH_NAME:
            resultString = @"FRE_NO_SUCH_NAME";
            break;
        case FRE_INVALID_OBJECT:
            resultString = @"FRE_INVALID_OBJECT";
            break;
        case FRE_TYPE_MISMATCH:
            resultString = @"FRE_TYPE_MISMATCH";
            break;
        case FRE_ACTIONSCRIPT_ERROR:
            resultString = @"FRE_ACTIONSCRIPT_ERROR";
            break;
        case FRE_INVALID_ARGUMENT:
            resultString = @"FRE_INVALID_ARGUMENT";
            break;
        case FRE_READ_ONLY:
            resultString = @"FRE_READ_ONLY";
            break;
        case FRE_WRONG_THREAD:
            resultString = @"FRE_WRONG_THREAD";
            break;
        case FRE_ILLEGAL_STATE:
            resultString = @"FRE_ILLEGAL_STATE";
            break;
        case FRE_INSUFFICIENT_MEMORY:
            resultString = @"FRE_INSUFFICIENT_MEMORY";
            break;
        case FREResult_ENUMPADDING:
        default:
            resultString = @"Unknown FREResult";
            break;
    }
    LOG(@"%@ at %s line %d", resultString,  __FILE__, __LINE__);
}
#else
+ (void)reportResult:(FREResult)result {}
#endif

#pragma mark - convert Objective-C Object => FreObject
+ (FREObject)stringToObject:(NSString *)string {
    LOG_METHOD;
    FREObject freObject = NULL;
    FREResult result = FRENewObjectFromUTF8(strlen((const char*)[string UTF8String]) + 1,
                                            (const uint8_t*)[string UTF8String],
                                            &freObject);
    if (result != FRE_OK) {
        [ArgsParser reportResult:result];
    }
    return freObject;
}

#pragma mark - convert
- (void)setArgc:(uint32_t const)argc argv:(FREObject* const)argv {
    LOG_METHOD;
    _argc = argc;
    _argv = argv;
    _currentIndex = 0;
    
}

- (FREObject)next {
    LOG_METHOD;
    FREObject obj = NULL;
    if (_currentIndex < _argc) {
        obj = _argv[_currentIndex++];
    }
    return obj;
}

- (BOOL)nextBool {
    LOG_METHOD;
    BOOL value = [ArgsParser objectToBool:[_argParser next]];
    LOG(@"return %d", value);
    return value;
}

- (NSInteger)nextInt {
    LOG_METHOD;
    NSInteger value = [ArgsParser objectToInteger:[_argParser next]];
    LOG(@"return %d", value);
    return value;
}

- (float)nextFloat {
    LOG_METHOD;
    float value = (float)[_argParser nextDouble];
    LOG(@"return %f", value);
    return value;
}

- (double)nextDouble {
    LOG_METHOD;
    double value = [ArgsParser objectToDouble:[_argParser next]];
    LOG(@"return %lf", value);
    return value;
}

- (NSString *)nextString {
    LOG_METHOD;
    NSString *value = [ArgsParser objectToString:[_argParser next]];
    LOG(@"return %@", value);
    return value;
}

- (NSArray *)nextArray {
    LOG_METHOD;
    NSArray *value = [ArgsParser objectToArray:[_argParser next]];
    LOG(@"return %@", value);
    return value;
}

- (NSDictionary *)nextDictionary {
    LOG_METHOD;
    NSDictionary *value = [ArgsParser objectToDictionary:[_argParser next]];
    LOG(@"return %@", value);
    return value;
}

- (NSData *)nextData {
    LOG_METHOD;
    NSData *data = [ArgsParser objectToData:[_argParser next]];
    LOG(@"return %@", data);
    return data;
}

- (NSInteger)nextRegion {
    LOG_METHOD;
    NSDictionary *regionMap = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInteger:MBG_REGION_US], @"US",
                               [NSNumber numberWithInteger:MBG_REGION_JP], @"JP",
                               [NSNumber numberWithInteger:MBG_REGION_CN], @"CN",
                               [NSNumber numberWithInteger:MBG_REGION_KR], @"KR", nil];

    NSInteger value = [[regionMap valueForKey:[ArgsParser objectToString:[_argParser next]]] integerValue];
    LOG(@"return %d", value);
    return value;
}

- (NSInteger)nextServerMode {
    LOG_METHOD;
    NSDictionary *serverTypeMap = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSNumber numberWithInteger:MBG_SANDBOX], @"SANDBOX",
                                   [NSNumber numberWithInteger:MBG_PRODUCTION], @"PRODUCTION", nil];

    NSInteger value = [[serverTypeMap valueForKey:[ArgsParser objectToString:[_argParser next]]] integerValue];
    LOG(@"return %d", value);
    return value;
}

- (MBGOption *)nextOption {
    LOG_METHOD;
    MBGOption *value = [ArgsParser objectToOption:[_argParser next]];
    LOG(@"return %@", value);
    return value;
}

- (MBGRemoteNotificationPayload *)nextPayload {
    LOG_METHOD;
    MBGRemoteNotificationPayload *payload = [ArgsParser objectToPayload:[_argParser next]];
    LOG(@"return %@", payload);
    return payload;
}

- (NSInteger)nextDocumentType {
    LOG_METHOD;
    NSDictionary *regionMap = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInteger:MBG_LEGAL], @"LEGAL",
                               [NSNumber numberWithInteger:MBG_AGREEMENT], @"AGREEMENT",
                               [NSNumber numberWithInteger:MBG_CONTACT], @"CONTACT",
                               [NSNumber numberWithInteger:MBG_TOS_LITE], @"TOS_LITE",
                               [NSNumber numberWithInteger:MBG_AGREEMENT_LITE], @"AGREEMENT_LITE",
                               [NSNumber numberWithInteger:MBG_SMS_VERIFICATION], @"SMS_VERIFICATION", nil];

    NSInteger value = [[regionMap valueForKey:[ArgsParser objectToString:[_argParser next]]] integerValue];
    LOG(@"return %d", value);
    return value;
}

- (MBG_Gravity)nextGravity {
    LOG_METHOD;
    NSDictionary *regionMap = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInteger:MBG_GRAVITY_TOP_LEFT], @"TOP_LEFT",
                               [NSNumber numberWithInteger:MBG_GRAVITY_TOP_RIGHT], @"TOP_RIGHT",
                               [NSNumber numberWithInteger:MBG_GRAVITY_BOTTOM_LEFT], @"BOTTOM_LEFT",
                               [NSNumber numberWithInteger:MBG_GRAVITY_BOTTOM_RIGHT], @"BOTTOM_RIGHT", nil];
  
    NSInteger value = [[regionMap valueForKey:[ArgsParser objectToString:[_argParser next]]] integerValue];
    LOG(@"return %d", value);
    return (MBG_Gravity)value;
}

- (MBGJPTextdataEntry *)nextJPTextdataEntry {
    LOG_METHOD;
    
    MBGJPTextdataEntry *entry = [ArgsParser objectToJPTextdataEntry:[_argParser next]];
    LOG(@"return %@", entry);
    return entry;
}

#ifdef KR
- (MBGKRTextdataEntry *)nextKRTextdataEntry {
    LOG_METHOD;
    
    MBGKRTextdataEntry *entry = [ArgsParser objectToKRTextdataEntry:[_argParser next]];
    LOG(@"return %@", entry);
    return entry;
}
#endif

- (MBGBillingItem *)nextBillingItem {
    LOG_METHOD;
    MBGBillingItem *value = [ArgsParser objectToBillingItem:[_argParser next]];
    LOG(@"return %@ (item = %@, quantity = %d)", value, value.item, value.quantity);
    return value;
}

- (NSArray *)nextBillingItems {
    LOG_METHOD;

    FREObject *freArray = [_argParser next];
    NSMutableArray* array = [NSMutableArray array];
    
    uint32_t len;
    FREResult result = FREGetArrayLength(freArray, &len);
    if(result != FRE_OK) {
        [ArgsParser reportResult:result];
        return array;
    }
    for(uint32_t i = 0; i < len; i++) {
        FREObject value;
        result = FREGetArrayElementAt(freArray, i, &value);
        if(result != FRE_OK) {
            [ArgsParser reportResult:result];
            return array;
        }
        [array addObject: [ArgsParser objectToBillingItem:value]];
    }
    
    LOG(@"return %@", array);
    return [NSArray arrayWithArray:array];
}

#ifdef JP
- (MBGTargetUserGrade)nextTargetUserGrade {
    LOG_METHOD;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [NSNumber numberWithInteger:MBG_TARGET_USER_GRADE_DEFAULT], @"DEFAULT",
                         [NSNumber numberWithInteger:MBG_TARGET_USER_GRADE_GRADE2], @"GRADE2",
                         [NSNumber numberWithInteger:MBG_TARGET_USER_GRADE_GRADE3], @"GRADE3", nil];

    NSString *key = [_argParser nextString];
    MBGTargetUserGrade grade = [[dic valueForKey:key] integerValue];
    LOG(@"return %d", grade);
    return grade;
}
#endif

- (NSArray *)nextUserFeilds {
    LOG_METHOD;
    
    NSDictionary *feildMap = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"id", @"ID",
                              @"displayName", @"DISPLAY_NAME",
                              @"nickname", @"NICKNAME",
                              @"aboutMe", @"ABOUT_ME",
                              @"age", @"AGE",
                              @"birthday", @"BIRTHDAY",
                              @"gender", @"GENDER",
                              @"hasApp", @"HAS_APP",
                              @"thumbnailUrl", @"THUMBNAIL_URL",
                              @"jobType", @"JOB_TYPE",
                              @"bloodType", @"BLOOD_TYPE",
                              @"isVerified", @"IS_VERIFIED",
                              @"isFamous", @"IS_FAMOUS",
                              @"grade", @"GRADE", nil];
    
    NSArray *feilds = [_argParser nextArray];
    NSMutableArray *ary = [NSMutableArray array];
    for (NSString *key in feilds) {
        [ary addObject:[feildMap valueForKey:key]];
    }
    LOG(@"return %@", ary);
    return [NSArray arrayWithArray:ary];
}

- (NSArray *)nextLeaderboardFeilds {
    LOG_METHOD;
    
    NSDictionary *feildMap = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"allowLowerScore", @"ALLOW_LOWER_SCORE",
                              @"appId", @"APP_ID",
                              @"archived", @"ARCHIVED",
                              @"defaultScore", @"DEFAULT_SCORE",
                              @"scoreFormat", @"FORMAT",
                              @"iconUrl", @"ICON_URL",
                              @"id", @"ID",
                              @"scorePrecision", @"PRECISION",
                              @"published", @"PUBLISHED",
                              @"reverse", @"REVERSE",
                              @"title", @"TITLE",
                              @"updated", @"UPDATED",
                              @"rank", @"RANK",
                              @"displayValue", @"DISPLAY_VALUE",
                              @"userId", @"USER_ID",
                              @"value", @"VALUE", nil];
    
    NSArray *feilds = [_argParser nextArray];
    NSMutableArray *ary = [NSMutableArray array];
    for (NSString *key in feilds) {
        [ary addObject:[feildMap valueForKey:key]];
    }
    LOG(@"return %@", ary);
    return [NSArray arrayWithArray:ary];
}

-(MBGADFrameID)nextFrameID {
    LOG_METHOD;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [NSNumber numberWithInteger:MBGADFrameID_A], @"A",
                         [NSNumber numberWithInteger:MBGADFrameID_B], @"B",
                         [NSNumber numberWithInteger:MBGADFrameID_C], @"C",
                         [NSNumber numberWithInteger:MBGADFrameID_D], @"D",
                         [NSNumber numberWithInteger:MBGADFrameID_E], @"E",
                         [NSNumber numberWithInteger:MBGADFrameID_F], @"F",
                         [NSNumber numberWithInteger:MBGADFrameID_G], @"G",
                         [NSNumber numberWithInteger:MBGADFrameID_H], @"H",
                         [NSNumber numberWithInteger:MBGADFrameID_I], @"I",
                         [NSNumber numberWithInteger:MBGADFrameID_J], @"J",
                         [NSNumber numberWithInteger:MBGADFrameID_K], @"K",
                         [NSNumber numberWithInteger:MBGADFrameID_L], @"L",
                         [NSNumber numberWithInteger:MBGADFrameID_M], @"M",
                         [NSNumber numberWithInteger:MBGADFrameID_N], @"N",
                         [NSNumber numberWithInteger:MBGADFrameID_O], @"O",
                         [NSNumber numberWithInteger:MBGADFrameID_P], @"P",
                         [NSNumber numberWithInteger:MBGADFrameID_Q], @"Q",
                         [NSNumber numberWithInteger:MBGADFrameID_R], @"R",
                         [NSNumber numberWithInteger:MBGADFrameID_S], @"S",
                         [NSNumber numberWithInteger:MBGADFrameID_T], @"T",
                         [NSNumber numberWithInteger:MBGADFrameID_U], @"U",
                         [NSNumber numberWithInteger:MBGADFrameID_V], @"V",
                         [NSNumber numberWithInteger:MBGADFrameID_W], @"W",
                         [NSNumber numberWithInteger:MBGADFrameID_X], @"X",
                         [NSNumber numberWithInteger:MBGADFrameID_Y], @"Y",
                         [NSNumber numberWithInteger:MBGADFrameID_Z], @"Z", nil];
    
    NSString *key = [_argParser nextString];
    MBGADFrameID frameID = [[dic valueForKey:key] integerValue];
    LOG(@"return %d", frameID);
    return frameID;
}

- (MBGBannerPosition)nextBannerPosition {
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [NSNumber numberWithInteger:MBGBannerPositionTop], @"TOP",
                         [NSNumber numberWithInteger:MBGBannerPositionBottom], @"BOTTOM", nil];
    
    NSString *key = [_argParser nextString];
    MBGADFrameID bannerPosition = [[dic valueForKey:key] integerValue];
    LOG(@"return %d", bannerPosition);
    return bannerPosition;
}

#pragma mark - convert Mobage object to JSON
+ (NSDictionary *)transactionToJSON:(MBGTransaction *)transaction {
    LOG_METHOD;
    
    NSMutableArray *items = [NSMutableArray array];
    for (int index = 0; index < transaction.items.count; index++) {
        [items addObject:[ArgsParser billingItemToJSON:[transaction.items objectAtIndex:index]]];
    }

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         transaction.id, @"id",
                         items, @"items",
                         [ArgsParser nilCheck:transaction.comment], @"comment",
                         [ArgsParser nilCheck:transaction.published], @"published",
                         [ArgsParser nilCheck:transaction.state], @"state",
                         [ArgsParser nilCheck:transaction.updated], @"updated",
                         @"com.mobage.air.bank.Transaction", @".class", nil];
  
    return dic;
}

+ (NSDictionary *)itemDataToJSON:(MBGItemData *)itemData {
    LOG_METHOD;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [ArgsParser nilCheck:itemData.id], @"id",
                         [ArgsParser nilCheck:itemData.name], @"name",
                         [NSNumber numberWithInt:itemData.price], @"price",
                         [ArgsParser nilCheck:itemData.description], @"description",
                         [ArgsParser nilCheck:itemData.imageUrl], @"imageUrl",
                         @"com.mobage.air.bank.ItemData", @".class", nil];

    return dic;
}

+ (NSDictionary *)resultToJSON:(MBGResult *)result {
    LOG_METHOD;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [NSNumber numberWithInteger:result.start], @"start",
                         [NSNumber numberWithInteger:result.count], @"count",
                         [NSNumber numberWithInteger:result.total], @"total",
                         @"com.mobage.air.social.PagingResult", @".class", nil];

    return dic;
}

+ (NSDictionary *)leaderboardToJSON:(MBGLeaderboardResponse *)leaderboad {
    LOG_METHOD;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [ArgsParser nilCheck:leaderboad.respId], @"id",
                         [ArgsParser nilCheck:leaderboad.appId], @"appId",
                         [ArgsParser nilCheck:leaderboad.title], @"title",
                         [ArgsParser nilCheck:leaderboad.scoreFormat], @"scoreFormat",
                         [NSNumber numberWithInt:leaderboad.scorePrecision], @"scorePrecision",
                         [ArgsParser nilCheck:leaderboad.iconUrl], @"iconUrl",
                         [NSNumber numberWithBool:leaderboad.allowLowerScore], @"allowLowerScore",
                         [NSNumber numberWithBool:leaderboad.reverse], @"reverse",
                         [NSNumber numberWithBool:leaderboad.archived], @"archived",
                         [NSNumber numberWithDouble:leaderboad.defaultScore], @"defaultScore",
                         [ArgsParser nilCheck:leaderboad.published], @"published",
                         [ArgsParser nilCheck:leaderboad.updated], @"updated",
                         @"com.mobage.air.social.common.LeaderboardData", @".class", nil];

    return dic;
}

+ (NSArray *)leaderboardsToJSON:(NSArray *)leaderboards {
    LOG_METHOD;
    
    NSMutableArray *ary = [NSMutableArray array];
    for (NSInteger index = 0; index < leaderboards.count; index++) {
        [ary addObject:[ArgsParser leaderboardToJSON:[leaderboards objectAtIndex:index]]];
    }
    return [NSArray arrayWithArray:ary];
}

+ (NSDictionary *)topScoreToJSON:(MBGLeaderboardTopScore *)topSocre {
    LOG_METHOD;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [ArgsParser nilCheck:topSocre.displayValue], @"displayValue",
                         [ArgsParser nilCheck:topSocre.userId], @"userId",
                         [NSNumber numberWithInteger:topSocre.rank], @"rank",
                         [NSNumber numberWithDouble:topSocre.value], @"value",
                         @"com.mobage.air.social.common.LeaderboardTopScore", @".class", nil];

    return dic;
}

+ (NSArray *)topScoresToJSON:(NSArray *)topSocres {
    LOG_METHOD;
    
    NSMutableArray *ary = [NSMutableArray array];
    for (NSInteger index = 0; index < topSocres.count; index++) {
        [ary addObject:[ArgsParser topScoreToJSON:[topSocres objectAtIndex:index]]];
    }
    return [NSArray arrayWithArray:ary];
}

+ (NSDictionary *)userToJSON:(MBGUser *)user {
    LOG_METHOD;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [ArgsParser nilCheck:user.id], @"id",
                         [ArgsParser nilCheck:user.displayName], @"displayName",
                         [ArgsParser nilCheck:user.nickname], @"nickname",
                         [ArgsParser nilCheck:user.aboutMe], @"aboutMe",
                         [NSNumber numberWithBool:user.hasApp], @"hasApp",
                         [NSNumber numberWithInteger:user.age], @"age",
                         [ArgsParser nilCheck:user.birthday], @"birthday",
                         [ArgsParser nilCheck:user.gender], @"gender",
                         [NSNumber numberWithInteger:user.grade], @"grade",
                         [ArgsParser nilCheck:user.thumbnailUrl], @"thumbnailUrl",
                         [ArgsParser nilCheck:user.jobType], @"jobType",
                         [ArgsParser nilCheck:user.bloodType], @"bloodType",
                         [NSNumber numberWithBool:user.isVerified], @"isVerified",
                         [NSNumber numberWithBool:user.isFamous], @"isFamous",
                         @"com.mobage.air.social.User", @".class", nil];

    return dic;
}

+ (NSArray *)usersToJSON:(NSArray *)users {
    LOG_METHOD;
    
    NSMutableArray *ary = [NSMutableArray array];
    for (NSInteger index = 0; index < users.count; index++) {
        [ary addObject:[ArgsParser userToJSON:[users objectAtIndex:index]]];
    }
    return [NSArray arrayWithArray:ary];
}

+ (NSDictionary *)responseToJSON:(MBGRemoteNotificationResponse *)response {
    LOG_METHOD;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [ArgsParser nilCheck:response.respId], @"respId",
                         [ArgsParser payloadToJSON:response.payload], @"payload",
                         [ArgsParser nilCheck:response.publishedTimestamp], @"publishedTimestamp",
                         @"com.mobage.air.social.common.RemoteNotificationResponse_iOS", @".class", nil];

    return dic;
}

+ (NSDictionary *)payloadToJSON:(MBGRemoteNotificationPayload *)payload {
    LOG_METHOD;
    
    NSMutableArray *extras = [NSMutableArray array];
    NSArray *keys = payload.extras.allKeys;
    NSArray *values = payload.extras.allValues;
    for (NSInteger index = 0; index < payload.extras.count; index++) {
        [extras addObject:[NSArray arrayWithObjects:
                           [keys objectAtIndex:index],
                           [values objectAtIndex:index], nil]];
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [NSNumber numberWithInteger:payload.badge], @"badge",
                         [ArgsParser nilCheck:payload.message], @"message",
                         [ArgsParser nilCheck:payload.sound], @"sound",
                         [ArgsParser nilCheck:extras], @"extras", nil];

    return dic;
}

+ (NSDictionary *)jpTextdataEntryToJSON:(MBGJPTextdataEntry *)textEntry {
    LOG_METHOD;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [ArgsParser nilCheck:textEntry.entryId], @"id",
                         [ArgsParser nilCheck:textEntry.groupName], @"groupName",
                         [ArgsParser nilCheck:textEntry.parentId], @"parentId",
                         [ArgsParser nilCheck:textEntry.writerId], @"writerId",
                         [ArgsParser nilCheck:textEntry.ownerId], @"ownerId",
                         [ArgsParser nilCheck:textEntry.data], @"data",
                         [NSNumber numberWithInteger:textEntry.status], @"status",
                         [ArgsParser nilCheck:textEntry.publish], @"publish",
                         [ArgsParser nilCheck:textEntry.updated], @"updated",
                         @"com.mobage.air.social.jp.TextdataEntry", @".class", nil];

    return dic;
}

+ (NSArray *)jpTextdataEntriesToJSON:(NSArray *)textEntries {
    LOG_METHOD;
    
    NSMutableArray *ary = [NSMutableArray array];
    for (NSInteger index = 0; index < textEntries.count; index++) {
        [ary addObject:[ArgsParser jpTextdataEntryToJSON:[textEntries objectAtIndex:index]]];
    }
    return [NSArray arrayWithArray:ary];
}

// private
+ (NSDictionary *)billingItemToJSON:(MBGBillingItem *)billingItem {
    LOG_METHOD;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [ArgsParser itemDataToJSON:billingItem.item], @"item",
                         [NSNumber numberWithInt:billingItem.quantity], @"quantity", nil];

    return dic;
}

#pragma mark - convert staff
+ (BOOL)objectToBool:(FREObject)boolObject {
    LOG_METHOD;
    uint32_t value;
    FREResult result = FREGetObjectAsBool(boolObject, &value);
    if(result != FRE_OK) {
        [ArgsParser reportResult:result];
    }
    return (BOOL)value;
}

+ (NSInteger)objectToInteger:(FREObject)intObject {
    LOG_METHOD;
    NSInteger value;
    FREResult result = FREGetObjectAsInt32(intObject, &value);
    if(result != FRE_OK) {
        [ArgsParser reportResult:result];
    }
    return value;
}

+ (double)objectToDouble:(FREObject)doubleObject {
    LOG_METHOD;
    double value;
    FREResult result = FREGetObjectAsDouble(doubleObject, &value);
    if(result != FRE_OK) {
        [ArgsParser reportResult:result];
    }
    return value;
}

+ (NSData *)objectToData:(FREObject)freObject {
    LOG_METHOD;
    FREResult result;
    NSData *data = [NSData data];
    
    result = FRENewObject((const uint8_t*)"flash.utils.ByteArray", 0, NULL, freObject, NULL);
    if(result != FRE_OK) {
        [ArgsParser reportResult:result];
    }

    result = FRESetObjectProperty(freObject, (const uint8_t*)"length", data.length, NULL);
    if(result != FRE_OK) {
        [ArgsParser reportResult:result];
    }
    
    FREByteArray actualBytes;
    result = FREAcquireByteArray(freObject, &actualBytes);
    if(result != FRE_OK) {
        [ArgsParser reportResult:result];
    }
    
    memcpy( actualBytes.bytes, data.bytes, data.length);
    result = FREReleaseByteArray(freObject);
    if(result != FRE_OK) {
        [ArgsParser reportResult:result];
    }
    
    return data;
}

+ (NSString *)objectToString:(FREObject)freObject {
    LOG_METHOD;
    uint32_t length;
    FREObject freString;
    FREObject ex;
    FREObject result;
    const uint8_t *c_string;
    result = FRECallObjectMethod(freObject, (uint8_t*)"toString", 0, NULL, &freString, &ex);
    if(result != FRE_OK) {
        [ArgsParser reportResult:result];
        return @"";
    }
    
    result = FREGetObjectAsUTF8(freString, &length, &c_string);
    if(result != FRE_OK) {
        [ArgsParser reportResult:result];
        return @"";
    }
    NSString *string = [NSString stringWithUTF8String:(char*)c_string];
    return string;
}

+ (NSArray *)objectToArray:(FREObject)freArray {
    LOG_METHOD;
    NSMutableArray* array = [NSMutableArray array];
    
    uint32_t len;
    FREResult result = FREGetArrayLength(freArray, &len);
    if(result != FRE_OK) {
        [ArgsParser reportResult:result];
        return array;
    }
    for(uint32_t i = 0; i < len; i++) {
        FREObject value;
        result = FREGetArrayElementAt(freArray, i, &value);
        if(result != FRE_OK) {
            [ArgsParser reportResult:result];
            return array;
        }
        NSString* valueObject = [ArgsParser objectToString:value];
        [array addObject: valueObject];
    }
    return [NSArray arrayWithArray:array];
}

+ (NSDictionary *)objectToDictionary:(FREObject)freAssocArray {
    LOG_METHOD;
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    
    uint32_t len;
    FREResult result = FREGetArrayLength(freAssocArray, &len);
    if(result != FRE_OK) {
        [ArgsParser reportResult:result];
        return dict;
    }
    // freAssocArray = [ [key0, value0], [key1, value1], ... ]
    for(uint32_t i = 0; i < len; i++) {
        FREObject pair, key, value;
        result = FREGetArrayElementAt(freAssocArray, i, &pair);
        if(result != FRE_OK) {
            [ArgsParser reportResult:result];
            return dict;
        }
        result = FREGetArrayElementAt(pair, 0, &key);
        if(result != FRE_OK) {
            [ArgsParser reportResult:result];
            return dict;
        }
        result = FREGetArrayElementAt(pair, 1, &value);
        if(result != FRE_OK) {
            [ArgsParser reportResult:result];
            return dict;
        }
        NSString* keyStr   = [ArgsParser objectToString:key];
        NSString* valueStr = [ArgsParser objectToString:value];
        LOG(@">>> [%@] : [%@]", keyStr, valueStr);
        [dict setObject: valueStr forKey: keyStr];
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

+ (MBGOption *)objectToOption:(FREObject)freObject {
    LOG_METHOD;
    
    MBGOption *option = [MBGOption option];
    NSString *key;
    FREObject valueObject;
    
    key = @"count";
    [ArgsParser getFREObjectProperty:freObject
                                 key:key
                               value:&valueObject];
    option.count = [ArgsParser objectToInteger:valueObject];
    
    key = @"start";
    [ArgsParser getFREObjectProperty:freObject
                                 key:key
                               value:&valueObject];
    option.start = [ArgsParser objectToInteger:valueObject];
    
    return option;
}

+ (MBGBillingItem *)objectToBillingItem:(FREObject)freObject {
    LOG_METHOD;
    
    MBGBillingItem *billingItem = [MBGBillingItem billingItem];
    NSString *key;
    FREObject valueObject;
    
    key = @"item";
    [ArgsParser getFREObjectProperty:freObject
                                 key:key
                               value:&valueObject];
    billingItem.item = [ArgsParser objectToItemData:valueObject];
    
    
    key = @"quantity";
    [ArgsParser getFREObjectProperty:freObject
                                 key:key
                               value:&valueObject];
    billingItem.quantity = [ArgsParser objectToInteger:valueObject];
    
    return billingItem;
}

+ (MBGItemData *)objectToItemData:(FREObject)freObject {
    LOG_METHOD;
    
    MBGItemData *itemData = [MBGItemData item];
    NSString *key;
    FREObject valueObject;
    
    key = @"id";
    [ArgsParser getFREObjectProperty:freObject
                                 key:key
                               value:&valueObject];
    itemData.id = [ArgsParser objectToString:valueObject];
    
    key = @"name";
    [ArgsParser getFREObjectProperty:freObject
                                 key:key
                               value:&valueObject];
    itemData.name = [ArgsParser objectToString:valueObject];
    
    key = @"price";
    [ArgsParser getFREObjectProperty:freObject
                                 key:key
                               value:&valueObject];
    itemData.price = [ArgsParser objectToInteger:valueObject];
    
    
    key = @"description";
    [ArgsParser getFREObjectProperty:freObject
                                 key:key
                               value:&valueObject];
    itemData.name = [ArgsParser objectToString:valueObject];
    
    key = @"imageUrl";
    [ArgsParser getFREObjectProperty:freObject
                                 key:key
                               value:&valueObject];
    itemData.name = [ArgsParser objectToString:valueObject];
    
    return itemData;
}

+ (MBGRemoteNotificationPayload *)objectToPayload:(FREObject)freObject {
    LOG_METHOD;
    
    MBGRemoteNotificationPayload *payload = [MBGRemoteNotificationPayload payload];
    NSString *key;
    FREObject valueObject;
    
    key = @"badge";
    [ArgsParser getFREObjectProperty:freObject
                                 key:key
                               value:&valueObject];
    payload.badge = [ArgsParser objectToInteger:valueObject];
    
    key = @"message";
    [ArgsParser getFREObjectProperty:freObject
                                 key:key
                               value:&valueObject];
    payload.message = [ArgsParser objectToString:valueObject];
    
    key = @"sound";
    [ArgsParser getFREObjectProperty:freObject
                                 key:key
                               value:&valueObject];
    payload.sound = [ArgsParser objectToString:valueObject];
    
    key = @"extras";
    [ArgsParser getFREObjectProperty:freObject
                                 key:key
                               value:&valueObject];
    payload.extras = [ArgsParser objectToDictionary:valueObject];
    
    return payload;
}

+ (MBGJPTextdataEntry *)objectToJPTextdataEntry:(FREObject)freObject {
    LOG_METHOD;
    MBGJPTextdataEntry *entry = [MBGJPTextdataEntry entry];
    NSString *key;
    FREObject valueObject;
    
    key = @"id";
    [ArgsParser getFREObjectProperty:freObject
                                 key:key
                               value:&valueObject];
    entry.entryId = [ArgsParser objectToString:valueObject];
    
    
    key = @"groupName";
    [ArgsParser getFREObjectProperty:freObject
                                 key:key
                               value:&valueObject];
    entry.groupName = [ArgsParser objectToString:valueObject];
    
    key = @"parentId";
    [ArgsParser getFREObjectProperty:freObject
                                 key:key
                               value:&valueObject];
    entry.parentId = [ArgsParser objectToString:valueObject];
    
    key = @"writerId";
    [ArgsParser getFREObjectProperty:freObject
                                 key:key
                               value:&valueObject];
    entry.writerId = [ArgsParser objectToString:valueObject];
    
    key = @"ownerId";
    [ArgsParser getFREObjectProperty:freObject
                                 key:key
                               value:&valueObject];
    entry.ownerId = [ArgsParser objectToString:valueObject];
    
    key = @"data";
    [ArgsParser getFREObjectProperty:freObject
                                 key:key
                               value:&valueObject];
    entry.data = [ArgsParser objectToString:valueObject];
    
    key = @"status";
    [ArgsParser getFREObjectProperty:freObject
                                 key:key
                               value:&valueObject];
    entry.status = [ArgsParser objectToInteger:valueObject];
    
    key = @"publish";
    [ArgsParser getFREObjectProperty:freObject
                                 key:key
                               value:&valueObject];
    entry.publish = [ArgsParser objectToString:valueObject];
    
    key = @"updated";
    [ArgsParser getFREObjectProperty:freObject
                                 key:key
                               value:&valueObject];
    entry.updated = [ArgsParser objectToString:valueObject];
    
    return entry;
}

#ifdef KR
+ (MBGKRTextdataEntry *)objectToKRTextdataEntry:(FREObject)freObject {
    LOG_METHOD;
    MBGKRTextdataEntry *entry = (MBGKRTextdataEntry *)[ArgsParser objectToJPTextdataEntry:freObject];
    
    return entry;
}
#endif

#pragma mark - convert helper
+ (FREResult)getFREObjectProperty:(FREObject)freObject
                              key:(NSString *)key
                            value:(FREObject *)value {
    
    LOG_METHOD;
    FREObjectType type;
    FREGetObjectType(freObject, &type);
    LOG(@"FREObjectType [%d]", type);
    
    FREResult result = FREGetObjectProperty(freObject,
                                            (const uint8_t *)[key UTF8String],
                                            value,
                                            NULL);
    if(result != FRE_OK) {
        [ArgsParser reportResult:result];
    }
    return result;
}

+ (id)nilCheck:(id)obj {
    if (!obj) {
        return [NSNull null];
    }
    return obj;
}


@end