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
    
    /**
     * 
     * The social API for remote notifications.
     * 
     */
    public final class RemoteNotification {	
        /**
         *  Returns true if the current logged in user can receive remote notifications for the current running application.
         * 
         * @param onGetRemoteEnabledSuccess	function(enabled :Boolean) :void
         * @param onError	function( error :ErrorCode ) :void
         * 
         */		
        public static function getRemoteNotificationsEnabled(onGetRemoteEnabledSuccess :Function,
                                                             onError :Function) :void {
            const funcId :String = 'com.mobage.air.extension.social.common.RemoteNotification.getRemoteNotificationsEnabled';
            const sId    :String = Mobage.once(funcId, onGetRemoteEnabledSuccess);
            const eId    :String = Mobage.once(funcId, onError);
            Extension.call(funcId, sId, eId);
            
        }
        /**
         * Boolean set value for whether or not the current logged in user may receive remote notifications for the current running application.
         *  
         * @param enabled
         * @param onSetRemoteNotificationsSuccess	function() :void
         * @param onError	function( error :ErrorCode ) :void
         * 
         */		
        public static function setRemoteNotificationsEnabled(enabled :Boolean,
                                                             onSetRemoteNotificationsSuccess :Function,
                                                             onError :Function) :void {
            const funcId :String = 'com.mobage.air.extension.social.common.RemoteNotification.setRemoteNotificationsEnabled';
            const sId    :String = Mobage.once(funcId, onSetRemoteNotificationsSuccess);
            const eId    :String = Mobage.once(funcId, onError);
            Extension.call(funcId, enabled, sId, eId);
        }
        /**
         * Send a remote notification to the specified user from the current logged in user.(for Android)
         * 
         * @param recipientId
         * @param payload
         * @param onSendSuccess	function(remoteResponse :RemoteNotificationResponse) :void
         * @param onError	function( error :ErrorCode ) :void
         * 
         */		
        public static function send(recipientId :String,
                                    payload : RemoteNotificationPayload,
                                    onSendSuccess :Function,
                                    onError :Function) :void {
            const funcId :String = 'com.mobage.air.extension.social.common.RemoteNotification.send';
            const sId    :String = Mobage.once(funcId, onSendSuccess);
            const eId    :String = Mobage.once(funcId, onError);
            Extension.call(funcId, recipientId, payload, sId, eId);
        }
        
        /**
         * Send a remote notification to the specified user from the current logged in user.(for iOS)
         * 
         * @param recipientId
         * @param payload
         * @param onSendSuccess
         * @param onError
         * 
         */		
        public static function send_iOS(recipientId :String,
                                        payload : RemoteNotificationPayload_iOS,
                                        onSendSuccess :Function,
                                        onError :Function) :void {
            const funcId :String = 'com.mobage.air.extension.social.common.RemoteNotification.send.iOS';
            const sId    :String = Mobage.once(funcId, onSendSuccess);
            const eId    :String = Mobage.once(funcId, onError);
            Extension.call(funcId, recipientId, payload, sId, eId);
        }
        /**
         * Set a remote notification listener. 
         * Call this method when you start your Application.
         * You will recieve callback on com.mobage.air.PlatformListner.handleReceive(payload :RemoteNotificationPayload) .
         */		
        public static function setListener() :void {
            const funcId :String = 'com.mobage.air.extension.social.common.RemoteNotification.setListener';
            Extension.call(funcId);
        }
		
		
		public static function onNewIntent() :void {
			const funcId :String = 'com.mobage.air.extension.social.common.RemoteNotification.onNewIntent';
			Extension.call(funcId);
		}
    }
}
