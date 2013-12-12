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
package com.mobage.air.util
{
	import com.mobage.air.Extension;

	/** @private */
	public final class Log {
		private static const printLog :String = 'com.mobage.air.extension.Log.print';

		public static function v(arg :String) :void {
			trace('v: ', arg);
			Extension.call(printLog, "v", arg);
		}
		public static function i(arg :String) :void {
			trace('i: ', arg);
			Extension.call(printLog, "i", arg);
		}
		public static function d(arg :String) :void {
			trace('d: ', arg);
			Extension.call(printLog, "d", arg);
		}
		public static function w(arg :String) :void {
			trace('w: ', arg);
			Extension.call(printLog, "w", arg);
		}
		public static function e(arg :String) :void {
			trace('e: ', arg);
			Extension.call(printLog, "e", arg);
		}
	}
}
