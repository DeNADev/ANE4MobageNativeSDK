package UITest.social.kr
{
    import com.mobage.air.social.kr.DocumentType;
    import com.mobage.air.social.kr.Gravity;
    import com.mobage.air.social.kr.Service;

    import flash.display.Sprite;
    import flash.text.TextField;

    import util.ButtonList;
    import util.LabelList;

    public class KRServiceMenu extends Sprite {
        private var userID :String = null;

        public function KRServiceMenu(_userID :String) {
            userID = _userID;
        }

        public function createKRServiceMenu() :void {
            var jsButtons :ButtonList = new ButtonList(0);
            addChild(jsButtons);

            var labels :LabelList = new LabelList();
            addChild(labels);

            var text_userIds:TextField = labels.add("", true);
            labels.add("User IDs", false);

            jsButtons.add("AGREEMENT", function() :void {
                com.mobage.air.social.kr.Service.openDocument(DocumentType.AGREEMENT, function() :void {
                    trace('document dissmissed');
                });
            });

            jsButtons.add("CONTACT", function() :void {
                com.mobage.air.social.kr.Service.openDocument(DocumentType.CONTACT, function() :void {
                    trace('document dissmissed');
                });
            });

            jsButtons.add("SMS_VERIFICATION", function() :void {
                com.mobage.air.social.kr.Service.openDocument(DocumentType.SMS_VERIFICATION, function() :void {
                    trace('document dissmissed');
                });
            });

            jsButtons.add("Show Community Button", function() :void {
                trace('Called Show Community Button');
                com.mobage.air.social.kr.Service.showCommunityButton(Gravity.BOTTOM_LEFT, "blue");
            });

            jsButtons.add("Hide Community Button", function() :void {
                trace('Called Hide Community Button');
                com.mobage.air.social.kr.Service.hideCommunityButton();
            });

            jsButtons.add("openFriendRequestSender", function() :void {
                trace('openFriendRequestSender');
                var userIds : Array = text_userIds.text.split(",");
                com.mobage.air.social.kr.Service.openFriendRequestSender(userIds, function() :void {
                    trace('Dialog Dismissed');
                });
            });

            jsButtons.add("Share Message", function() :void {
                trace('Called Share Message');
                com.mobage.air.social.kr.Service.shareMessage("Hello","Hello Mobage","",function() :void {
                    trace('Dialog Dismissed');
                });
            });

            jsButtons.add("Go Back To KR Menu",function() :void {
                var kr :KRMenu = new KRMenu(userID);
                addChild(kr);
                kr.createKRMenu();
                removeChild(jsButtons);
                removeChild(labels);
            });

        }
    }
}