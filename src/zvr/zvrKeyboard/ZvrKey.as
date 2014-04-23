package zvr.zvrKeyboard 
{
	import flash.utils.Dictionary;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrKey 
	{
		private var _code:int;
		private var _pressed:Boolean;
		
		private var _releasedCallbacks:Dictionary = new Dictionary();
		private var _pressedCallbacks:Dictionary = new Dictionary();
		private var _pressingCallbacks:Dictionary = new Dictionary();
		
		public function ZvrKey(code:int, registration:Function) 
		{
			_code = code;
			registration(this, setPressed);
		}
		
		private function setPressed(value:Boolean):int 
		{
			var c:Boolean = value && !_pressed
			
			_pressed = value;
			
			if (c) {
				callPressed();
				return 1;
			}
			else if (_pressed)
			{
				callPressing();
				return 2;
			}
			if (!_pressed)
			{
				callReleased();
				return 3;
			}

			return 0;
		}
		
		public function get code():int 
		{
			return _code;
		}
		
		public function get pressed():Boolean 
		{
			return _pressed;
		}
		
		public function addPressedCallback(callback:Function):ZvrCallback
		{
			return addCallBack(_pressedCallbacks, callback);
		}
		
		public function addReleasedCallback(callback:Function):ZvrCallback
		{
			return addCallBack(_releasedCallbacks, callback);
		}
		
		public function addPressingCallback(callback:Function):ZvrCallback
		{
			return addCallBack(_pressingCallbacks, callback);
		}
		
		public function removePressedCallback(callback:Function):void
		{
			removeCallBack(_pressedCallbacks, callback);
		}
		
		public function removeReleasedCallback(callback:Function):void
		{
			removeCallBack(_releasedCallbacks, callback);
		}
		
		public function removePressingCallback(callback:Function):void
		{
			removeCallBack(_pressingCallbacks, callback);
		}
		
		
		private function addCallBack(holder:Dictionary, callback:Function):ZvrCallback
		{
			if (holder[callback] == undefined)
			{
				var cl:ZvrCallback = new ZvrCallback(callback);
				holder[callback] = cl;
				return cl;
			}
			else
			{
				return holder[callback];
			}
		}
		
		private function removeCallBack(holder:Dictionary, callback:Function):void
		{
			if (holder[callback] != undefined)
			{
				holder[callback].destroy();
				holder[callback] = undefined;
				delete holder[callback];
			}
		}
		
		private function callPressed():void
		{
			call(_pressedCallbacks);
		}
		
		private function callReleased():void
		{
			call(_releasedCallbacks);
		}
		
		private function callPressing():void
		{
			call(_pressingCallbacks);
		}
		
		private function call(holder:Dictionary):void
		{
			var a:Array = new Array();
			for each (var callback:ZvrCallback in holder) 
			{
				a.push(callback);
			}
			
			for (var i:int = 0; i < a.length; i++) 
			{
				a[i].call();
			}
			
		}
		
	}

}