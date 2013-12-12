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
    import com.mobage.air.util.Struct;
    /**
     * 
     * Data structure for LeaderboardResponse and Fields for Leaderboard.Field
     * 
     */	
    public final class LeaderboardData extends Struct {
        public static const ALLOW_LOWER_SCORE :String   = "ALLOW_LOWER_SCORE";
        public static const APP_ID :String              = "APP_ID";
        public static const ARCHIVED :String            = "ARCHIVED";
        public static const DEFAULT_SCORE :String       = "DEFAULT_SCORE";
        public static const FORMAT :String              = "FORMAT";
        public static const ICON_URL :String            = "ICON_URL";
        public static const ID :String                  = "ID";
        public static const PRECISION :String           = "PRECISION";
        public static const PUBLISHED :String           = "PUBLISHED";
        public static const RANK :String                = "RANK";
        public static const REVERSE	:String             = "REVERSE";
        public static const TITLE :String               = "TITLE";
        public static const UPDATED	:String             = "UPDATED";
        public static const USER_ID	:String             = "USER_ID";
        public static const VALUE :String               = "VALUE";
        public static const DISPLAY_VALUE :String       = "DISPLAY_VALUE";
        
        public var allowLowerScore :Boolean;
        public var appId :String;
        public var archived	:Boolean;
        public var defaultScore	:Number;
        public var iconUrl :String;
        public var id :String;
        public var published :String;
        public var reverse :Boolean;
        public var scoreFormat :String;
        public var scorePrecision :int;
        public var title :String;
        public var updated :String;
        
        public function LeaderboardData(map :Object) {
            super(map);
        }
    }
}
