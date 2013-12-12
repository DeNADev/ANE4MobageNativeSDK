package UITest.social.common
{
    import com.mobage.air.ErrorCode;
    import com.mobage.air.social.common.RemoteNotification;
    import com.mobage.air.social.common.RemoteNotificationPayload;
    import com.mobage.air.social.common.RemoteNotificationPayload_iOS;
    import com.mobage.air.social.common.RemoteNotificationResponse;
    import com.mobage.air.social.common.RemoteNotificationResponse_iOS;
    import com.mobage.air.util.AlertDialog;
    
    import flash.display.Sprite;
    import flash.text.TextField;
    
    import util.ButtonList;
    import util.LabelList;
    import util.define;
    
    public class RemoteNotificationMenu extends Sprite {	
        private var userID :String = null;
        
        public function RemoteNotificationMenu(_userID : String) {
            userID = _userID;
        }
        
        public function createRemoteNotificationMenu() : void {
            var rmButtons :ButtonList = new ButtonList(0);
            addChild(rmButtons);
            
            var labels :LabelList = new LabelList();
            addChild(labels);
            
            var text_message:TextField = labels.add(define.REMOTENOTIFICATION_MESSAGE, true);
            labels.add("Message", false);
            var text_targetuser:TextField = labels.add(userID, true);
            labels.add("TargetUserID", false);
            
            rmButtons.add("Get Remote Enabled", function() :void {
                RemoteNotification.getRemoteNotificationsEnabled(function(enabled :Boolean) :void {
                    trace('getRemoteNotificationsEnabled() Succeeded: ' + enabled);
                    AlertDialog.show({
                        title: "Succeeded",
                        message: "Enable is :" + enabled
                    });
                },function(error :ErrorCode) :void {
                    trace("getRemoteNotificationsEnabled() failed: " + error);
                    AlertDialog.show({
                        title: "Failed",
                        message: error.toString()
                    });
                });
            });
            
            rmButtons.add("Enable Remote", function() :void {
                RemoteNotification.setRemoteNotificationsEnabled(true, function() :void {
                    trace('setRemoteNotificationsEnabled() Succeeded');
                    AlertDialog.show({
                        title: "Succeeded",
                        message: "Remote Notification has been enabled"
                    });
                },function(error :ErrorCode) :void {
                    trace("setRemoteNotificationsEnabled() failed: " + error);
                    AlertDialog.show({
                        title: "Failed",
                        message: error.toString()
                    });
                });
            });
            
            rmButtons.add("Send Remote for Android", function() :void {	
                var payload :RemoteNotificationPayload = new RemoteNotificationPayload(
                    {
                        style:"",
                        message:text_message.text,collapseKey:"",
                        extras:["This is Extra"],iconUrl:""
                    });
                
                RemoteNotification.send(
                    text_targetuser.text,
                    payload,
                    function(rp :RemoteNotificationResponse) :void {
                        trace('send() Succeeded: '+JSON.stringify(rp.payload, null, 2));
                        AlertDialog.show({
                            title: "Succeeded",
                            message: JSON.stringify(rp.payload, null, 2)
                        });
                    },
                    function(error :ErrorCode) :void {
                        trace("send() failed: " + error);
                        AlertDialog.show({
                            title: "Failed",
                            message: error.toString()
                        });
                    });
            });
            
            rmButtons.add("Send Remote for iOS", function() :void {
                var extras :Array = [];
                extras.push(["value", "This is Extra"]);
                var payload :RemoteNotificationPayload_iOS = new RemoteNotificationPayload_iOS({
                    badge:1,
                    message:text_message.text,
                    sound:"default",
                    extras:extras});
                
                RemoteNotification.send_iOS(
                    text_targetuser.text,
                    payload,
                    function(rp :RemoteNotificationResponse_iOS) :void {
                        trace('send() Succeeded: '+JSON.stringify(rp.payload, null, 2));
                        AlertDialog.show({
                            title: "Succeeded",
                            message: JSON.stringify(rp.payload, null, 2)
                        });
                    },
                    function(error :ErrorCode) :void {
                        trace("send() failed: " + error);
                        AlertDialog.show({
                            title: "Failed",
                            message: error.toString()
                        });
                    });
            });
            
            rmButtons.add("Go Back To Common Menu", function() :void {
                var common:CommonMenu = new CommonMenu(userID);
                addChild(common);
                common.createCommonMenu();
                removeChild(rmButtons);
                removeChild(labels);
            });	
        }
    }
}