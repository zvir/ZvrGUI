package zvr.zvrKeyboard 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrInputTextField 
	{
		
		private static const _textField:TextField = getTextField();
		
		private static var _stage:Stage;
		static private var _active:Boolean;
		static private var _textChaged:Boolean;
		static private const _onChange:Signal = new Signal(ZvrInputSignal);
		
		
		private static function getTextField():TextField
		{
			var tf:TextField;
			tf = new TextField();
			tf.type = TextFieldType.INPUT;
			tf.multiline = true;
			tf.visible = false;
			/*tf.visible = true;
			tf.border = true;
			tf.background = true;*/
			/*tf.x = 0;
			tf.y = 300;*/
			
			/*tf.width = 500;
			tf.height = 200;
			
			tf.x = 300;
			tf.y = 300;*/
			
			return tf;
		}
		
		static private function textChange(e:Event):void 
		{
			_textChaged = true;
		}
		
		static private function focusChange(e:FocusEvent):void 
		{
			
			if (_active && _stage.focus != _textField)
			{
				_stage.focus = _textField;
			}
		}
		
		static private function exitFrame(e:Event):void 
		{
			
			if (!_textChaged) return;
			
			
			trace("_textChaged", _textField.selectionBeginIndex, _textField.selectionEndIndex);
			
			_onChange.dispatch(new ZvrInputSignal(_textField.text, _textField.selectionBeginIndex, _textField.selectionEndIndex));
			
			_textChaged = false;
			
			
		}
		
		static private function onTxtFocusIn(e:FocusEvent):void 
		{
			_textField.removeEventListener(FocusEvent.FOCUS_IN, onTxtFocusIn);
			_textField.requestSoftKeyboard();
		}
		
		public static function begin(stage:Stage, text:String, selectionBegin:int, selectionEnd:int, requestKeyboard:Boolean = false):void
		{
			
			trace("begin", text, selectionBegin, selectionEnd, requestKeyboard);
			
			//requestKeyboard = false;
			
			if (_active) 
			{
				_textField.text = text;
				_textField.setSelection(selectionBegin, selectionEnd);
				return;
			}
			
			_active = true;
			
			_textField.needsSoftKeyboard = requestKeyboard;
			
			if (requestKeyboard) 
			{
				_textField.addEventListener(FocusEvent.FOCUS_IN, onTxtFocusIn);
			}
			
			_stage = stage;
			_stage.addChild(_textField);
			
			_textField.text = text;
			
			_textField.setSelection(selectionBegin, selectionEnd);
			
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, textChange);
			_stage.addEventListener(KeyboardEvent.KEY_UP, textChange);
			
			_stage.addEventListener(FocusEvent.FOCUS_OUT, focusChange);
			_stage.addEventListener(FocusEvent.FOCUS_IN, focusChange);
			
			_textField.addEventListener(Event.CHANGE, textChange);
			_textField.addEventListener(TextEvent.TEXT_INPUT, textChange);
			
			_stage.addEventListener(Event.EXIT_FRAME, exitFrame);
			
			_stage.focus = _textField;
		}
		
		public static function end():void
		{
			trace("end");
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, textChange);
			_stage.removeEventListener(KeyboardEvent.KEY_UP, textChange);
			
			_stage.removeEventListener(FocusEvent.FOCUS_OUT, focusChange);
			_stage.removeEventListener(FocusEvent.FOCUS_IN, focusChange);
			
			_textField.removeEventListener(FocusEvent.FOCUS_IN, onTxtFocusIn);
			
			_textField.removeEventListener(Event.CHANGE, textChange);
			_textField.removeEventListener(TextEvent.TEXT_INPUT, textChange);
			
			_stage.removeEventListener(Event.EXIT_FRAME, exitFrame);
			
			_stage.removeChild(_textField);
			
			_active = false;
		}
		
		public static function setSelection(selectionBegin:int, selectionEnd:int):void
		{
			
			trace("setSelection", selectionBegin, selectionEnd);
			
			_textField.setSelection(selectionBegin, selectionEnd);
			_textChaged = true;
		}
		
		static public function get onChange():Signal 
		{
			return _onChange;
		}
		
		static public function get maxChars():int 
		{
			return _textField.maxChars;
		}
		
		static public function set maxChars(value:int):void 
		{
			_textField.maxChars = value;
		}
		
		static public function get multiline():Boolean 
		{
			return _textField.multiline;
		}
		
		static public function set multiline(value:Boolean):void 
		{
			_textField.multiline = value;
		}
		
	}

}