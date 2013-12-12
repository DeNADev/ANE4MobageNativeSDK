package UITest.ad
{
	import com.mobage.air.ErrorCode;
	import com.mobage.air.ad.AdListener;
	import com.mobage.air.ad.FrameID;
	import com.mobage.air.ad.MobageAd;
	import com.mobage.air.ad.MobageAdError;
	import com.mobage.air.ad.MobageAdListener;
	import com.mobage.air.util.AlertDialog;
	
	import flash.display.Sprite;
	
	import UITest.MainMenu;
	
	import util.ButtonList;

	public class MobageAdMenu extends Sprite implements AdListener
	{
		private var userID : String = null;
		
		
		
		
		public function MobageAdMenu(_userID : String)
		{
			userID = _userID;
			MobageAdListener.setListner(this);
		}
		
		public function createMobageAdMenu() :void{
			var adButtons :ButtonList = new ButtonList(0);
			addChild(adButtons);
			
			
			adButtons.add("Load IconListView",function() :void {
				com.mobage.air.ad.MobageAd.loadIconListView(FrameID.A);
			});
			
			adButtons.add("Hide IconListView",function() :void {
				com.mobage.air.ad.MobageAd.hideIconListView();
			});
			
			
			adButtons.add("Load PopUpDialog",function() :void {
				com.mobage.air.ad.MobageAd.loadPopupDialog(FrameID.A, "Hello This a Test For me");
			})
			
			adButtons.add("Send Custom Event",function() :void {
				com.mobage.air.ad.MobageAdEventReporter.sendCustomEvent("YES_WE_CAN",
					function() :void {
						trace('Send Custom Event success');
						AlertDialog.show({
							title: "Send Custom Event success",
							message: "Success"
						});
					},function(error :ErrorCode) :void {
						trace("Send Custom Event failed: " + error)
						AlertDialog.show({
							title: "Failed",
							message: error.toString()
						});
					});
			})
			
			adButtons.add("Go Back To Main Menu",function() :void {
				var main:MainMenu = new MainMenu(userID);
				addChild(main);
				main.createMainMenu();
				removeChild(adButtons);
			});
		}
		
		public function onDismissScreen(adType :String) :void {
			trace("onDismissScreen");
			
		}
		
		public function onFailedToReceiveAd(error :MobageAdError) :void {
			trace("onFailedToReceiveAd :" + error.error);
			
		}
		
		public function onLeaveApplication(adType :String) :void {
			trace("onLeaveApplication");
			
		}
		
		public function onPresentScreen(adType :String) :void {
			trace("onPresentScreen");
			
		}
		
		public function onReceiveAd(adType :String) :void {
			trace("onReceiveAd");
			if(adType == "IconListView"){
			com.mobage.air.ad.MobageAd.showIconListView("BOTTOM");}
			else {
			com.mobage.air.ad.MobageAd.showPopupDialog();}
		}
		
		
	}
}