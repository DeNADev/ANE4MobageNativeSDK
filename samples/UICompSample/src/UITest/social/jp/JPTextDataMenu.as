package UITest.social.jp
{
    import com.mobage.air.ErrorCode;
    import com.mobage.air.social.jp.Textdata;
    import com.mobage.air.social.jp.TextdataEntry;
    import com.mobage.air.util.AlertDialog;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.text.TextField;

    import util.ButtonList;
    import util.LabelList;
    import util.define;

    public class JPTextDataMenu extends Sprite {
        private var userID :String = null;

        public function JPTextDataMenu(_userID :String) {
            userID = _userID;
        }

        public function createJPTextDataMenu() :void {
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
                trace('Create Entry (JP)');
                var textEntry :com.mobage.air.social.jp.TextdataEntry = new com.mobage.air.social.jp.TextdataEntry({
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

                com.mobage.air.social.jp.Textdata.createEntry(
                    text_group.text,
                    textEntry,
                    function(entry :com.mobage.air.social.jp.TextdataEntry) :void {
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
                trace('Update Entries (JP)');
                com.mobage.air.social.jp.Textdata.getEntries(
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
                trace('Update Entry (JP)');
                var textEntry:com.mobage.air.social.jp.TextdataEntry = new com.mobage.air.social.jp.TextdataEntry({
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
                com.mobage.air.social.jp.Textdata.updateEntry(
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
                trace('Delete Entry (JP)');
                com.mobage.air.social.jp.Textdata.deleteEntry(
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

            jsButtons.add("Go Back To JP Menu", function() :void {
                var jp :JPMenu = new JPMenu(userID);
                addChild(jp);
                jp.createJPMenu();
                removeChild(jsButtons);
                removeChild(labels);
            });

        }
    }
}