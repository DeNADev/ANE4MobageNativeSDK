package UITest.mobage
{
    import com.mobage.air.Mobage;
    import com.mobage.air.Region;
    import com.mobage.air.TargetUserGrade;
    import com.mobage.air.util.AlertDialog;
    
    import flash.display.Sprite;
    
    import UITest.MainMenu;
    
    import util.ButtonList;
    import util.define;
    
    public class MobageMenu extends Sprite {	
        private var userID :String = null;
        
        public function MobageMenu(_userID :String) {
            userID = _userID;
        }
        
        public function createMobageMenu() :void {
            var mbuttons :ButtonList = new ButtonList(0);
            addChild(mbuttons);
            
            mbuttons.add("SDK version", function() :void {
                var version :String = Mobage.getSdkVersion();
                trace("MobageSDK version :", version);
                AlertDialog.show({
                    title: "MobageSDK",
                    message: "ver:" + version
                });
            });
            
            // can use only JP.
            if (define.REGION == Region.JP) {
                mbuttons.add("Open Upgrade Dialog", function() :void {
                    com.mobage.air.Mobage.openUpgradeDialog(TargetUserGrade.GRADE3, function() :void {
                        trace('Dialog Dismissed');
                        AlertDialog.show({
                            title: "Dialog",
                            message: "Dismissed"
                        });
                    });
                });
                
                mbuttons.add("addDashboardObserver", function() :void {
                    trace('addDashboardObserver');
                    com.mobage.air.Mobage.addDashboardObserver();
                    AlertDialog.show({
                        title: "DashboardObserver",
                        message: "added"
                    });
                });
                
                mbuttons.add("removeDashboardObserver", function() :void {
                    trace('removeDashboardObserver');
                    com.mobage.air.Mobage.removeDashboardObserver();
                    AlertDialog.show({
                        title: "DashboardObserver",
                        message: "removed"
                    });
                });
                
                mbuttons.add("showNicknameRegistrationDialog", function() :void {
                    trace('showNicknameRegistrationDialog');
                    com.mobage.air.Mobage.showNicknameRegistrationDialog(
                        "abcdefghijklmn",
                        function(alreadyRegistered :Boolean) :void {
                            AlertDialog.show({
                                title: "showNicknameRegistrationDialog",
                                message: "" + alreadyRegistered
                            });
                        });
                    
                });
            }
            
            mbuttons.add("Logout", function() :void {
                com.mobage.air.Mobage.showLogoutDialog(function() :void {
                    trace('logout succeeded');
                    removeChild(mbuttons);
                    userID = null;
                }, function() :void {
                    trace('logout canceled');
                });
            });
            
            mbuttons.add("Go Back To Main Menu",function() :void {
                var main :MainMenu = new MainMenu(userID);
                addChild(main);
                main.createMainMenu();
                removeChild(mbuttons);
            });
        }
    }
}