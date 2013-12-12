/*
*The MIT License (MIT)
*Copyright (c) 2013 DeNA Co., Ltd.
*
*Permission is hereby granted, free of charge, to any person obtaining a copy
*of this software and associated documentation files (the "Software"), to deal
*in the Software without restriction, including without limitation the rights
*to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
*copies of the Software, and to permit persons to whom the Software is
*furnished to do so, subject to the following conditions:
*
*The above copyright notice and this permission notice shall be included in
*all copies or substantial portions of the Software.
*
*THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
*IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
*FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
*AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
*LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
*OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
*THE SOFTWARE.
*/
package com.mobage.air.bank
{
    import com.mobage.air.Extension;
    import com.mobage.air.Mobage;
    
    /**
     * Debit is an interface for purchasing in-game items. A transaction begins by calling <code>createTransaction()</code>, which presents
     * a UI to the user. If the user follows through with a purchase in the UI, <code>createTransaction()</code> changes its state from
     * <code>new</code> to <code>authorized</code>. Once <code>createTransaction()</code> executes its callback, the game should call
     * <code>openTransaction()</code>, which changes the state from <code>authorized</code> to <code>open</code> and puts funds into escrow.
     * At this point, the game/game server should deliver the purchased items. Once the items have been delivered, the game should call
     * <code>closeTransaction()</code>. If there is a problem at any point in the transaction lifecycle, you may call <code>cancelTransaction()</code>,
     * which sets the transaction state to <code>canceled</code> and restores funds from escrow back to the user.
     */
    public final class Debit {
        /**
         * Cancels the transaction, which indicates the transaction was canceled or the virtual item could not be delivered and
         * funds need to be returned. The <code>transaction.state</code> transitions to <code>canceled.</code>
         *
         * @param transactionId The <code>transactionId</code> identifying this transaction.
         * @param onProcessTransactionSuccess <code>function(txn :Transaction) :void</code>. Retrieves the transactin details.
         * @param onError <code>function(error :ErrorCode) :void</code>. Handles errors.
         */
        public static function cancelTransaction(transactionId :String,
                                                 onProcessTransactionSuccess :Function,
                                                 onError :Function) :void {
            const funcId :String = 'com.mobage.air.extension.bank.Debit.cancelTransaction';
            const sId    :String = Mobage.once(funcId, onProcessTransactionSuccess);
            const eId    :String = Mobage.once(funcId, onError);
            Extension.call(funcId, transactionId, sId, eId);
        }
        
        /**
         * Closes the transaction, which indicates the virtual item was delivered.
         * The <code>transaction.state</code> transitions from <code>open</code> to <code>closed</code>.
         *
         * @param transactionId The <code>transactionId</code> identifying this transaction.
         * @param onProcessTransactionSuccess <code>function(txn :Transaction) :void</code>. Retrieves the transactin details.
         * @param onError <code>function(error :ErrorCode) :void</code>. Handles errors.
         */
        public static function closeTransaction(transactionId :String,
                                                onProcessTransactionSuccess :Function,
                                                onError :Function) :void {
            const funcId :String = 'com.mobage.air.extension.bank.Debit.closeTransaction';
            const sId    :String = Mobage.once(funcId, onProcessTransactionSuccess);
            const eId    :String = Mobage.once(funcId, onError);
            Extension.call(funcId, transactionId, sId, eId);
        }
        
        /**
         * Continues processing a transaction in the <code>new</code> state created in the Mobage platform server by the game server.
         * Checks the inventory, and transitions the <code>transaction.state</code> from <code>new</code> to <code>authorized</code>.
         * Then, it places funds into escrow. The <code>transaction.state</code> transitions from <code>authorized</code> to <code>open</code>, which
         * indicates the game server needs to deliver the virtual item.
         *
         * @param transactionId The <code>transactionId</code> identifying this transaction.
         * @param onProcessTransactionSuccess <code>function(txn :Transaction) :void</code>. Retrieves the transactin details.
         * @param onProcessTransactionCancel <code>function(txn :Transaction) :void</code>. Handles an user cancel event.
         * @param onError <code>function(error :ErrorCode) :void</code>. Handles errors.
         */
        public static function continueTransaction(transactionId :String,
                                                   onProcessTransactionSuccess :Function,
                                                   onProcessTransactionCancel :Function,
                                                   onError :Function) :void {
            const funcId :String = 'com.mobage.air.extension.bank.Debit.continueTransaction';
            const sId    :String = Mobage.once(funcId, onProcessTransactionSuccess);
            const cId    :String = Mobage.once(funcId, onProcessTransactionCancel);
            const eId    :String = Mobage.once(funcId, onError);
            Extension.call(funcId, transactionId, sId, cId, eId);
        }
        /**
         * Creates a transaction with the <code>transaction.state</code> set to <code>new</code>.
         * Mobage presents a user interface that prompts the user to confirm the transaction.
         * If the user decides not to proceed with the transaction, the callback error will indicate "user canceled."
         * In the client-only flow, it checks inventory and sets the state to <code>authorized</code>.
         *
         * @param billingItems Array of BillingItem. The billing items for the transaction. <br/><b>Note:</b> The array is limited to one item for this release. 
         * @param onProcessTransactionSuccess <code>function(txn :Transaction) :void</code>. Retrieves the transactin details.
         * @param onProcessTransactionCancel <code>function(txn :Transaction) :void</code>. Handles an user cancel event.
         * @param onError <code>function(error :ErrorCode) :void</code>. Handles errors.
         */
        public static function createTransaction(billingItems :Array,
                                                 comment :String,
                                                 onProcessTransactionSuccess :Function,
                                                 onProcessTransactionCancel :Function,
                                                 onError :Function) :void {
            const funcId :String = 'com.mobage.air.extension.bank.Debit.createTransaction';
            const sId    :String = Mobage.once(funcId, onProcessTransactionSuccess);
            const cId    :String = Mobage.once(funcId, onProcessTransactionCancel);
            const eId    :String = Mobage.once(funcId, onError);
            Extension.call(funcId, billingItems, comment, sId, cId, eId);
        }
        
        /**
         * Retrieves the user's transactions where the state is <code>new</code>, <code>authorized</code> or <code>open</code>.
         *
         * @param onProcessTransactionSuccess <code>function(txn :Transaction) :void</code>. Retrieves the transactin details.
         * @param onError <code>function(error :ErrorCode) :void</code>. Handles errors.
         * @private not yet implemented
         */
        public static function getPendingTransactions(onProcessTransactionSuccess :Function,
                                                      onError :Function) :void {
            const funcId :String = 'com.mobage.air.extension.bank.Debit.getPendingTransaction';
            const sId    :String = Mobage.once(funcId, onProcessTransactionSuccess);
            const eId    :String = Mobage.once(funcId, onError);
            Extension.call(funcId, sId, eId);
        }
        
        /**
         * Retrieves the transaction corresponding to the given transaction ID parameter.
         *
         * @param transactionId The <code>transactionId</code> identifying this transaction.
         * @param onProcessTransactionSuccess <code>function(txn :Transaction) :void</code>. Retrieves the transactin details.
         * @param onError <code>function(error :ErrorCode) :void</code>. Handles errors.
         */
        public static function getTransaction(transactionId :String,
                                              onProcessTransactionSuccess :Function,
                                              onError :Function) :void {
            const funcId :String = 'com.mobage.air.extension.bank.Debit.getTransaction';
            const sId    :String = Mobage.once(funcId, onProcessTransactionSuccess);
            const eId    :String = Mobage.once(funcId, onError);
            Extension.call(funcId, transactionId, sId, eId);
        }
        
        /**
         * Places funds into escrow, and begins processing the transaction. 
         * Indicates the game server needs to deliver the virtual item.
         * The <code>transaction.state</code> transitions from <code>authorized</code> to <code>open</code>.
         *
         * @param transactionId The <code>transactionId</code> identifying this transaction.
         * @param onProcessTransactionSuccess <code>function(txn :Transaction) :void</code>. Retrieves the transactin details.
         * @param onError <code>function(error :ErrorCode) :void</code>. Handles errors.
         */
        public static function openTransaction(transactionId :String,
                                               onProcessTransactionSuccess :Function,
                                               onError :Function) :void {
            const funcId :String = 'com.mobage.air.extension.bank.Debit.openTransaction';
            const sId    :String = Mobage.once(funcId, onProcessTransactionSuccess);
            const eId    :String = Mobage.once(funcId, onError);
            Extension.call(funcId, transactionId, sId, eId);
        }
    }
}
