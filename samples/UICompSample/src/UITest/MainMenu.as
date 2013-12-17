package UITest
{
    import flash.display.Sprite;
    
    import UITest.ad.MobageAdMenu;
    import UITest.analytics.AnalyticsMenu;
    import UITest.bank.BankMenu;
    import UITest.mobage.MobageMenu;
    import UITest.social.SocialMenu;
    
    import util.ButtonList;
    
    public class MainMenu extends Sprite {	
        private var userID :String = null;
        
        public function MainMenu(_userID :String) {
            userID = _userID;
        }
        
        public function createMainMenu() :void {
            var buttons :ButtonList = new ButtonList(0);
            addChild(buttons);
            
            buttons.add("Bank", function() :void {
                var Bank :BankMenu = new BankMenu(userID);
                removeChild(buttons);
                addChild(Bank);
                Bank.createBankMenu();
            });
            
            buttons.add("Social", function() :void {
                var social :SocialMenu = new SocialMenu(userID);
                removeChild(buttons);
                addChild(social);
                social.createSocialMenu();
            });
            
            buttons.add("Mobage", function() :void {
                var mobage :MobageMenu = new MobageMenu(userID);
                removeChild(buttons);
                addChild(mobage);
                mobage.createMobageMenu();
            });
			
			buttons.add("Ad", function() :void {
				var mobagead :MobageAdMenu = new MobageAdMenu(userID);
				removeChild(buttons);
				addChild(mobagead);
				mobagead.createMobageAdMenu();
			});
            
            buttons.add("Analytics", function() :void {
                var mobagead :AnalyticsMenu = new AnalyticsMenu(userID);
                removeChild(buttons);
                addChild(mobagead);
                mobagead.createAnalyticsMenu();
            });
        }
    }
}