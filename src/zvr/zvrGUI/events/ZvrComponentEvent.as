package zvr.zvrGUI.events 
{
	import flash.events.Event;
	import flash.geom.Point;

	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.utils.Counter;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrComponentEvent extends Event 
	{
		
		public static const MOVE			:String = "move";
		public static const RESIZE			:String = "resize";
		public static const ADDED			:String = "componentAdded";
		public static const REMOVED			:String = "componentRemoved";
		public static const CREATED			:String = "created";
		public static const UPDATED			:String = "updated";
		public static const PRESENTS_CHANGE	:String = "presentsChange";
		
		
		//public static const :String = "";
		
		private var _component:IZvrComponent;
		private var _delta:Point;
		
		public function ZvrComponentEvent(type:String, component:IZvrComponent, delta:Point = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{ 
			super(type, bubbles, cancelable);
			_delta = delta;
			_component = component;
		} 
		
		public function get component():IZvrComponent {	return _component;	}
		
		public function get delta():Point 
		{
			return _delta;
		}
		
		public override function clone():Event 
		{ 
			return new ZvrComponentEvent(type, _component, _delta, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("zvrComponentEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		
		
	}
	
}