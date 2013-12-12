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
     * The social API for returning user objects with their social graphs. 
     * The user object retrieved varies from platform to platform. 
     * US platform required fields are id, nickname, hasApp, grade, isFamous, isVerified and thumbnailUrl of the Person data type.
     *  
     * 
     */
    public final class People {
        /**
         * Retrieves the current user.
         * 
         * @param fields           Array of String of User's fields
         * @param onGetUserSuccess function( user  :User ) :void
         * @param onError          function( error :ErrorCode ) :void
         */
        public static function getCurrentUser( fields           :Array,
                                               onGetUserSuccess :Function,
                                               onError          :Function) :void {
            
            const funcId :String = 'com.mobage.air.extension.social.common.People.getCurrentUser';
            const sId :String = Mobage.once(funcId, onGetUserSuccess);
            const eId :String = Mobage.once(funcId, onError);
            Extension.call(funcId, fields, sId, eId);
        }
        
        /**
         * Retrieves the firends of a given user.
         * 
         * @param userId
         * @param fields            Array of String
         * @param options
         * @param onGetUsersSuccess function( users :Array of User, result :PagingResult ) :void
         * @param onError           function( error :ErrorCode ) :void
         */
        public static function getFriends( userId            :String,
                                           fields            :Array,
                                           options           :PagingOption,
                                           onGetUsersSuccess :Function,
                                           onError    :Function ) :void {
            
            const funcId :String = 'com.mobage.air.extension.social.common.People.getFriends';
            const sId :String = Mobage.once(funcId, onGetUsersSuccess);
            const eId :String = Mobage.once(funcId, onError);
            Extension.call(funcId, userId, fields, options, sId, eId);
        }
        
        /**
         * Retrieves the user's friends playing the current game.
         * 
         * @param userId
         * @param fields            Array of String
         * @param options
         * @param onGetUsersSuccess function( users :Array of User, result :PagingResult ) :void
         * @param onError           function( error :ErrorCode ) :void
         */
        public static function getFriendsWithGame( userId            :String,
                                                   fields            :Array,
                                                   options           :PagingOption,
                                                   onGetUsersSuccess :Function,
                                                   onError           :Function ) :void {
            const funcId :String = 'com.mobage.air.extension.social.common.People.getFriendsWithGame';
            const sId :String = Mobage.once(funcId, onGetUsersSuccess);
            const eId :String = Mobage.once(funcId, onError);
            Extension.call(funcId, userId, fields, options, sId, eId);
        }
        
        /**
         * Retrieves the user with a given user ID.
         * 
         * @param userId
         * @param fields           Array of String
         * @param onGetUserSuccess function( user :User ) :void
         * @param onError          function( error :ErrorCode ) :void
         */
        public static function getUser( userId           :String,
                                        fields           :Array,
                                        onGetUserSuccess :Function,
                                        onError          :Function) :void {
            
            const funcId :String = 'com.mobage.air.extension.social.common.People.getUser';
            const sId :String = Mobage.once(funcId, onGetUserSuccess);
            const eId :String = Mobage.once(funcId, onError);
            Extension.call(funcId, userId, fields, sId, eId);
        }
        /**
         * Retrieves an array of users.
         * 
         * @param userIds           Array of String
         * @param fields            Array of String
         * @param onGetUsersSuccess function( users :Array of User, result :PagingResult ) :void
         * @param onError           function( error :ErrorCode ) :void
         */
        public static function getUsers( userIds           :Array,
                                         fields            :Array,
                                         onGetUsersSuccess :Function,
                                         onError           :Function ) :void {
            const funcId :String = 'com.mobage.air.extension.social.common.People.getUsers';
            const sId :String = Mobage.once(funcId, onGetUsersSuccess);
            const eId :String = Mobage.once(funcId, onError);
            Extension.call(funcId, userIds, fields, sId, eId);
        }
    }
}
