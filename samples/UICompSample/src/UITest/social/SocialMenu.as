package UITest.social
{	
	import flash.display.Sprite;
	
	import UITest.MainMenu;
	import UITest.social.common.CommonMenu;
	import UITest.social.jp.JPMenu;
	import UITest.social.kr.KRMenu;
	
	import util.ButtonList;
	
	public class SocialMenu extends Sprite
	{	
		private var userID : String = null;
		
		public function SocialMenu(_userID : String)
		{
			userID = _userID;
		}
		
		public function createSocialMenu() : void {
			var sButtons :ButtonList = new ButtonList(0);
			addChild(sButtons);
			
			sButtons.add("Common Menu",function() :void {
				var common:CommonMenu = new CommonMenu(userID);
				addChild(common);
				common.createCommonMenu();
				removeChild(sButtons);
			});
			
			sButtons.add("JP Menu",function() :void {
				var jp:JPMenu = new JPMenu(userID);
				addChild(jp);
				jp.createJPMenu();
				removeChild(sButtons);
			});
			
			sButtons.add("KR Menu",function() :void {
				var kr:KRMenu = new KRMenu(userID);
				addChild(kr);
				kr.createKRMenu();
				removeChild(sButtons);
			});
			
			sButtons.add("Go Back To Main Menu",function() :void {
				var main:MainMenu = new MainMenu(userID);
				addChild(main);
				main.createMainMenu();
				removeChild(sButtons);
			});
			
		}
	}
}