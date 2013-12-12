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
package com.mobage.air
{
    import flash.external.ExtensionContext;
    
    /**
     * @private interface to native extension
     */
    public final class Extension {
        
        private static const NAME :String = 'com.mobage.air.ANE4MobageSDK';
        private static var cx :ExtensionContext = null;
        
        public static function initialize() :void {
            if(cx === null) {
                cx = ExtensionContext.createExtensionContext(NAME, null);
                if(cx === null) {
                    var msg :String = "Failed to load " + NAME;
                    throw new Error(msg);
                }
            }	
        }
        
        public static function call(...args :Array) :* {
            return cx.call.apply(cx, args);
        }
        
        public static function addEventListener(event :String, handler :Function) :void {
            cx.addEventListener(event, handler);
        }
        
        public static function dispose() :void {
            cx.dispose(); // Clean Up resources
        }
    }
}
