package util
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class ButtonList extends Sprite {
		private var _buttonCount :int = 0;

		public function ButtonList(startPos :int = 0) {
			super();
			_buttonCount = startPos;
		}

		public function add(label :String, onClick :Function) :void {
			var b :Button = new Button(stage.stageWidth * 0.8, 54, 20, label, 32);
			
			b.addEventListener("click", function(event :Event) :void { onClick();});
			b.x = (stage.stageWidth  - b.width)  / 2;
			b.y = (_buttonCount++ * (b.height + 16)) + 40 /* margin-top */;
			addChild(b);
		}
	}
}