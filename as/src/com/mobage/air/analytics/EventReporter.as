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
package com.mobage.air.analytics
{
    import com.mobage.air.Extension;
    
    /** @private for testing */
    public final class EventReporter {
        /**
         * Send GameEvent report <b>all</b> key/value pairs.
         *
         * @param eventName of String. Only Uppercase Alphanumeric characters.
         * @param payload Object of String. Takes an object of key/value pairs. E.g., <code>{"key": "value", "tab": "\t"}</code>.
         * @param playerState Object of String. Takes an object of key/value pairs. E.g., <code>{"level": "3", "point": "10"}</code>.
         */
        public static function report(eventName :String, payload :Object, playerState :Object) :void {
            const funcId :String = 'com.mobage.air.extension.analytics.EventReporter.report';
            
            Extension.call(funcId, eventName, kvToAssocArray(payload), kvToAssocArray(playerState));
        }
        
        // Because ANE native code cannot get the keys of Object,
        // we have to convert Object (hash map) to an associative array.
        private static function kvToAssocArray(kv :Object) :Array {
            const aa :Array = [ ];
            for (var key :String in kv) {
                if (kv.hasOwnProperty(key)) {
                    aa.push( [ key, kv[key] ] );
                }
            }
            return aa;
        }
    }
}