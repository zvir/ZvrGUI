package zvr.zvrGUI.events 
{
	import flash.events.Event;
	import zvr.zvrGUI.core.IZvrScroll;
	import zvr.zvrGUI.core.ZvrScroll;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrScrollEvent extends Event 
	{
		
		public static const MIN_CHANGED				:String = "minChanged";
		public static const MAX_CHANGED				:String = "maxChanged";
		public static const RANGE_CHANGED			:String = "rangeChanged";
		public static const DYNAMIC_RANGE_CHANGED	:String = "dynamicRangeChanged";
		public static const POSITION_CHANGED		:String = "positionChanged";
		public static const STATE_CHANGE			:String = "scrollStateChange";
		
		private var _scroll:IZvrScroll;
		
		public function ZvrScrollEvent(type:String, scroll:IZvrScroll, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);	
			_scroll = scroll;
		} 
		
		public override function clone():Event 
		{ 
			return new ZvrScrollEvent(type, _scroll, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ZvrScrollEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get scroll():IZvrScroll 
		{
			return _scroll;
		}
		
	}
	
}