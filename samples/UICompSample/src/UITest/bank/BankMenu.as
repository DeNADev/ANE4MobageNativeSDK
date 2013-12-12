package UITest.bank
{
    import com.mobage.air.ErrorCode;
    import com.mobage.air.bank.Account;
    import com.mobage.air.bank.BillingItem;
    import com.mobage.air.bank.Debit;
    import com.mobage.air.bank.Inventory;
    import com.mobage.air.bank.ItemData;
    import com.mobage.air.bank.Transaction;
    import com.mobage.air.util.AlertDialog;
    
    import flash.display.Sprite;
    import flash.text.TextField;
    
    import UITest.MainMenu;
    
    import util.ButtonList;
    import util.LabelList;
    import util.define;

    public class BankMenu extends Sprite {
        private var userID :String = null;
        private static var item :ItemData = null;
        private static var transactionId :String = null;

        public function BankMenu(_userID :String) {
            userID = _userID;
        }

        public function createBankMenu() :void {
            var bButtons :ButtonList = new ButtonList(0);
            addChild(bButtons);

            var labels :LabelList = new LabelList();
            addChild(labels);

            var text_transactionId:TextField = labels.add("", true);
            labels.add("Transaction ID", false);
            var text_itemData:TextField = labels.add(define.BANK_ITEM_ID, true);
            labels.add("Item ID", false);
			
			bButtons.add("Get Balance", function() :void {
				com.mobage.air.bank.Account.getBalance(function(balance :int) :void {
					trace("getBalance() succeeded :" + balance.toString());
					AlertDialog.show({
						title: "Succeeded",
						message: "Your Balance is : " + balance.toString() 
					});
					
				}, function(error :ErrorCode) :void {
					trace("getItem() failed: " + error)
					AlertDialog.show({
						title: "Failed",
						message: error.toString()
					});
				});
			});


            bButtons.add("Get Bank Inventory", function() :void {
                com.mobage.air.bank.Inventory.getItem(text_itemData.text, function(itemData :ItemData) :void {
                    trace("getItem() succeeded :" + itemData.name);
                    AlertDialog.show({
                        title: "Succeeded",
                        message: "ItemData Name : " + itemData.name + "\n Price : " + itemData.price
                        + "\n Item Description : " + itemData.description
                    });
                    item = itemData;
                }, function(error :ErrorCode) :void {
                    trace("getItem() failed: " + error)
                    AlertDialog.show({
                        title: "Failed",
                        message: error.toString()
                    });
                });
            });

            bButtons.add(
                "Get Transaction",
                function() :void {
                    Debit.getTransaction(
                        text_transactionId.text,
                        function(txn :Transaction) :void {
                            AlertDialog.show({
                                title: "get Transaction",
                                message: txn.toString()
                            });
                        },
                        function(e :ErrorCode) :void {
                            AlertDialog.show({
                                title: "Transaction error",
                                message: e.toString()
                            });
                        });
                });

            bButtons.add("Client Create Transaction", function() :void {
                if (item == null) {
                    AlertDialog.show({
                        title: "Cant confirm item data",
                        message: "Please run Get Item Data before running Debit Transaction"
                    });
                } else {
                    Debit.createTransaction(
                        [new BillingItem({ item: item })],
                        "this is a comment",
                        function(txn :Transaction) :void {
                            trace('transation created' + JSON.stringify(txn.items, null, 2));
                            transactionId = txn.id;
                            text_transactionId.text = transactionId;
                        }, function() :void {
                            trace('transaction canceled');
                            AlertDialog.show({
                                title: "Transaction Canceled",
                                message: "Canceled"
                            });
                        }, function(e :ErrorCode) :void {
                            trace('transaction error', e);
                            AlertDialog.show({
                                title: "Transaction error",
                                message: e.toString()
                            });
                        });
                }
            });

            bButtons.add("Client Open Transaction", function() :void {
                Debit.openTransaction(transactionId, function(txn :Transaction) :void {
                    trace('transaction opened');
                    AlertDialog.show({
                        title: "Transaction Opened",
                        message: "State Open"
                    });
                }, function(e :ErrorCode) :void {
                    trace('transaction error', e);
                    AlertDialog.show({
                        title: "Transaction error",
                        message: e.toString()
                    });
                });
            });

            bButtons.add("Client Cancel Transaction", function() :void {
                Debit.cancelTransaction(transactionId, function(txn :Transaction) :void {
                    trace('transaction Canceled');
                    AlertDialog.show({
                        title: "Transaction Canceled",
                        message: "State Cancel"
                    });
                }, function(e :ErrorCode) :void {
                    trace('transaction error', e);
                    AlertDialog.show({
                        title: "Transaction error",
                        message: e.toString()
                    });
                });
            });

            bButtons.add("Client Close Transaction", function() :void {
                Debit.closeTransaction(transactionId, function(txn :Transaction) :void {
                    trace('transaction Close');
                    AlertDialog.show({
                        title: "Transaction Closed",
                        message: "State Closed"
                    });
                }, function(e :ErrorCode) :void {
                    trace('transaction error', e);
                    AlertDialog.show({
                        title: "Transaction error",
                        message: e.toString()
                    });
                });
            });

            bButtons.add("Client Continue Transaction", function() :void {
                Debit.continueTransaction(text_transactionId.text, function(txn :Transaction) :void {
                    trace('transaction Continue');
                    AlertDialog.show({
                        title: "Transaction Continue",
                        message: "State Continue"
                    });
                }, function() :void {
                    trace('transaction canceled');
                    AlertDialog.show({
                        title: "Transaction Canceled",
                        message: "Canceled"
                    });
                }, function(e :ErrorCode) :void {
                    trace('transaction error', e);
                    AlertDialog.show({
                        title: "Transaction error",
                        message: e.toString()
                    });
                });
            });

            bButtons.add("Go Back To Main Menu",function() :void {
                var main:MainMenu = new MainMenu(userID);
                addChild(main);
                main.createMainMenu();
                removeChild(bButtons);
                removeChild(labels);
            });
        }
    }
}