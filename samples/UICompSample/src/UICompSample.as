package
{
    import com.mobage.air.ErrorCode;
    import com.mobage.air.Mobage;
    import com.mobage.air.PlatformListener;
    import com.mobage.air.social.common.RemoteNotification;
    import com.mobage.air.social.common.RemoteNotificationPayload;
    import com.mobage.air.social.common.RemoteNotificationPayload_iOS;
    import com.mobage.air.util.AlertDialog;
    
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.InvokeEvent;
    import flash.system.Capabilities;
    import flash.text.TextField;
	import flash.desktop.NativeApplication;
	import flash.desktop.InvokeEventReason; 
    
    import UITest.MainMenu;
    
    import util.define;
    
    [SWF( backgroundColor="0x000000")]
    
    public class UICompSample extends Sprite implements PlatformListener {
        private var _loginCompleted  :Boolean = false;
        private var _splashCompleted :Boolean = false;
        private var _userId :String = null;
        
		// iOS or Android ?
		private var os :String = Capabilities.os;
		private var exp :RegExp = /iPhone OS/;
		private var result :Boolean = exp.test(os);

		
		
        public function UICompSample() {
            super();
            
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, invokeHandler); 
			
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            
            trace("Your device : " + os);
            if (result) {
                Mobage.initialize(
                    define.REGION,
                    define.SERVER_MODE,
                    define.IOS_CONSUMER_KEY,
                    define.IOS_CONSUMER_SECRET,
                    define.APPLICATION_ID,
                    this);
            } else {
                Mobage.initialize(
                    define.REGION,
                    define.SERVER_MODE,
                    define.ANDROID_CONSUMER_KEY,
                    define.ANDROID_CONSUMER_SECRET,
                    define.APPLICATION_ID,
                    this);
            }
            
            // SDK varsion
            trace("MobageSDK version :", Mobage.getSdkVersion());
            
            Mobage.registerTick();
            RemoteNotification.setListener();
            Mobage.addPlatformListener(this);
			Mobage.addDashboardObserver(); //Starts DashBoard Observer *Only for JP region. Remove when using KR.
            Mobage.checkLoginStatus();
        }
        
        public function onLoginError(error :ErrorCode) :void {
            trace("onLoginError:", error.code, error.description );
            
            var message :TextField = new TextField();
            message.scaleX = 2.0;
            message.scaleY = 2.0;
            message.width  = stage.stageWidth;
            message.height = stage.stageHeight;
            message.text   = "Failed to login:\n" + error.description;
            addChild(message);
        }
        
        public function onLoginCancel() :void {
            trace("Login canceled");
            Mobage.showLoginDialog();
        }
        
        public function onLoginRequired() :void {
            trace("Login required");
            Mobage.showLoginDialog();
        }
        
        public function onLoginComplete(userId :String) :void {
            trace("Login completed: " + userId);
            _userId = userId;
            _loginCompleted = true;
            checkOnComplete();				
        }
        
        public function onSplashComplete() :void {
            trace("Splash completed");
            Mobage.hideSplashScreen();
            _splashCompleted = true;
            checkOnComplete();
        }
        
        public function checkOnComplete() :void {
            trace("checkOnComplete");
            if (_loginCompleted && _splashCompleted) {
                trace("showMainMenu");
                var main : MainMenu = new MainMenu (_userId);
                addChild(main);
                main.createMainMenu();
            }
        }
        
        public function handleReceive(payload :RemoteNotificationPayload)  :void {
			trace("Received Notification :" + payload.message);
            AlertDialog.show({
                title: "Received message",
				message: payload.state + " :" + payload.message
            });
        }
        
        public function handleReceive_iOS(payload :RemoteNotificationPayload_iOS)  :void {
            trace("Recieved Notification :" + payload.message);
			
            AlertDialog.show({
                title: "Recieved message",
                message: payload.state + " :" + payload.message
			});
        }
		
		public function DashboardLanched() :void
		{
			trace("Dashboard has launched");
		}
		public function DashboardDismiss() :void
		{
			trace("Dashboard is dissmiss");
		}
		
		public function invokeHandler(event :InvokeEvent) :void
		{
			
			if(_loginCompleted && _splashCompleted){
			
				if(!result){
					// call NewIntent check for Android
					RemoteNotification.onNewIntent(); 
				}
			
			}
		}
    }
}


