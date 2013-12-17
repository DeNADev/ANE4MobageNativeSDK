package UITest.analytics
{
    import com.mobage.air.analytics.EventReporter;
    import com.mobage.air.util.AlertDialog;
    
    import flash.display.Sprite;
    
    import UITest.MainMenu;
    
    import util.ButtonList;
    
    public class AnalyticsMenu extends Sprite
    {	
        private var _userID :String = null;
        private var _temporaryCredential :String = null;
        private var _verifier :String = null;
        
        public function AnalyticsMenu(userID : String)
        {
            _userID = userID;
        }
        
        public function createAnalyticsMenu() : void {
            var sButtons :ButtonList = new ButtonList(0);
            addChild(sButtons);
            
            sButtons.add("Report",function() :void {
                com.mobage.air.analytics.EventReporter.report(
                    "EVENTNAME01",
                    {
                        key: "value",
                        tab: "\t"
                    },
                    {
                        level: "3",
                        point: "10"
                    });
                
                AlertDialog.show({
                    title: "EventReporter",
                    message: "send Report"
                });
            });
            
            sButtons.add("Go Back To Main Menu",function() :void {
                var main:MainMenu = new MainMenu(_userID);
                addChild(main);
                main.createMainMenu();
                removeChild(sButtons);
            });
        }
    }
}
