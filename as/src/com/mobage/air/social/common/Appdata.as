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
package com.mobage.air.social.common
{
    import com.mobage.air.Extension;
    import com.mobage.air.Mobage;
    
    /**
     * Mobage provides a common API for application data, which you may use for both Japan and the US.
     * <code>Appdata</code> is consistent with the Open Social <code>osapi.appdata</code> interface, and enables the application to store name/value pairs for application data.
     * To add or update application data, call <code>updateEntries()</code>. To retrieve entries, call <code>getEntries()</code>. To delete entries,
     * call <code>deleteEntries()</code>.
     *
     * <b>Note</b> that the number of keys is limited to 30 key/value pairs per user per game.
     * Maximum key name limited to 32 bytes. Maximum value limited to 1024 bytes.
     */
    public final class Appdata
    {
        /**
         * Deletes one or more key/value pairs.
         *
         * @param keys Array of String. Takes an array of key names. E.g., <code>['petName']</code>.
         * @param onDeleteEntriesSuccess function(entries :Object of String) :void. Called with an ojbect of the deleted entries.
         * @param onError function(error :ErrorCode) :void
         */
        public static function deleteEntries( keys :Array,
                                              onDeleteEntriesSuccess :Function,
                                              onError :Function ) :void {
            const funcId :String = 'com.mobage.air.extension.social.common.Appdata.deleteEntries';
            const sId :String = Mobage.once(funcId, onDeleteEntriesSuccess);
            const eId :String = Mobage.once(funcId, onError);
            Extension.call(funcId, keys, sId, eId);
        }
        
        /**
         * Retrieves a hash of one or more key/value pairs.
         * If the <code>keys</code> parameter is an empty array, <code>getEntries()</code>
         * returns all key/value pairs to the callback function.
         *
         * @param keys Array of String. E.g., ['key1', 'key2' ]. If null or an empty array, it returns all key/value pair entries.
         * @param onGetEntriesSuccess function(entries :Object of [String, String]) :void. Called with an object of key/value pairs.
         * @param onError             function(error :ErrorCode) :void.
         */
        public static function getEntries( keys :Array,
                                           onGetEntriesSuccess :Function,
                                           onError :Function ) :void {
            const funcId :String = 'com.mobage.air.extension.social.common.Appdata.getEntries';
            const sId :String = Mobage.once(funcId, onGetEntriesSuccess);
            const eId :String = Mobage.once(funcId, onError);
            Extension.call(funcId, keys, sId, eId);
        }
        
        /**
         * Inserts or updates <b>all</b> key/value pairs. It replaces the currently stored key/value pairs.
         *
         * @param entries Object of String. Takes an object of key/value pairs. E.g., <code>{"favoriteMovie": "Pulp Fiction", "petName": "Rover"}</code>.
         * @param onUpdateEntriesSuccess function(keys :Array of String) :void. Called with the updated entries.
         * @param onError function(error :ErrorCode) :void
         */
        public static function updateEntries( entries :Object,
                                              onUpdateEntriesSuccess :Function,
                                              onError :Function ) :void {
            const funcId :String = 'com.mobage.air.extension.social.common.Appdata.updateEntries';
            const sId :String = Mobage.once(funcId, onUpdateEntriesSuccess);
            const eId :String = Mobage.once(funcId, onError);
            Extension.call(funcId, kvToAssocArray(entries), sId, eId);
        }
        
        // Because ANE native code cannot get the keys of Object,
        // we have to convert Object (hash map) to an associative array.
        private static function kvToAssocArray(kv :Object) :Array {
            const aa :Array = [ ];
            for (var key :String in kv) {
                if (kv.hasOwnProperty(key)) {
                    aa.push([ key, kv[key] ]);
                }
            }
            return aa;
        }
    }
}
