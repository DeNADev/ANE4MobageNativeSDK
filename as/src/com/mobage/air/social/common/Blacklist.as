/*
*The MIT License (MIT)
*Copyright (c) 2013 DeNA Co., Ltd.
*
*Permission is hereby granted, free of charge, to any person obtaining a copy
*of this software and associated documentation files (the "Software"), to deal
*in the Software without restriction, including without limitation the rights
*to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
*copies of the Software, and to permit persons to whom the Software is
*furnished to do so, subject to the following conditions:
*
*The above copyright notice and this permission notice shall be included in
*all copies or substantial portions of the Software.
*
*THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
*IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
*FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
*AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
*LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
*OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
*THE SOFTWARE.
*/
package com.mobage.air.social.common
{
    import com.mobage.air.Extension;
    import com.mobage.air.Mobage;
    import com.mobage.air.social.PagingOption;
    
    /**
     * 
     * Provides an interface for checking the user's blacklist.
     * 
     */
    public final class Blacklist {
        /**
         * @param userId The user ID for the user corresponding to the blacklist.
         * @param targetUserId The target user ID to check in the blacklist. 
         * @param Takes a PagingOption structure containing the start index and count for pagination. E.g., {start=1, count=100} Requires start index and count. The minimum start index is 1. If null, undefined or an empty array, the start index is 1 and the count is 50.
         * @param onCheckBlacklistSuccess function(listedUsers :Array of String, result :PagingResult) :void
         * @param onError function(error :ErrorCode) :void
         */
        public static function checkBlacklist( userId :String,
                                               targetUserId :String,
                                               options :PagingOption,
                                               onCheckBlacklistSuccess :Function,
                                               onError :Function) :void {
            const funcId :String = 'com.mobage.air.extension.social.common.Blacklist.checkBlacklist';
            const sId :String = Mobage.once(funcId, onCheckBlacklistSuccess);
            const eId :String = Mobage.once(funcId, onError);
            Extension.call(funcId, userId, targetUserId, options, sId, eId);
        }
    }
}
