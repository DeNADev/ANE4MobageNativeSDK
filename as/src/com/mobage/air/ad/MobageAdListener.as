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
package com.mobage.air.ad
{
	import com.mobage.air.Extension;
	import com.mobage.air.util.CallbackEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	
	public final class MobageAdListener extends EventDispatcher
	{
		private static const $instance :MobageAdListener = new MobageAdListener();
		
		public static const ONDISMISSSCREEN			:String = "AdListener.onDismissScreen";
		public static const ONFAILEDTORECEIVEAD			:String = "AdListener.onFailedToReceiveAd";
		public static const ONLEAVEAPPLICATION			:String = "AdListener.onLeaveApplication";
		public static const ONPRESENTSCREEEN			:String = "AdListener.onPresentScreen";
		public static const ONRECIEVEAD			:String = "AdListener.onReceiveAd";
		
		public function MobageAdListener() {
			Extension.addEventListener(StatusEvent.STATUS, function(e :StatusEvent) :void {
				var event :CallbackEvent = new CallbackEvent(e.code, e.bubbles, e.cancelable, e.level /* args */);
				$instance.dispatchEvent(event);
			});
		}
		
		
		public static function setListner(listener :AdListener) :void{
			
			var onDismissScreen :Function = function(e :CallbackEvent) :void {
				listener.onDismissScreen.apply(listener, e.args);
			};
			var onFailedToReceiveAd :Function = function(e :CallbackEvent) :void {
				listener.onFailedToReceiveAd.apply(listener, e.args);
			};
			var onLeaveApplication :Function = function(e :CallbackEvent) :void {
				listener.onLeaveApplication.apply(listener, e.args);
			};
			var onPresentScreen :Function = function(e :CallbackEvent) :void {
				listener.onPresentScreen.apply(listener, e.args);
			};
			var onReceiveAd :Function = function(e :CallbackEvent) :void {
				listener.onReceiveAd.apply(listener, e.args);
			};
			
			$instance.addEventListener(MobageAdListener.ONDISMISSSCREEN,  onDismissScreen);
			$instance.addEventListener(MobageAdListener.ONFAILEDTORECEIVEAD,  onFailedToReceiveAd);
			$instance.addEventListener(MobageAdListener.ONLEAVEAPPLICATION,  onLeaveApplication);
			$instance.addEventListener(MobageAdListener.ONPRESENTSCREEEN,  onPresentScreen);
			$instance.addEventListener(MobageAdListener.ONRECIEVEAD,  onReceiveAd);
		}
	}
}
