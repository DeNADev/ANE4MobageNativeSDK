package UITest.social.common
{
    import com.mobage.air.ErrorCode;
    import com.mobage.air.social.common.Appdata;
    import com.mobage.air.util.AlertDialog;
    
    import flash.display.Sprite;
    import flash.text.TextField;
    
    import util.ButtonList;
    import util.LabelList;
    import util.define;
    
    public class AppdataMenu extends Sprite {	
        private var userID :String = null;
        
        public function AppdataMenu(_userID :String) {
            userID = _userID;
        }
        
        public function createAppdataMenu() :void {
            var bButtons :ButtonList = new ButtonList(0);
            addChild(bButtons);
            
            var labels :LabelList = new LabelList();
            addChild(labels);
            
            var text_Value:TextField = labels.add(define.APPDATA_VALUE, true);
            labels.add("Values", false);
            var text_Key:TextField = labels.add(define.APPDATA_KEY, true);
            labels.add("Keys", false);
            
            bButtons.add("getEntries", function() :void {
                var targetKeys :Array = text_Key.text.split(",");
                Appdata.getEntries(targetKeys,
                    function (entries :Object) :void {
                        var resultAry :Array = new Array;
                        for each (var key :String in targetKeys) {
                            if (entries.hasOwnProperty(key)) {
                                resultAry.push("key ["+ key +"] : value [" + entries[key] + "]");
                            }
                        }
                        trace("getEntries() succeeded: " + resultAry);
                        AlertDialog.show({
                            title: "Succeeded",
                            message: "Entries: "+ resultAry 
                        });
                    },
                    function (error :ErrorCode) :void {
                        trace("getUser() failed: " + error);
                        
                        AlertDialog.show({
                            title: "Failed",
                            message: error.toString()
                        });
                    }
                );
            });
            
            bButtons.add("updateEntries", function() :void {
                var entries :Object = new Object;
                var targetKeys :Array = text_Key.text.split(",");
                var targetValues :Array = text_Value.text.split(",");
                
                if (targetKeys.length != targetValues.length) {
                    trace("Error: Key/Value length not match.");
                    return;
                }
                
                for (var i :int = 0; i < targetKeys.length; i++) {
                    entries[targetKeys[i]] = targetValues[i];
                }
                
                Appdata.updateEntries(entries,
                    function (keys :Array) :void {
                        trace("updateEntries() succeeded: " + keys);
                        AlertDialog.show({
                            title: "Success",
                            message: keys
                        });
                    },
                    function (error :ErrorCode) :void {
                        trace("updateEntries() failed: " + error);
                        
                        AlertDialog.show({
                            title: "Failed",
                            message: error.toString()
                        });
                    }
                );
            });
            
            bButtons.add("deleteEntries", function() :void {
                var targetKeys : Array = text_Key.text.split(",");
                Appdata.deleteEntries(targetKeys,
                    function (keys :Array) :void {
                        trace("deleteEntries() succeeded: " + keys);
                        AlertDialog.show({
                            title: "Success",
                            message: keys
                        });
                    },
                    function (error :ErrorCode) :void {
                        trace("deleteEntries() failed: " + error);
                        
                        AlertDialog.show({
                            title: "Failed",
                            message: error.toString()
                        });
                    }
                );
            });
            
            bButtons.add("Go Back To Common Menu", function() :void {
                var common:CommonMenu = new CommonMenu(userID);
                addChild(common);
                common.createCommonMenu();
                removeChild(bButtons);
                removeChild(labels);
            });
        }
    }
}