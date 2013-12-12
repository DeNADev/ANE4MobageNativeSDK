package
{
	import com.mobage.air.ErrorCode;
	import com.mobage.air.Mobage;
	import com.mobage.air.PlatformListener;
	import com.mobage.air.Region;
	import com.mobage.air.ServerMode;
	import com.mobage.air.social.User;
	import com.mobage.air.social.common.People;
	import com.mobage.air.social.common.RemoteNotificationPayload;
	import com.mobage.air.social.common.RemoteNotificationPayload_iOS;
	import com.mobage.air.social.common.RemoteNotification;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class HelloMobage extends Sprite implements PlatformListener
	{
		private var _loginCompleted  :Boolean = false;
		private var _splashCompleted :Boolean = false;
		
		public function HelloMobage()
		{
			super();
			
			Mobage.initialize(
				Region.JP,                 // region
				ServerMode.SANDBOX,        // serverMode
				"sdk_app_id:your_app_id",  // consumerKey
				"your_consumer_secret",    // consumerSecret
				"your_app_id",             // appId
				this);
			
			trace("MobageSDK version: " + Mobage.getSdkVersion());
			
            Mobage.registerTick();
			RemoteNotification.setListener();
			Mobage.addPlatformListener(this);
			Mobage.addDashboardObserver(); //Starts DashBoard Observer *Only for JP region. Remove when using KR.
			Mobage.checkLoginStatus();
			
			var t :TextField = new TextField();
			t.x = 100;
			t.y = 100;
			t.scaleX = 3.0;
			t.scaleY = 3.0;
			t.text = "Hello, Mobage!";
			addChild(t);
		}
		
		public function onLoginError(error :ErrorCode) :void {
			trace("onLoginError:", error.code, error.description );
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
			if(_loginCompleted && _splashCompleted) {
				getUserExample();
			}
		}
		
		public function handleReceive(payload :RemoteNotificationPayload)  :void {
			trace("You have recieved a message :" + payload.message);
		}
		
		public function handleReceive_iOS(payload :RemoteNotificationPayload_iOS)  :void {
			trace("You have recieved a message :" + payload.message);
		}
		
		public function DashboardLanched() :void {
			trace("Dashboard has launched");
		}
		public function DashboardDismiss() :void {
			trace("Dashboard is dissmiss");
		}
		
		public function getUserExample() :void {
			var fields :Array = [ User.ID, User.NICKNAME, User.HAS_APP ];
			People.getCurrentUser(fields,
				function(user :User) :void {
					trace("getCurrentUser() succeeded: " + user.nickname);
				},
				function(error :ErrorCode) :void {
					trace("getCurrentUser() failed: " + error);
				});
		}
	}
}