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
     * Gets a verifier code.
     * Games call <code>Auth.authorizeToken()</code> if the game server is using the Mobage REST API.
     * For more information, refer Mobage REST API section of the developer's guide.
     */
    public final class Auth {
        /**
         * Authorizes a temporary credential and returns a verification code.
         *
         * @param token The temporary credential identifier.
         * @param onAutorizeTokenSuccess <code>function(verifier :String) :void</code> Handles the verification code.
         * @param onError <code>function(error :ErrorCode) :void</code> Handles errors.
         */
        public static function authorizeToken( token :String,
                                               onAuthorizeTokenSuccess:Function,
                                               onError :Function ) :void {
            const funcId :String = 'com.mobage.air.extension.social.common.Auth.authorizeToken';
            const sId :String = Mobage.once(funcId, onAuthorizeTokenSuccess);
            const eId :String = Mobage.once(funcId, onError);
            Extension.call(funcId, token, sId, eId);
        }
    }
}
