package UITest.social.jp
{
    import flash.display.Sprite;
    
    import UITest.social.SocialMenu;
    
    import util.ButtonList;
    
    public class JPMenu extends Sprite {	
        private var userID :String = null;
        
        public function JPMenu(_userID :String) {
            userID = _userID;
        }
        
        public function createJPMenu() :void {
            var sButtons :ButtonList = new ButtonList(0);
            addChild(sButtons);
            
            sButtons.add("JP Service", function() :void {
                var JPService :JPServiceMenu = new JPServiceMenu(userID);
                removeChild(sButtons);
                addChild(JPService);
                JPService.createJPServiceMenu();
            });
            
            sButtons.add("JP TextData", function() :void {
                var JPTextData :JPTextDataMenu = new JPTextDataMenu(userID);
                removeChild(sButtons);
                addChild(JPTextData);
                JPTextData.createJPTextDataMenu();
            });
            
            sButtons.add("Go Back To Social Menu",function() :void {
                var social :SocialMenu = new SocialMenu(userID);
                addChild(social);
                social.createSocialMenu();
                removeChild(sButtons);
            });	
        }
    }
}

