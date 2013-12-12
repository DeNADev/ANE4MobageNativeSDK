package UITest.social.jp
{
    import com.mobage.air.social.jp.DocumentType;
    import com.mobage.air.social.jp.Gravity;
    import com.mobage.air.social.jp.Service;
    
    import flash.display.Sprite;
    
    import util.ButtonList;
    
    public class JPServiceMenu extends Sprite {	
        private var userID :String = null;
        
        public function JPServiceMenu(_userID :String) {
            userID = _userID;
        }
        
        public function createJPServiceMenu() :void {
            var jsButtons :ButtonList = new ButtonList(0);
            addChild(jsButtons);
            
            jsButtons.add("LEGAL", function() :void {
                com.mobage.air.social.jp.Service.openDocument(DocumentType.LEGAL, function() :void {
                    trace('document dissmissed');
                });
            });
            
            jsButtons.add("AGREEMENT", function() :void {
                com.mobage.air.social.jp.Service.openDocument(DocumentType.AGREEMENT, function() :void {
                    trace('document dissmissed');
                });
            });
            
            jsButtons.add("CONTACT", function() :void {
                com.mobage.air.social.jp.Service.openDocument(DocumentType.CONTACT, function() :void {
                    trace('document dissmissed');
                });
            });
            
            jsButtons.add("TOS_LITE", function() :void {
                com.mobage.air.social.jp.Service.openDocument(DocumentType.TOS_LITE, function() :void {
                    trace('document dissmissed');
                });
            });
            
            jsButtons.add("AGREEMENT_LITE", function() :void {
                com.mobage.air.social.jp.Service.openDocument(DocumentType.AGREEMENT_LITE, function() :void {
                    trace('document dissmissed');
                });
            });
            
            jsButtons.add("SMS_VERIFICATION", function() :void {
                com.mobage.air.social.jp.Service.openDocument(DocumentType.SMS_VERIFICATION, function() :void {
                    trace('document dissmissed');
                });
            });
            
            jsButtons.add("Show Community Button", function() :void {				
                trace('Called Show Community Button');
                com.mobage.air.social.jp.Service.showCommunityButton(Gravity.BOTTOM_LEFT, "blue");
            });
            
            jsButtons.add("Hide Community Button", function() :void {				
                trace('Called Hide Community Button');
                com.mobage.air.social.jp.Service.hideCommunityButton();
            });
            
            jsButtons.add("Share Message", function() :void {				
                trace('Called Share Message');
                com.mobage.air.social.jp.Service.shareMessage("Hello","Hello Mobage","", function() :void {
                    trace('Dialog Dismissed');
                });
            });
            
            jsButtons.add("Go Back To JP Menu",function() :void {
                var jp :JPMenu = new JPMenu(userID);
                addChild(jp);
                jp.createJPMenu();
                removeChild(jsButtons);
            });
            
        }
    }
}