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
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	/** @private */
	public final class CallbackEvent extends Event {
		public var args :*;
		public function CallbackEvent(type :String,
									bubbles :Boolean,
									cancelable :Boolean,
									jsonString :String) {
			super(type, bubbles, cancelable);
			var items :Array = this.args = JSON.parse(jsonString) as Array;
			if (items === null) {
				return;
			}

			// construct objects from simple data structure
			for (var i :int = 0; i < items.length; ++i) {
				items[i] = decodeObject(items[i]);
			}
		}

		// it modifies the argument 'item'!!
		private function decodeObject(item :Object) :* {
			if (item.hasOwnProperty(".class")) {
				var klass :String = item[".class"] as String;
				delete item[".class"];
				
				var DataClass :Class = getDefinitionByName(klass) as Class;
				item = new DataClass(item);
			}
			else if (item is Array) {
				var a :Array = item as Array;
				for (var i :int = 0; i < a.length; ++i) {
					a[i] = decodeObject(a[i]);
				}
			}
			return item;
		}
	}
}
