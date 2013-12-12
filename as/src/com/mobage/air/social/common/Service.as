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
	 * This interface provides the following social game services: 
	 * – Balance Button
	 * – Friend Picker
	 * – User Finder
	 * – User Profile
	 * 
	 */
	public class Service {
		
		/**
		 * Retrieve the Balance Button, which displays the user's current balance of MobaCoin and opens the Bank when tapped.
		 * The BalanceButton will be added to the root view.
		 *  Deprecated. Since Version 1.4.4, this API is intentionally deprecated. New code should instead use getBalanceButton
		 * (int width, int height) to get a BalanceButton instance. Retrieve the Balance Button, which displays the user's current 
		 * balance of MobaCoin and opens the Bank when tapped.
		 * 
		 * @param x
		 * @param y
		 * @param width
		 * @param height
		 * @deprecated
		 * 
		 */
		[Deprecated]
		public static function getBalanceButton(x :Number, y :Number, width :Number, height :Number) :void {
			const funcId :String = 'com.mobage.air.extension.social.common.Service.getBalanceButton';
			Extension.call(funcId, x, y, width, height);
		}
		/**
		 * Will remove the BalanceButton from root view.
		 * 
		 * @deprecated
		 */
		[Deprecated]
		public static function removeBalanceButton() :void {
			const funcId :String = 'com.mobage.air.extension.social.common.Service.removeBalanceButton';
			Extension.call(funcId);
		}

        /**
         * Update BalanceButton value.
         * 
		 * @deprecated
         */
		[Deprecated]
        public static function updateBalanceButton() :void {
            const funcId :String = 'com.mobage.air.extension.social.common.Service.updateBalanceButton';
            Extension.call(funcId);
        }
        
		/**
		 * Opens the friend picker.
		 *  
		 * @param maxFriendsToSelect
		 * @param onDismiss		function() :void
		 * @param onInviteSent	function(userIds :Array) :void
		 * @param onPicked		function(userIds :Array) :void
		 * 
		 */		
		public static function openFriendPicker(maxFriendsToSelect :int,
												onDismiss :Function,
												onInviteSent :Function,
												onPicked :Function) :void {
			const funcId :String = 'com.mobage.air.extension.social.common.Service.openFriendPicker';
			const dId :String = Mobage.once(funcId, onDismiss);
			const iId :String = Mobage.once(funcId, onInviteSent);
			const pId :String = Mobage.once(funcId, onPicked);
			Extension.call(funcId, maxFriendsToSelect, dId, iId, pId);
		}
		/**
		 * Takes a user ID or gamer name and opens the user's profile page. 
		 * 
		 * @param userId
		 * @param onDialogDismiss	function() :void
		 * 
		 */		
		public static function openUserProfile(userId :String, onDialogDismiss :Function) :void {
			const funcId :String = 'com.mobage.air.extension.social.common.Service.openUserProfile';
			const dId :String = Mobage.once(funcId, onDialogDismiss);
			Extension.call(funcId, userId, dId);
		}
		/**
		 * 
		 * @param onDialogDismiss	function() :void
		 * 
		 */		
		public static function showBankUi(onDialogDismiss :Function) :void {
			const funcId :String = 'com.mobage.air.extension.social.common.Service.showBankUi';
			const dId :String = Mobage.once(funcId, onDialogDismiss);
			Extension.call(funcId, dId);
		}
		/**
		 * Display the Mobage user interface.
		 *  
		 * @param onDismiss
		 * 
		 */		
		public static function showCommunityUI(onDismiss :Function) :void {
			const funcId :String = 'com.mobage.air.extension.social.common.Service.showCommunityUI';
			const dId :String = Mobage.once(funcId, onDismiss);
			Extension.call(funcId, dId);
		}
	}
}
