package UITest.social.common
{
    import com.mobage.air.ErrorCode;
    import com.mobage.air.social.common.Profanity;
    import com.mobage.air.util.AlertDialog;
    
    import flash.display.Sprite;
    
    import UITest.social.SocialMenu;
    
    import util.ButtonList;
    import util.define;
    
    public class CommonMenu extends Sprite {	
        private var userID :String = null;
        
        public function CommonMenu(_userID :String) {
            userID = _userID;
        }
        
        public function createCommonMenu() :void {
            var sButtons :ButtonList = new ButtonList(0);
            addChild(sButtons);
            
            sButtons.add("App data", function() :void {
                var Appdata :AppdataMenu = new AppdataMenu(userID);
                removeChild(sButtons);
                addChild(Appdata);
                Appdata.createAppdataMenu();
            });
            
            sButtons.add("Black List", function() :void {
                var Blacklist :BlackListMenu = new BlackListMenu(userID);
                removeChild(sButtons);
                addChild(Blacklist);
                Blacklist.createBlackListMenu();
            });
            
            sButtons.add("Leaderboard", function() :void {
                var Leader :LeaderBoardMenu = new LeaderBoardMenu(userID);
                removeChild(sButtons);
                addChild(Leader);
                Leader.createLeaderBoardMenu();
                
            });
            
            sButtons.add("People", function() :void {
                var People :PeopleMenu = new PeopleMenu(userID);
                removeChild(sButtons);
                addChild(People);
                People.createPeopleMenu();
                
            });
            
            sButtons.add("Check Profanity (" + define.PROFANITY_NG_WORD + ")", function() :void {
                com.mobage.air.social.common.Profanity.checkProfanity(define.PROFANITY_NG_WORD,
                    onSuccessCheckProfanity,
                    onErrorCheckProfanity);
            });
            
            sButtons.add("Check Profanity (" + define.PROFANITY_OK_WORD + ")", function() :void {
                com.mobage.air.social.common.Profanity.checkProfanity(define.PROFANITY_OK_WORD,
                    onSuccessCheckProfanity,
                    onErrorCheckProfanity);
            });
            
            sButtons.add("Remote Notification", function() :void {
                var Remote :RemoteNotificationMenu = new RemoteNotificationMenu(userID);
                removeChild(sButtons);
                addChild(Remote);
                Remote.createRemoteNotificationMenu();
                
            });
            
            sButtons.add("Service Menu", function() :void {
                var service :ServiceMenu = new ServiceMenu(userID);
                removeChild(sButtons);
                addChild(service);
                service.createServiceCommonMenu();
            });
            
            sButtons.add("Go Back To Social Menu", function() :void {
                var social :SocialMenu = new SocialMenu(userID);
                addChild(social);
                social.createSocialMenu();
                removeChild(sButtons);
            });
            
        }
        
        private function onSuccessCheckProfanity(valid :Boolean) :void {
            trace("checkProfanity() Succeeded")
            AlertDialog.show({
                title: "Succeeded",
                message: "valid : " + valid
            });
        }
        
        private function onErrorCheckProfanity(error :ErrorCode) :void {
            trace("checkProfanity() failed: " + error);
            AlertDialog.show({
                title: "Failed",
                message: error.toString()
            });
        }
    }
}