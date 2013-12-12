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
package com.mobage.air.social
{
    import com.mobage.air.util.Struct;
    
    /**
     *  Data structure of a user
     */
    public final class User extends Struct {
        // Constants corresponding com.mobage.android.social.User.Field
        public static const ID :String              = "ID";
        public static const DISPLAY_NAME :String    = "DISPLAY_NAME";
        public static const NICKNAME :String        = "NICKNAME";
        public static const ABOUT_ME :String        = "ABOUT_ME";
        public static const AGE :String             = "AGE";
        public static const BIRTHDAY :String        = "BIRTHDAY";
        public static const GENDER :String          = "GENDER";
        public static const HAS_APP :String         = "HAS_APP";
        public static const THUMBNAIL_URL :String   = "THUMBNAIL_URL";
        public static const JOB_TYPE :String        = "JOB_TYPE";
        public static const BLOOD_TYPE :String      = "BLOOD_TYPE";
        public static const IS_VERIFIED :String     = "IS_VERIFIED";
        public static const IS_FAMOUS :String       = "IS_FAMOUS";
        public static const GRADE :String           = "GRADE";
        
        // Currently we have implemented the fields in instance vars,
        // but it can switch to get/set accessors if needed.
        public var id            :String;
        public var displayName   :String;
        public var nickname      :String;
        public var aboutMe       :String;
        public var age           :int;
        public var birthday      :String;
        public var gender        :String;
        public var hasApp        :Boolean;
        public var thumbnailUrl  :String;
        public var jobType       :String;
        public var bloodType     :String;
        public var isVerified    :Boolean;
        public var isFamous		:Boolean;
        public var grade		:int; 
        
        public function User(map :Object) {
            super(map);
        }
    }
}
