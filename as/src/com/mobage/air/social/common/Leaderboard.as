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
     * 
     * Leaderboard Information about the requested object.
     * 
     */
    public final class Leaderboard {
        /**
         * Delete the current user's score from the specified leaderboard.
         *  
         * @param leaderboardId
         * @param onDeleteCurrentUserSuccess	function() :void
         * @param onError	function( error :ErrorCode ) :void
         * 
         */		
        public static function deleteCurrentUserScore(leaderboardId :String, onDeleteCurrentUserSuccess :Function,
                                                      onError :Function) :void{
            const funcId :String = 'com.mobage.air.extension.social.common.Leaderboard.deleteCurrentUserScore';
            const sId    :String = Mobage.once(funcId, onDeleteCurrentUserSuccess);
            const eId    :String = Mobage.once(funcId, onError);
            Extension.call(funcId, leaderboardId, sId, eId);
        }
        /**
         * Get all leaderboard objects for the current user.
         * 
         * @param fields	Array of String
         * @param onGetAllLeaderboardsSuccess	function( leaderboards :Array of LeaderboardData, result :PagingResult ) :void
         * @param onError	function( error :ErrorCode ) :void
         * 
         */		
        public static function getAllLeaderboards(fields :Array, onGetAllLeaderboardsSuccess :Function,
                                                  onError :Function) :void{
            const funcId :String = 'com.mobage.air.extension.social.common.Leaderboard.getAllLeaderboards';
            const sId    :String = Mobage.once(funcId, onGetAllLeaderboardsSuccess);
            const eId    :String = Mobage.once(funcId, onError);
            Extension.call(funcId, fields, sId, eId);
            
        }
        /**
         * Get top score ranking on specified user's friends and leaderboard.
         *  
         * @param leaderboardId
         * @param fields	Array of String
         * @param options
         * @param onGetFriendsScoresSuccess	function( topScores :Array of LeaderboardTopScore, result :PagingResult ) :void
         * @param onError	function( error :ErrorCode ) :void
         * 
         */		
        public static function getFriendsScoresList(leaderboardId :String, fields :Array, options :PagingOption, 
                                                    onGetFriendsScoresSuccess :Function, onError :Function) :void {
            const funcId :String = 'com.mobage.air.extension.social.common.Leaderboard.getFriendsScoresList';
            const sId    :String = Mobage.once(funcId, onGetFriendsScoresSuccess);
            const eId    :String = Mobage.once(funcId, onError);
            Extension.call(funcId, leaderboardId, fields, options, sId, eId);
        }
        /**
         * Get specified leaderboard object.
         *  
         * @param leaderboardId
         * @param fields
         * @param onGetLeaderboardSuccess	function(leaderboard :LeaderboardData) :void
         * @param onError	function( error :ErrorCode ) :void
         * 
         */		
        public static function getLeaderboard(leaderboardId :String, fields :Array, 
                                              onGetLeaderboardSuccess :Function, onError :Function) :void {
            const funcId :String = 'com.mobage.air.extension.social.common.Leaderboard.getLeaderboard';
            const sId    :String = Mobage.once(funcId, onGetLeaderboardSuccess);
            const eId    :String = Mobage.once(funcId, onError);
            Extension.call(funcId, leaderboardId, fields, sId, eId);
        }
        /**
         * Get all leaderboard objects for the current user.
         *  
         * @param leaderboardIds	Array of String
         * @param fields	Array of String
         * @param onGetLeaderboardsSuccess	function( leaderboards :Array of LeaderboardData, result :PagingResult ) :void
         * @param onError	function( error :ErrorCode ) :void
         * 
         */		
        public static function getLeaderboards(leaderboardIds :Array, fields :Array, 
                                               onGetLeaderboardsSuccess :Function, onError :Function) :void {
            const funcId :String = 'com.mobage.air.extension.social.common.Leaderboard.getLeaderboards';
            const sId    :String = Mobage.once(funcId, onGetLeaderboardsSuccess);
            const eId    :String = Mobage.once(funcId, onError);
            Extension.call(funcId, leaderboardIds, fields, sId, eId);
        }
        /**
         * Get top score ranking on specified user's friends and leaderboard.
         *  
         * @param leaderboardId
         * @param userId
         * @param fields	Array of String
         * @param onGetScoreSuccess	function(topScore :LeaderboardTopScore) :void
         * @param onError
         * 
         */		
        public static function getScore(leaderboardId :String, userId :String, fields :Array, 
                                        onGetScoreSuccess :Function, onError :Function) :void {	
            const funcId :String = 'com.mobage.air.extension.social.common.Leaderboard.getScore';
            const sId    :String = Mobage.once(funcId, onGetScoreSuccess);
            const eId    :String = Mobage.once(funcId, onError);
            Extension.call(funcId, leaderboardId, userId, fields, sId, eId);
        }
        /**
         * Get top score ranking on specified leaderboard.
         *  
         * @param leaderboardId
         * @param fields	Array of String
         * @param options
         * @param onGetTopScoresSuccess	function( topScores :Array of LeaderboardTopScore, result :PagingResult ) :void
         * @param onError
         * 
         */		
        public static function getTopScoresList(leaderboardId :String, fields :Array, options :PagingOption, 
                                                onGetTopScoresSuccess :Function, onError :Function) :void {
            const funcId :String = 'com.mobage.air.extension.social.common.Leaderboard.getTopScoresList';
            const sId    :String = Mobage.once(funcId, onGetTopScoresSuccess);
            const eId    :String = Mobage.once(funcId, onError);
            Extension.call(funcId, leaderboardId, fields, options, sId, eId);
        }
        /**
         * Update the current user's score in the specified leaderboard.
         * 
         * @param leaderboardId
         * @param value
         * @param onUpdateUserScoreSuccess function(topScore :LeaderboardTopScore) :void
         * @param onError
         * 
         */		
        public static function updateCurrentUserScore(leaderboardId :String, value :Number, 
                                                      onUpdateUserScoreSuccess :Function, onError :Function) :void {
            const funcId :String = 'com.mobage.air.extension.social.common.Leaderboard.updateCurrentUserScore';
            const sId    :String = Mobage.once(funcId, onUpdateUserScoreSuccess);
            const eId    :String = Mobage.once(funcId, onError);
            Extension.call(funcId, leaderboardId, value, sId, eId);
        }
    }
}
