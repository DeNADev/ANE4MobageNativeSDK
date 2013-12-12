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
     * Provides an interface to retrieve items from inventory. The Mobage platform
     * server is responsible for managing a game's item inventory.
     */
    public final class Inventory {
        /**
         * Retrieves the item identified by its product ID from inventory on the Mobage platform server.
         *
         * @param itemId The product ID for the item.
         * @param onGetItemSuccess <code>function(itemData :ItemData) :void</code>. Retrieves the item from inventory on the Mobage platform server.
         * @param onError <code>function(error :ErrorCode) :void</code>. Handles errors.
         */
        public static function getItem( itemId :String,
                                        onGetItemSuccess :Function,
                                        onError :Function) :void {
            const funcId :String = 'com.mobage.air.extension.bank.Inventory.getItem';
            const sId    :String = Mobage.once(funcId, onGetItemSuccess);
            const eId    :String = Mobage.once(funcId, onError);
            Extension.call(funcId, itemId, sId, eId);
        }
    }
}
