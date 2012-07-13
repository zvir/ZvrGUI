package zvr.zvrKeyboard 
{
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrKeyShortcut 
	{
		
		private var _sequence:Array;
		private var _callback:ZvrCallback;
		
		public function ZvrKeyShortcut(sequence:Array, callback:Function) 
		{
			_callback = new ZvrCallback(callback);
			_sequence = sequence;
			
			for (var i:int = 0; i < _sequence.length; i++) 
			{
				var k:ZvrKey = _sequence[i];
				k.addPressedCallback(validate);
			}
			
		}
		
		private function validate():void 
		{
			for (var i:int = 0; i < _sequence.length; i++) 
			{
				var k:ZvrKey = _sequence[i];
				if (!k.pressed) return;
			}
			_callback.call();
		}
		
		public function destroy():void
		{
			for (var i:int = 0; i < _sequence.length; i++) 
			{
				var k:ZvrKey = _sequence[i];
				k.removePressedCallback(validate);
			}
			_sequence = null;
			_callback = null;
		}
		
		public function get callback():ZvrCallback 
		{
			return _callback;
		}
		
		public function get sequence():Array 
		{
			return _sequence;
		}
		
		/**
		 * 
		 * @param  value true or false if callback function should be trigered olny on detect shortcut or durring pressing olso.
		 * @return ZvrKeyShortcut instance
		 */
		
		public function setCallbackOnPressing(value:Boolean):ZvrKeyShortcut
		{
			if (value)
			{
				for (var i:int = 0; i < _sequence.length; i++) 
				{
					var k:ZvrKey = _sequence[i];
					k.addPressingCallback(validate);
				}
			}
			else
			{
				for (i = 0; i < _sequence.length; i++) 
				{
					k = _sequence[i];
					k.removePressingCallback(validate);
				}
			}
			return this;
		}
		
	}

}