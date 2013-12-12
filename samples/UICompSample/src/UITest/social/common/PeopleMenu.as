package UITest.social.common
{
    import com.mobage.air.ErrorCode;
    import com.mobage.air.social.PagingOption;
    import com.mobage.air.social.PagingResult;
    import com.mobage.air.social.User;
    import com.mobage.air.social.common.People;
    import com.mobage.air.util.AlertDialog;
    
    import flash.display.Sprite;
    import flash.text.TextField;
    
    import util.ButtonList;
    import util.LabelList;
    import util.define;
    
    public class PeopleMenu extends Sprite {	
        private var userID :String = null;
        private var userField :Array = new Array (
            User.ID,
            User.DISPLAY_NAME,
            User.NICKNAME,
            User.ABOUT_ME,
            User.AGE,
            User.BIRTHDAY,
            User.GENDER,
            User.HAS_APP,
            User.THUMBNAIL_URL,
            User.JOB_TYPE,
            User.BLOOD_TYPE,
            User.IS_VERIFIED,
            User.IS_FAMOUS,
            User.GRADE
        );
        private var options :PagingOption = new PagingOption({count:10,start:1});
        
        public function PeopleMenu(_userID :String) {
            userID = _userID;
        }
        
        public function createPeopleMenu() : void {
            var pButtons :ButtonList = new ButtonList(0);
            addChild(pButtons);
            
            var labels :LabelList = new LabelList();
            addChild(labels);
            
            var text_targetusers:TextField = labels.add(define.POPLE_TARGET_USERS, true);
            labels.add("TargetUsersID", false);
            var text_targetuser:TextField = labels.add(userID, true);
            labels.add("YourUserID", false);
            
            pButtons.add("getCurrentUser", function() :void {
                People.getCurrentUser(userField,
                    function(user :User) :void {
                        trace("getCurrentUser() succeeded: " + user.nickname);
                        AlertDialog.show({
                            title: "Succeeded",
                            message: "User NickName: "+ user.nickname.toString() + "\n User ID: " + user.id 
                        });
                    },
                    function(error :ErrorCode) :void {
                        trace("getCurrentUser() failed: " + error);
                        
                        AlertDialog.show({
                            title: "Failed",
                            message: error.toString()
                        });
                    });
            });
            
            pButtons.add("getUser", function() :void {
                People.getUser(text_targetuser.text,userField,
                    function(user :User) :void {
                        trace("getUser() succeeded: " + user.nickname);
                        AlertDialog.show({
                            title: "Succeeded",
                            message: "User NickName: "+ user.nickname.toString() + "\n User ID: " + user.id 
                        });
                    },
                    function(error :ErrorCode) :void {
                        trace("getUser() failed: " + error);
                        
                        AlertDialog.show({
                            title: "Failed",
                            message: error.toString()
                        });
                    });
            });	
            
            pButtons.add("getUsers", function() :void {
                var targetUsers :Array = text_targetusers.text.split(",");
                trace(targetUsers);
                People.getUsers(targetUsers,userField,
                    function(users :Array , result :PagingResult) :void {
                        trace("getUsers() succeeded: " + JSON.stringify(users));
                        AlertDialog.show({
                            title: "Succeeded",
                            message: "Users: "+ JSON.stringify(users) 
                        });
                    },
                    function(error :ErrorCode) :void {
                        trace("getUsers() failed: " + error);
                        AlertDialog.show({
                            title: "Failed",
                            message: error.toString()
                        });
                    });
            });
            
            pButtons.add("getFriends", function() :void {
                People.getFriends(text_targetuser.text,userField,options,function(users :Array, result :PagingResult) : void {
                    trace("getFriends() succeeded: " + JSON.stringify(users));
                    AlertDialog.show({
                        title: "Succeeded",
                        message: "User Friends: "+ JSON.stringify(users) 
                    });
                },function(error :ErrorCode) :void {
                    trace("getFriends() failed: " + error);
                    
                    AlertDialog.show({
                        title: "Failed",
                        message: error.toString()
                    });
                });
            });	
            
            pButtons.add("getFriendsWithGame", function() :void {
                People.getFriendsWithGame(text_targetuser.text,userField,options,function(users :Array, result :PagingResult) : void {
                    trace("getFriendsWithGame() succeeded: " + JSON.stringify(users));
                    AlertDialog.show({
                        title: "Succeeded",
                        message: "User Friends With Game: "+ JSON.stringify(users) 
                    });
                },function(error :ErrorCode) :void {
                    trace("getFriendsWithGame() failed: " + error);
                    
                    AlertDialog.show({
                        title: "Failed",
                        message: error.toString()
                    });
                });
            });
            
            pButtons.add("getFriends", function() :void {
                People.getFriends(text_targetuser.text,userField,options,function(users :Array, result :PagingResult) : void {
                    trace("getFriends() succeeded: " + JSON.stringify(users));
                    AlertDialog.show({
                        title: "Succeeded",
                        message: "User Friends: "+ JSON.stringify(users) 
                    });
                },function(error :ErrorCode) :void {
                    trace("getCurrentUser() failed: " + error);
                    
                    AlertDialog.show({
                        title: "Failed",
                        message: error.toString()
                    });
                });
            });	
            
            pButtons.add("Go Back To Common Menu",function() :void {
                var common:CommonMenu = new CommonMenu(userID);
                addChild(common);
                common.createCommonMenu();
                removeChild(pButtons);
                removeChild(labels);
            });
        }
    }
}