package zvr.zvrComps.zvrTool.zvrWatcher 
{
	import flash.events.Event;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrWatcherItemEvent extends Event 
	{
		private var _watcher:ZvrWatchItem;
		
		public static const CHANGE:String = "change";
		
		public function ZvrWatcherItemEvent(type:String, watcher:ZvrWatchItem, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_watcher = watcher;
		} 
		
		public override function clone():Event 
		{ 
			return new ZvrWatcherItemEvent(type, _watcher, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ZvrWatcherItemEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get watcher():ZvrWatchItem 
		{
			return _watcher;
		}
		
	}
	
}