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
		
		public function call():void
		{
			_callback.apply( null, _args );
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