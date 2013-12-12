package UITest.social.common
{
    import com.mobage.air.ErrorCode;
    import com.mobage.air.social.PagingOption;
    import com.mobage.air.social.PagingResult;
    import com.mobage.air.social.common.Blacklist;
    import com.mobage.air.util.AlertDialog;
    
    import flash.display.Sprite;
    import flash.text.TextField;
    
    import util.ButtonList;
    import util.LabelList;
    import util.define;
    
    public class BlackListMenu extends Sprite {	
        private var userID :String = null;
        private static var transactionId :String = null;
        private var options :PagingOption = new PagingOption({count:10,start:1});
        
        public function BlackListMenu(_userID :String) {
            userID = _userID;
        }
        
        public function createBlackListMenu() :void {
            var bButtons :ButtonList = new ButtonList(0);
            addChild(bButtons);
            
            var labels :LabelList = new LabelList();
            addChild(labels);
            
            var target_userId:TextField = labels.add(define.BLACK_LIST_TARGET_USER_ID, true);
            labels.add("Target ID", false);
            
            bButtons.add("Check Blacklist", function() :void {
                com.mobage.air.social.common.Blacklist.checkBlacklist(
                    userID,
                    target_userId.text,
                    options,
                    function (userIds :Array, result :PagingResult) :void {
                        trace("checkBlacklist() succeeded: " + userID.toString());
                        AlertDialog.show({
                            title: "Succeeded",
                            message: "Result" + result.toString() + "\nBlacklist: " + userIds.toString() 
                        });
                    }, function(error :ErrorCode) :void {
                        trace("checkBlacklist() failed: " + error)
                        AlertDialog.show({
                            title: "Failed",
                            message: error.toString()
                        });
                    });
            });
            bButtons.add("Go Back To Common Menu", function() :void {
                var common :CommonMenu = new CommonMenu(userID);
                addChild(common);
                common.createCommonMenu();
                removeChild(bButtons);
                removeChild(labels);
            });
        }
    }
}