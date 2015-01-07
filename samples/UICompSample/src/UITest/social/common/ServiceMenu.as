package UITest.social.common
{
    import com.mobage.air.social.common.Service;
    import com.mobage.air.util.AlertDialog;
    
    import flash.display.Sprite;
    
    import util.ButtonList;
       
    public class ServiceMenu extends Sprite {	
        private var userID :String = null;
        
        public function ServiceMenu(_userID :String) {
            userID = _userID;
        }
        
        public function createServiceCommonMenu() :void {
            var sButtons :ButtonList = new ButtonList(0);
            addChild(sButtons);
            
            
            sButtons.add("Get Balance Button", function() :void {
                com.mobage.air.social.common.Service.getBalanceButton(0, 0, 150, 50);
            });
            
            sButtons.add("Remove Balance Button", function() :void {
                com.mobage.air.social.common.Service.removeBalanceButton();
            });
            
            sButtons.add("Update Balance Button", function() :void {
                com.mobage.air.social.common.Service.updateBalanceButton();
            });
            
            sButtons.add("showBankUi", function() :void {
                com.mobage.air.social.common.Service.showBankUi(function() :void {
                    trace('showBankUi dismissed');
                });
            });
            
            sButtons.add("openUserProfile", function() :void {
                com.mobage.air.social.common.Service.openUserProfile(userID, function() :void {
                    trace('openUserProfile dismissed');
                });
            });
            
            sButtons.add("openFriendPicker", function() :void {
                com.mobage.air.social.common.Service.openFriendPicker(10, function() :void {
                    trace('openFriendPicker dismissed');
                }, function(userIds :Array) :void {
                    AlertDialog.show({
                        title: "openFriendPicker.onInviteSent",
                        message: JSON.stringify(userIds)
                    });
                }, function(userIds :Array) :void {
                    AlertDialog.show({
                        title: "openFriendPicker.onPicked",
                        message: JSON.stringify(userIds)
                    });
                });
            });
            
            sButtons.add("openPlayerInviter", function() :void {
                com.mobage.air.social.common.Service.openPlayerInviter(
                    "defaultMessage",
                    "http://google.com",
                    function(userIds :Array) :void {
                        AlertDialog.show({
                            title: "openPlayerInviter.onPlayerInviterComplete",
                            message: JSON.stringify(userIds)
                        });
                    },
                    function() :void{
                        trace('openPlayerInviter dismissed');
                    }
                );
            });
			
			sButtons.add("show Community UI", function() :void {
				com.mobage.air.social.common.Service.showCommunityUI(function() :void{
					trace('showCommunityUI dismissed');		
				});
			});
            
            sButtons.add("Go Back To Common Menu",function() :void {
                var common :CommonMenu = new CommonMenu(userID);
                addChild(common);
                common.createCommonMenu();
                removeChild(sButtons);
            });
            
        }
        
        
        
    }
}