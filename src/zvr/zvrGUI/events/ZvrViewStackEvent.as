package zvr.zvrGUI.events 
{
	import flash.events.Event;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrViewStack;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrViewStackEvent extends Event 
	{
		private var _stack:ZvrViewStack;
		private var _item:ZvrComponent;
		
		public static const VIEW_ADDED				:String = "viewAdded";
		public static const VIEW_REMOVED			:String = "viewRemoved";
		public static const CURRENT_VIEW_CHANGED	:String = "currentCiewChanged";
		public static const VIEW_INDEX_CHANGED		:String = "viewIndexChanged";  
		
		
		public function ZvrViewStackEvent(type:String, stack:ZvrViewStack, item:ZvrComponent, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_item = item;
			_stack = stack;
		} 
		
		public override function clone():Event 
		{ 
			return new ZvrViewStackEvent(type, _stack, _item, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ZvrViewStackEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get stack():ZvrViewStack 
		{
			return _stack;
		}
		
		public function get item():ZvrComponent 
		{
			return _item;
		}
		
	}
	
}

	


	