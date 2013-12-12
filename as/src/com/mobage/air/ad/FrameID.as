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
package com.mobage.air.ad
{
	import com.mobage.air.util.Enum;
	
	public class FrameID extends Enum
	{
		public static const A : FrameID = new FrameID("A");
		public static const B : FrameID = new FrameID("B");
		public static const C : FrameID = new FrameID("C");
		public static const D : FrameID = new FrameID("D");
		public static const E : FrameID = new FrameID("E");
		public static const F : FrameID = new FrameID("F");
		public static const G : FrameID = new FrameID("G");
		public static const H : FrameID = new FrameID("H");
		public static const I : FrameID = new FrameID("I");
		public static const J : FrameID = new FrameID("J");
		public static const K : FrameID = new FrameID("K");
		public static const L : FrameID = new FrameID("L");
		public static const M : FrameID = new FrameID("M");
		public static const N : FrameID = new FrameID("N");
		public static const O : FrameID = new FrameID("O");
		public static const P : FrameID = new FrameID("P");
		public static const Q : FrameID = new FrameID("Q");
		public static const R : FrameID = new FrameID("R");
		public static const S : FrameID = new FrameID("S");
		public static const T : FrameID = new FrameID("T");
		public static const U : FrameID = new FrameID("U");
		public static const V : FrameID = new FrameID("V");
		public static const W : FrameID = new FrameID("W");
		public static const X : FrameID = new FrameID("X");
		public static const Y : FrameID = new FrameID("Y");
		public static const Z : FrameID = new FrameID("Z");
		
		public function FrameID(name :String)
		{
			super(name.toUpperCase());
		}
	}
}
