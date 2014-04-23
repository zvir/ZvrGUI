package zvr 
{
	import flash.events.EventDispatcher;
	import zvr.zvrKeyboard.ZvrKey;
	import zvr.zvrKeyboard.ZvrKeyboard;
	/**
	 * ...
	 * @author Zvir
	 */
	
	[Event(name = "textChange", 		type="zvr.ZvrVirtualTextfieldEvent")]
	[Event(name = "carretIndexChage", 	type="zvr.ZvrVirtualTextfieldEvent")]
	[Event(name = "activeChange", 		type="zvr.ZvrVirtualTextfieldEvent")]
	
	public class ZvrVirtualTextfield extends EventDispatcher
	{
		
		private var _text:String = "";
		
		private var _carretIndex:int;
		private var _active:Boolean;
		
		public var maxChars:int = int.MAX_VALUE;
		
		
		public function ZvrVirtualTextfield() 
		{
			
		}
		
		public function activate():void
		{
			_active = true;
			
			ZvrKeyboard.addPressedCallback(keyPressed);
			ZvrKeyboard.addPressingCallback(keyPressed);
			
			dispatchEvent(new ZvrVirtualTextfieldEvent(ZvrVirtualTextfieldEvent.ACTIVE_CHANGE, this));
			
		}
		
		public function deactivate():void
		{
			_active = false;
			
			ZvrKeyboard.removePressedCallback(keyPressed);
			ZvrKeyboard.removePressingCallback(keyPressed);
			
			dispatchEvent(new ZvrVirtualTextfieldEvent(ZvrVirtualTextfieldEvent.ACTIVE_CHANGE, this));
			
		}
		
		public function setText(value:String):void 
		{
			_text = value;
		}
		
		public function setCarretIndex(v:int):void 
		{
			if (v < 0) v = 0;
			if (v > _text.length) v = _text.length;
			
			if (v != _carretIndex)
			{
				_carretIndex = v;
				dispatchEvent(new ZvrVirtualTextfieldEvent(ZvrVirtualTextfieldEvent.CARRET_INDEX_CHAGE, this));
			}
			
		}
		
		private function keyPressed(k:ZvrKey):void 
		{
			var c:String = String.fromCharCode(k.code);
			
			var r:RegExp = /\w/g;
			var r2:RegExp = /\s/g;
			
			var lastLetter:String = _text.slice(_carretIndex - 1, _carretIndex);
			var lastLetterWhite:Boolean  = lastLetter.match(r2).length > 0;
			
			if (lastLetterWhite && k.code == 32) return;
			
			var ok:Boolean = c.match(r).length > 0 || k.code == 32;
			
			if (ok)
			{
				if (ZvrKeyboard.capslosck == ZvrKeyboard.SHIFT.pressed) c = c.toLowerCase();
				
				var s1:String = _text.slice(0, _carretIndex);
				var s2:String = _text.slice(_carretIndex);
				
				if (_text.length == maxChars) return;
				
				_text = s1 + c +s2;
				_carretIndex++;
				dispatchEvent(new ZvrVirtualTextfieldEvent(ZvrVirtualTextfieldEvent.TEXT_CHANGE, this));
				dispatchEvent(new ZvrVirtualTextfieldEvent(ZvrVirtualTextfieldEvent.CARRET_INDEX_CHAGE, this));
			}
			
			if (k.code == 8 && _carretIndex > 0)
			{
				_text = _text.slice(0, _carretIndex - 1) + _text.slice(_carretIndex);
				_carretIndex --;
				if (_carretIndex < 0) _carretIndex = 0;
				dispatchEvent(new ZvrVirtualTextfieldEvent(ZvrVirtualTextfieldEvent.TEXT_CHANGE, this));
				dispatchEvent(new ZvrVirtualTextfieldEvent(ZvrVirtualTextfieldEvent.CARRET_INDEX_CHAGE, this));
			}
			else if (k.code == 46 && _carretIndex < _text.length)
			{
				_text = _text.slice(0, _carretIndex) + _text.slice(_carretIndex + 1);
				///_carretIndex --;
				if (_carretIndex < 0) _carretIndex = 0;
				dispatchEvent(new ZvrVirtualTextfieldEvent(ZvrVirtualTextfieldEvent.TEXT_CHANGE, this));
				//dispatchEvent(new ZvrVirtualTextfieldEvent(ZvrVirtualTextfieldEvent.CARRET_INDEX_CHAGE, this));
			}
			else if (k.code == 39)
			{
				_carretIndex ++;
				if (_carretIndex > _text.length) _carretIndex = _text.length;
				dispatchEvent(new ZvrVirtualTextfieldEvent(ZvrVirtualTextfieldEvent.CARRET_INDEX_CHAGE, this));
			}
			else if (k.code == 37)
			{
				_carretIndex --;
				if (_carretIndex < 0) _carretIndex = 0;
				dispatchEvent(new ZvrVirtualTextfieldEvent(ZvrVirtualTextfieldEvent.CARRET_INDEX_CHAGE, this));
			}
			
		}
		
		public function get text():String 
		{
			return _text;
		}
		
		public function get carretIndex():int 
		{
			return _carretIndex;
		}
		
		public function get active():Boolean 
		{
			return _active;
		}
		
	
	}

}