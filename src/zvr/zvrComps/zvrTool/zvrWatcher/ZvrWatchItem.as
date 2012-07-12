package zvr.zvrComps.zvrTool.zvrWatcher 
{
	import flash.events.EventDispatcher;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	[Event (name="change",    type="zvr.zvrComps.zvrTool.zvrWatcher.ZvrWatcherItemEvent")]
	 
	public class ZvrWatchItem extends EventDispatcher
	{
		
		public var sender:Object;
		public var name:String;
		private var _value:*;
		
		public function get value():* 
		{
			return _value;
		}
		
		public function set value(value:*):void 
		{
			if (value == null) return;
			_value = value;
			_dispach();
		}
		
		private function _dispach():void
		{
			dispatchEvent(new ZvrWatcherItemEvent(ZvrWatcherItemEvent.CHANGE, this));
		}
	}

}