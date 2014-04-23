package zvr.zvrEventer 
{
	/**
	 * ...
	 * @author Zvir
	 */
	internal class ZvrListener 
	{
		private var _type:String;
		private var _listener:Function;
		private var _once:Boolean;
		
		public function ZvrListener(type:String, listener:Function, once:Boolean) 
		{
			_once = once;
			_listener = listener;
			_type = type;
			
		}
		
	}

}