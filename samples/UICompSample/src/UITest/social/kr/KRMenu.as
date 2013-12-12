package UITest.social.kr
{	
    import flash.display.Sprite;
    
    import UITest.social.SocialMenu;
    
    import util.ButtonList;
    
    public class KRMenu extends Sprite {	
        private var userID :String = null;
        
        public function KRMenu(_userID :String) {
            userID = _userID;
        }
        
        public function createKRMenu() :void {
            var sButtons :ButtonList = new ButtonList(0);
            addChild(sButtons);
            
            sButtons.add("KR Service", function() :void {
                var KRService :KRServiceMenu = new KRServiceMenu(userID);
                removeChild(sButtons);
                addChild(KRService);
                KRService.createKRServiceMenu();
                
            });
            
            sButtons.add("KR TextData", function() :void {
                var KRTextData :KRTextDataMenu = new KRTextDataMenu(userID);
                removeChild(sButtons);
                addChild(KRTextData);
                KRTextData.createKRTextDataMenu();
                
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

