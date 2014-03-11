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
package com.mobage.air
{
    import com.mobage.air.util.CallbackEvent;
    
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.StatusEvent;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    import flash.utils.Dictionary;
    
    // interface to com.mobage.android.Mobage (in Java)
    //           or MBGPlatform (in Objective-C)
    /**
     * Main class for controlling the Mobage SDK, including login control,
     * splash screen control and asynchronous operation control.
     */
    public final class Mobage extends EventDispatcher {
        /** @private */
        public static const config :Object = loadConfig();
        
        /** @private */
        public static const DEBUG :Boolean = config.debug;
        
        // event tags for addEventListener()
        // invoked by dispatchEvent(tag, eventObject)
        /** @private */
        public static const LOGIN_CANCEL                :String = "PlatformListener.onLoginCancel";
        /** @private */
        public static const LOGIN_COMPLETE              :String = "PlatformListener.onLoginComplete";
        /** @private */
        public static const LOGIN_ERROR                 :String = "PlatformListener.onLoginError";
        /** @private */
        public static const LOGIN_REQUIRED              :String = "PlatformListener.onLoginRequired";
        /** @private */
        public static const SPLASH_COMPLETE             :String = "PlatformListener.onSplashComplete";
        /** @private */
        public static const NOTIFICATION_RECIEVED       :String = "PlatformListener.handleReceive";
        /** @private */
        public static const NOTIFICATION_RECIEVED_IOS   :String = "PlatformListener.handleReceive_iOS";
		/** @private */
		public static const ISDASHBOARD_LAUNCHED		:String = "PlatformListener.DashboardLanched";
		/** @private */
		public static const ISDASHBOARD_DISMISS			:String = "PlatformListener.DashboardDismiss";
        
        // the instance
        private static var $instance :Mobage;
        
        // properties
        private var _region         :Region;
        private var _serverMode     :ServerMode;
        private var _consumerKey    :String;
        private var _consumerSecret :String;
        private var _appId          :String;
        private var _appInstance    :EventDispatcher;
		
        // load configuration
        // config.debug - enable DEBUG mode
        private static function loadConfig() :Object {
            var file :File = File.applicationDirectory.resolvePath('mobage.json');
            if(file.exists) {
                var ins :FileStream = new FileStream();
                ins.open(file, FileMode.READ);
                var content :String = ins.readMultiByte(file.size, File.systemCharset);
                ins.close();
                if(content) {
                    return JSON.parse(content);
                }
            }
            return {
                debug: false
            };
        }
        
        /**
         * Initializes the Mobage SDK.
         *
         * @param region the region of the application (JP, US, CN, KR)
         * @param servermode ServerMode the server mode of the application (SANDBOX, PRODUCTION)
         * @param consumerKey the consumer key of the application
         * @param consumerSecret the consumer secret of the application
         * @param appId application ID
         * @param appInstance the main application instance
         */
        public static function initialize(
            region :Region,
            serverMode :ServerMode,
            consumerKey :String,
            consumerSecret :String,
            appId :String,
            appInstance :EventDispatcher
        ) :void {
            $instance = new Mobage(region, serverMode, consumerKey, consumerSecret, appId, appInstance);
            
            $instance.addEventListener("fatal", function(e: CallbackEvent) :void {
                throw new Error(e.args[0]);
            });
            
            Extension.initialize();
            
            // listen to events from MobageAirSDK (native class)
            Extension.addEventListener(StatusEvent.STATUS, function(e :StatusEvent) :void {
                // e.code  == the name of the event handler
                // e.level == the argument of the event handler
                if(DEBUG) {
                    trace('DEBUG: CallbackEvent invoked:', e.code, 'with', e.level);
                }
                var event :CallbackEvent = new CallbackEvent(e.code, e.bubbles, e.cancelable, e.level /* args */);
                $instance.dispatchEvent(event);
            });
            
            Extension.call('com.mobage.air.extension.Mobage.initialize', region, serverMode, consumerKey, consumerSecret, appId, appInstance);
            
            $instance._appInstance.addEventListener(Event.DEACTIVATE, Mobage.onPause);
            $instance._appInstance.addEventListener(Event.ACTIVATE,   Mobage.onResume);
        }
        
        /** @private called in Mobage.initialize() */
        public function Mobage(region :Region,
                               serverMode :ServerMode,
                               consumerKey :String,
                               consumerSecret :String,
                               appId :String,
                               appInstance :EventDispatcher) {
            _region         = region;
            _serverMode     = serverMode;
            _consumerKey    = consumerKey;
            _consumerSecret = consumerSecret;
            _appId          = appId;
            _appInstance    = appInstance;
        }
        
        /**
         * Return Mobage supports current platform or not.
         * With iOS or Android, it returns true.
         * With ADL, it returns false.
         */
        public static function isSupported():Boolean {
            DEFINE::IOS
            {
                return true;
            }
            
            DEFINE::ANDROID
            {
                return true;
            }
            
            DEFINE::DEFAULT
            {
                return false;
            }
            
            return false;
        }
        
		/**
		 * Registers tick method with timer (Only for KR and iOS)
		 */
		public static function registerTick() :void {
            Extension.call('com.mobage.air.extension.Mobage.registerTick');
		}
		
        /**
         * Returns version of SDK.
         * Only available after <code>Mobage.initialize()</code>.
         */
        public static function getSdkVersion() :String {
            return Extension.call('com.mobage.air.extension.Mobage.getSdkVersion');
        }
        
        static private var $eventHandlerId :uint = 0;
        
        /** @private */
        public static function once(type :String, handler :Function) :String {
            var myId :String = type + (++$eventHandlerId); // make it unique
            
            $instance.addEventListener(myId, function(e :CallbackEvent) :void {
                handler.apply(this, e.args);
                $instance.removeEventListener(myId, arguments.callee);
            });
            return myId;
        }
        
        private static var $listeners :Dictionary = new Dictionary();
        /**
         * Adds a PlatformListner
         */
        public static function addPlatformListener(listener :PlatformListener) :void {
            var onLoginRequired :Function = function(e :CallbackEvent) :void {
                listener.onLoginRequired.apply(listener, e.args);
            };
            var onLoginCancel :Function = function(e :CallbackEvent) :void {
                listener.onLoginCancel.apply(listener, e.args);
            };
            var onLoginComplete :Function = function(e :CallbackEvent) :void {
                listener.onLoginComplete.apply(listener, e.args);
            };
            var onSplashComplete :Function = function(e :CallbackEvent) :void {
                listener.onSplashComplete.apply(listener, e.args);
            };
            var onLoginError :Function = function(e :CallbackEvent) :void {
                listener.onLoginError.apply(listener, e.args);
            };
            var handleReceive :Function = function(e :CallbackEvent) :void {
                listener.handleReceive.apply(listener, e.args);
            };
            var handleReceive_iOS :Function = function(e :CallbackEvent) :void {
                listener.handleReceive_iOS.apply(listener, e.args);
            };
			var DashboardLanched :Function = function(e :CallbackEvent) :void {
				listener.DashboardLanched.apply(listener, e.args);
			};
			var DashboardDismiss :Function = function(e :CallbackEvent) :void {
				listener.DashboardDismiss.apply(listener, e.args);
			};
            
            var o :Object = $listeners[listener] = {
                onLoginRequired:  onLoginRequired,
                onLoginCancel:    onLoginCancel,
                onLoginComplete:  onLoginComplete,
                onLoginError:     onLoginError,
                onSplashComplete: onSplashComplete,
				handleReceive_iOS:handleReceive_iOS};
            
            $instance.addEventListener(Mobage.LOGIN_REQUIRED,  onLoginRequired);
            $instance.addEventListener(Mobage.LOGIN_CANCEL,    onLoginCancel);
            $instance.addEventListener(Mobage.LOGIN_COMPLETE,  onLoginComplete);
            $instance.addEventListener(Mobage.LOGIN_ERROR,     onLoginError);
            $instance.addEventListener(Mobage.SPLASH_COMPLETE, onSplashComplete);
            $instance.addEventListener(Mobage.NOTIFICATION_RECIEVED, handleReceive);
            $instance.addEventListener(Mobage.NOTIFICATION_RECIEVED_IOS, handleReceive_iOS);
			$instance.addEventListener(Mobage.ISDASHBOARD_LAUNCHED, DashboardLanched);
			$instance.addEventListener(Mobage.ISDASHBOARD_DISMISS, DashboardDismiss);
            
            Extension.call('com.mobage.air.extension.Mobage.addPlatformListener', o);
        }
                
        /**
         * Checks login status
         */
        public static function checkLoginStatus() :void {
            Extension.call('com.mobage.air.extension.Mobage.checkLoginStatus');
        }
        
        public static function onPause(e :Event) :void {
            trace("onPause Called");
            Extension.call('com.mobage.air.extension.Mobage.onPause');
        }
        public static function onResume(e :Event) :void {
            trace("onResume Called");
            Extension.call('com.mobage.air.extension.Mobage.onResume');
        }
        
        // registeResources() is android specific
        
        /**
         * Shows login dialog
         * @param cancelable	Default value is false
         * 
         */
        public static function showLoginDialog() :void {			
            Extension.call('com.mobage.air.extension.Mobage.showLoginDialog');
        }
        
        /**
         * Asks users to logout from Mobage's service
         */
        public static function showLogoutDialog(onLogoutSuccess :Function, onLogoutCancel :Function) :void {
            const funcId :String = 'com.mobage.air.extension.Mobage.showLogoutDialog';
            const sId :String = Mobage.once(funcId, onLogoutSuccess);
            const cId :String = Mobage.once(funcId, onLogoutCancel);
            Extension.call(funcId, sId, cId);
        }
        
        /**
         * Hides Mobage's splash screen
         */
        public static function hideSplashScreen() :void {
            Extension.call('com.mobage.air.extension.Mobage.hideSplashScreen');
        }
        
        
        /**
         * Opens the dialog to upgrade current user's grade
         *  
         * @param grade :String value of TargetUserGrade
         * @param onDismiss	function() :void
         * 
         */		
        public static function openUpgradeDialog(grade :TargetUserGrade, onDismiss :Function) :void {
            const funcId :String = 'com.mobage.air.extension.Mobage.openUpgradeDialog';
            const dId    :String = Mobage.once(funcId, onDismiss);
            Extension.call(funcId, grade, dId);
            
        }
		
		/**
		 * Adds Dashboard Observer for notification (Only for JP)
		 * 
		 */		
		public static function addDashboardObserver() :void
		{
			const funcId :String = 'com.mobage.air.extension.Mobage.addDashboardObserver';
			Extension.call(funcId);
		}
		
		/**
		 * Removes Dashboard Observer from notification (Only for JP)
		 * 
		 */		
		public static function removeDashboardObserver() :void
		{
			const funcId :String = 'com.mobage.air.extension.Mobage.removeDashboardObserver';
			Extension.call(funcId);
		}
		
        /**
         * show Nickname Registration Dialog for 1CR User (Only for JP)
         * 
         */		
        public static function showNicknameRegistrationDialog(defaultNickname :String, onSuccess :Function) :void
        {
            const funcId :String = 'com.mobage.air.extension.Mobage.showNicknameRegistrationDialog';
            const dId    :String = Mobage.once(funcId, onSuccess);
            Extension.call(funcId, defaultNickname, dId);
        }
    }
}
