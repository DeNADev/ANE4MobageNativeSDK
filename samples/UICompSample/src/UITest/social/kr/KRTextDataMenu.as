package UITest.social.kr
{
    import com.mobage.air.ErrorCode;
    import com.mobage.air.social.kr.Textdata;
    import com.mobage.air.social.kr.TextdataEntry;
    import com.mobage.air.util.AlertDialog;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.text.TextField;

    import util.ButtonList;
    import util.LabelList;
    import util.define;

    public class KRTextDataMenu extends Sprite {
        private var userID :String = null;

        public function KRTextDataMenu(_userID :String) {
            userID = _userID;
        }

        public function createKRTextDataMenu() :void {
            var jsButtons :ButtonList = new ButtonList(0);
            addChild(jsButtons);

            var labels :LabelList = new LabelList();
            addChild(labels);

            var text_send:TextField = labels.add("initial text", true);
            labels.add("Send Text", false);
            var text_entry_id:TextField = labels.add("", true);
            labels.add("Entry ID", false);
            var text_group:TextField = labels.add(define.TEXT_GROUP_NAME, true);
            labels.add("Group name", false);

            jsButtons.add("Create Entry", function() :void {
                trace('Create Entry (KR)');
                var textEntry :com.mobage.air.social.kr.TextdataEntry = new com.mobage.air.social.kr.TextdataEntry({
                    //					id:
                    //					groupName:,
                    //					parentId:,
                    //					writerId:,
                    //					ownerId:,
                    data: text_send.text
                    //					status:,
                    //					publish:,
                    //					updated:,
                });

                com.mobage.air.social.kr.Textdata.createEntry(
                    text_group.text,
                    textEntry,
                    function(entry :com.mobage.air.social.kr.TextdataEntry) :void {
                        AlertDialog.show({
                            title: "Succeeded",
                            message: entry.toString()
                        });
                        text_entry_id.text = entry.id;
                        trace(entry);
                    },
                    function(e :ErrorCode) :void {
                        AlertDialog.show({
                            title: "Error",
                            message: e.toString()
                        });
                        trace(e);
                    });

            });

            jsButtons.add("Get Entries", function() :void {
                trace('Update Entries (KR)');
                com.mobage.air.social.kr.Textdata.getEntries(
                    text_group.text,
                    [text_entry_id.text],
                    function(entries :Array) :void {
                        AlertDialog.show({
                            title: "Succeeded",
                            message: entries.toString()
                        });
                        trace(entries);
                    },
                    function(e :ErrorCode) :void {
                        AlertDialog.show({
                            title: "Error",
                            message: e.toString()
                        });
                        trace(e);
                    }
                );
            });

            jsButtons.add("Update Entry", function() :void {
                trace('Update Entry (KR)');
                var textEntry :com.mobage.air.social.kr.TextdataEntry = new com.mobage.air.social.kr.TextdataEntry({
                    //					id:
                    //					groupName:,
                    //					parentId:,
                    //					writerId:,
                    //					ownerId:,
                    data: text_send.text
                    //					status:,
                    //					publish:,
                    //					updated:,
                });
                com.mobage.air.social.kr.Textdata.updateEntry(
                    text_group.text,
                    text_entry_id.text,
                    textEntry,
                    function() :void {
                        AlertDialog.show({
                            title: "Succeeded"
                        });
                    },
                    function(e :ErrorCode) :void {
                        AlertDialog.show({
                            title: "Error",
                            message: e.toString()
                        });
                        trace(e);
                    }
                );
            });

            jsButtons.add("Delete Entry", function() :void {
                trace('Delete Entry (KR)');
                com.mobage.air.social.kr.Textdata.deleteEntry(
                    text_group.text,
                    text_entry_id.text,
                    function() :void {
                        AlertDialog.show({
                            title: "Succeeded"
                        });
                    },
                    function(e :ErrorCode) :void {
                        AlertDialog.show({
                            title: "Error",
                            message: e.toString()
                        });
                        trace(e);
                    }
                );
            });

            jsButtons.add("Go Back To KR Menu", function() :void {
                var kr :KRMenu = new KRMenu(userID);
                addChild(kr);
                kr.createKRMenu();
                removeChild(jsButtons);
                removeChild(labels);
            });

        }
    }
}