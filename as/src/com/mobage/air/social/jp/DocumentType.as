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
package com.mobage.air.social.jp
{
    import com.mobage.air.util.Enum;
    
    public final class DocumentType extends Enum {
        public static const LEGAL :DocumentType             = new DocumentType("LEGAL");
        public static const AGREEMENT :DocumentType         = new DocumentType("AGREEMENT");
        public static const CONTACT :DocumentType           = new DocumentType("CONTACT");
        public static const TOS_LITE :DocumentType          = new DocumentType("TOS_LITE");
        public static const AGREEMENT_LITE :DocumentType    = new DocumentType("AGREEMENT_LITE");
        public static const SMS_VERIFICATION :DocumentType  = new DocumentType("SMS_VERIFICATION");
        
        public function DocumentType(name :String) {
            super(name);
        }
    }
}
