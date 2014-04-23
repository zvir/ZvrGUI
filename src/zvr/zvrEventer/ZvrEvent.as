package zvr.zvrEventer 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrEvent 
	{
		
		internal var target:Object;
		private var _canceled:Boolean;
		internal var phase:String;
		public var type:String;
		
		public function ZvrEvent() 
		{
			
		}
		
		internal function exec():void
		{
			dispatch();
		}
		
		public function cancel():void
		{
			
		}
		
		public function dispatch():void 
		{
			
		}
		
		public function get phase():String
		{
			return phase;
		}
		
		public function get canceled():Boolean 
		{
			return _canceled;
		}
		
	}

}