package util
{
	// simple button for testing
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	
	public class Button extends Sprite {
		private static const mono:ColorMatrixFilter = new ColorMatrixFilter([
			1 / 3, 1 / 3, 1 / 3, 0, 10,
			1 / 3, 1 / 3, 1 / 3, 0, 10,
			1 / 3, 1 / 3, 1 / 3, 0, 10,
			0,     0,     0, 1, 0
		]);
		
		private var _hover :Boolean = false;
		public function get hover() :Boolean {
			return _hover;
		}
		public function set hover(value:Boolean) :void {
			if(_hover != value){
				_hover = value;
				filters = (_hover ? null : [mono]);
			}
		}
		
		public function Button(W :Number, H :Number, R :Number, label:String = "", size:int = 11) {
			var matrix :Matrix = new Matrix();
			matrix.createGradientBox(W, H, Math.PI / 2);
			
			var bg :Sprite = new Sprite();
			
			bg.graphics.beginGradientFill("linear", [0xDDE9F4, 0xD5E4F1, 0xBAD2E8], [1, 1, 1],
				[0, 120, 136], matrix);
			bg.graphics.drawRoundRect(0, 0, W, H, R, R);
			bg.graphics.endFill();
			
			bg.filters = [new GlowFilter(0xFFFFBE, .5, 10, 10, 2, 1, true)];
			addChild(bg);
			
			var line :Sprite = new Sprite();
			line.graphics.lineStyle(3, 0xBAD2E8);
			line.graphics.drawRoundRect(0, 0, W, H, R, R);
			addChild(line);
			
			filters = [mono];
			buttonMode = true;
			mouseChildren = false;
			
			if (label != ""){
				var textField :TextField = new TextField();
				textField.selectable = false;
				textField.autoSize = "left";
				textField.htmlText = <font size={size} color="#6B8399">{label}</font>.toXMLString();
				textField.x = (W - textField.width) / 2;
				textField.y = (H - textField.height) / 2;
				addChild(textField);
			}
			
			addEventListener("rollOver", buttonRollOver);
			addEventListener("rollOut", buttonRollOut);
			addEventListener("removed", function(event:Event):void{
				removeEventListener("rollOver", buttonRollOver);
				removeEventListener("rollOut", buttonRollOut);
				removeEventListener("removed", arguments.callee);
			});
		}
		
		protected function buttonRollOver(event:Event) :void {
			hover = true;
		}
		
		protected function buttonRollOut(event:Event) :void {
			hover = false;
		}
	}
}