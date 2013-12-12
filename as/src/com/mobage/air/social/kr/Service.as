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
package com.mobage.air.social.kr
{
    import com.mobage.air.Extension;
    import com.mobage.air.Mobage;
    
    public final class Service {
        public static function openDocument(documentType :DocumentType, onDialogDismiss :Function) :void {
            const funcId :String = 'com.mobage.air.extension.social.kr.Service.openDocument';
            var dId :String = Mobage.once(funcId, onDialogDismiss);
            Extension.call(funcId, documentType, dId);
        }
        
        /**
         * Show the Community Button, which opens the Mobage user interface.
         * 
         * @param gravity : Gravity		The corner in which to display the button. Must contain a value that corresponds to a corner of the screen.
         * @param theme : String		Varies color combination of the community button. 
         * 								As of now we support 4 themes. Input basic, blue, gray or dark as string.
         * 
         */		
        public static function showCommunityButton(gravity :Gravity, theme :String) :void {
            const funcId :String = 'com.mobage.air.extension.social.kr.Service.showCommunityButton';
            Extension.call(funcId, gravity, theme);
        }
        
        public static function hideCommunityButton() :void {
            Extension.call('com.mobage.air.extension.social.kr.Service.hideCommunityButton');
        }
        
        public static function shareMessage(message :String, title :String, pictureUrl :String, onDismiss :Function) :void {
            const funcId :String = 'com.mobage.air.extension.social.kr.Service.shareMessage';
            var dId :String = Mobage.once(funcId, onDismiss);
            Extension.call(funcId, message, title, pictureUrl, dId);
        }
        
        public static function openFriendRequestSender(userIds :Array, onDismiss :Function) :void {
            const funcId :String = 'com.mobage.air.extension.social.kr.Service.openFriendRequestSender';
            var dId :String = Mobage.once(funcId, onDismiss);
            Extension.call(funcId, userIds, dId);
        }
    }
}
