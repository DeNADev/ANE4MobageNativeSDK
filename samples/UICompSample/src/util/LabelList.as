package util
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFieldType;
    import flash.text.TextFormat;
    
    public class LabelList extends Sprite {
        private var _nextHeight :int;
        private static var TEXTFIELD_WIDTH_RATIO :Number = 0.8;
        private static var TEXTFIELD_HEIGHT :int = 40;
        
        public function LabelList(startPos :int = 0) {
            super();
            _nextHeight =  -1 * (TEXTFIELD_HEIGHT * (startPos + 1) + 16);
        }
        
        public static var TEXT_FORMAT_WITHTE_BOLD :TextFormat = new TextFormat();
        TEXT_FORMAT_WITHTE_BOLD.align = "left";
        TEXT_FORMAT_WITHTE_BOLD.font = "Arial";
        TEXT_FORMAT_WITHTE_BOLD.size = 30;
        TEXT_FORMAT_WITHTE_BOLD.color = 0xFFFFFF;
        TEXT_FORMAT_WITHTE_BOLD.bold = true;
        
        public static var TEXT_FORMAT_BLACK_BOLD :TextFormat = new TextFormat();
        TEXT_FORMAT_BLACK_BOLD.align = "left";
        TEXT_FORMAT_BLACK_BOLD.font = "Arial";
        TEXT_FORMAT_BLACK_BOLD.size = 30;
        TEXT_FORMAT_BLACK_BOLD.color = 0x000000;
        TEXT_FORMAT_BLACK_BOLD.bold = true;
        
        
        public function add(labelText :String, isEditable :Boolean) :TextField {
            
            var textfield :TextField = new TextField();
            var y_offset :int = 0;
            if (isEditable) {
                textfield.defaultTextFormat = TEXT_FORMAT_BLACK_BOLD;
                textfield.border = false;
                textfield.selectable = true;
                textfield.type = TextFieldType.INPUT;
                textfield.background = true;
                
                y_offset = 10;
            } else {
                textfield.defaultTextFormat = TEXT_FORMAT_WITHTE_BOLD;
                textfield.type = TextFieldType.DYNAMIC;
            }
            
            textfield.width  = stage.stageWidth * TEXTFIELD_WIDTH_RATIO;
            textfield.height = TEXTFIELD_HEIGHT;
            
            textfield.text = labelText;
            
            textfield.x = (stage.stageWidth - textfield.width) / 2;
            
            _nextHeight -= y_offset;
            textfield.y = stage.stageHeight + _nextHeight;
            _nextHeight -= textfield.height; 
            
            addChild(textfield);
            
            return textfield;
        }
    }
}