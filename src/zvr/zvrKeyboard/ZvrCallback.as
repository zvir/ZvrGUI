package zvr.zvrKeyboard 
{
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrCallback 
	{
		private var _callback:Function;
		private var _args:Array;
		
		public function ZvrCallback(callback:Function, ... args) 
		{
			_callback = callback;
			_args = args;
		}
		
		public function setArgs(... args):ZvrCallback
		{
			_args = args;
			return this;
		}
		
		public function call(... rest):void
		{
			var a:Array;
			if (rest && rest.length > 0) a = rest.concat(_args); else a = _args;
			
			_callback.apply( null, a );
		}
		
		public function destroy():void
		{
			_args = null;
			_callback = null;
		}
		
		public function get callback():Function 
		{
			return _callback;
		}
	}

}