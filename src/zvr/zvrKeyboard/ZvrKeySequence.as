package zvr.zvrKeyboard 
{
	import flash.utils.getTimer;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrKeySequence 
	{
		
		private var _sequence:Array;
		private var _counter:int = 0;
		private var _callback:ZvrCallback;
		private var _timeOut:uint = 0;
		private var _lastValidation:uint = 0;
		
		public function ZvrKeySequence(sequence:Array, callback:Function) 
		{
			_callback = new ZvrCallback(callback);
			_sequence = sequence;
		}
		
		public function validate(k:ZvrKey):Boolean
		{
			if (_timeOut != 0 && _counter > 0 && getTimer() - _lastValidation > _timeOut) _counter = 0;
			
			_lastValidation = getTimer();
			
			if (_sequence[_counter] == k)
			{
				if (_sequence.length == _counter +1)
				{
					_counter = 0;
					return true;
				}
				else
				{
					_counter++;
					return false;
				}
			}
			else
			{
				_counter = 0;
				return false;
			}
		}
		
		public function setTimeOut(value:uint):ZvrKeySequence
		{
			_timeOut = value
			return this;
		}
		
		public function get callback():ZvrCallback 
		{
			return _callback;
		}
		
		public function get sequence():Array 
		{
			return _sequence;
		}
		
	}

}