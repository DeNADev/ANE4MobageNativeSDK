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
package com.mobage.air.social.kr
{
    import com.mobage.air.Extension;
    import com.mobage.air.Mobage;
    
    /**
     * Textdata is a interface for getting Textdata metadata on the platform. 
     */
    public final class Textdata {
        /**
         * Creates a new entry. If the entry data has an invalid word, the errorCode 400 will be returned.
         *
         * @param groupName groupName The group name of the Textdata group.
         * @param entry New Textdata entry.
         * @param onCreateEntrySuccess <code>function(entry :TextdataEntry) :void</code>
         * @param onError <code>function(error :ErrorCode) :void</code>
         */
        public static function createEntry(groupName :String,
                                           entry :TextdataEntry,
                                           onCreateEntrySuccess :Function,
                                           onError :Function) :void {
            const funcId :String = 'com.mobage.air.extension.social.kr.Textdata.createEntry';
            const sId :String = Mobage.once(funcId, onCreateEntrySuccess);
            const eId :String = Mobage.once(funcId, onError);
            Extension.call(funcId, groupName, entry, sId, eId);
        }
        
        /**
         * Retrieves the specified entries from the server.
         *
         * @param groupName groupName The group name of the Textdata group.
         * @param entry Array of String. The string array of the IDs.
         * @param onCreateEntrySuccess <code>function(entries :Array of TextdataEntry) :void</code>
         * @param onError <code>function(error :ErrorCode) :void</code>
         */
        public static function getEntries(groupName :String,
                                          entries :Array,
                                          onGetEntrySuccess :Function,
                                          onError :Function) :void {
            const funcId :String = 'com.mobage.air.extension.social.kr.Textdata.getEntries';
            const sId :String = Mobage.once(funcId, onGetEntrySuccess);
            const eId :String = Mobage.once(funcId, onError);
            Extension.call(funcId, groupName, entries, sId, eId);
        }
        
        /**
         * Updates an entry;
         *
         * @param groupName groupName The group name of the Textdata group.
         * @param id The ID of the Textdata object.
         * @param entry The Textdata entry to be updated.
         * @param onCreateEntrySuccess <code>function() :void</code>
         * @param onError <code>function(error :ErrorCode) :void</code>
         */
        public static function updateEntry(groupName :String,
                                           entryId :String,
                                           entry :TextdataEntry,
                                           onUpdateEntrySuccess :Function,
                                           onError :Function) :void {
            const funcId :String = 'com.mobage.air.extension.social.kr.Textdata.updateEntry';
            const sId :String = Mobage.once(funcId, onUpdateEntrySuccess);
            const eId :String = Mobage.once(funcId, onError);
            Extension.call(funcId, groupName, entryId, entry, sId, eId);
        }
        
        /**
         * Deletes an entry;
         *
         * @param groupName groupName The group name of the Textdata group.
         * @param id The ID of the Textdata object.
         * @param onCreateEntrySuccess <code>function() :void</code>
         * @param onError <code>function(error :ErrorCode) :void</code>
         */
        public static function deleteEntry(groupName :String,
                                           entryId :String,
                                           onUpdateEntrySuccess :Function,
                                           onError :Function) :void {
            const funcId :String = 'com.mobage.air.extension.social.kr.Textdata.deleteEntry';
            const sId :String = Mobage.once(funcId, onUpdateEntrySuccess);
            const eId :String = Mobage.once(funcId, onError);
            Extension.call(funcId, groupName, entryId, sId, eId);
        }
    }
}
