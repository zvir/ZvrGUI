package zvr.zvrGUI.events 
{
	import flash.events.Event;
	import flash.geom.Point;
	import zvr.zvrGUI.behaviors.ZvrResizable;
	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.core.ZvrComponent;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrResizeBehaviorEvent extends Event 
	{

		public static const RESIZE 			:String = "resize";
		public static const RESIZING 		:String = "resizing";
		public static const START_RESIZE 	:String = "startDrag";
		public static const STOP_RESIZE 	:String = "startResize";
		
		private var _behavior:ZvrResizable;
		private var _component:IZvrComponent;
		private var _delta:Point;
		
		public function ZvrResizeBehaviorEvent(type:String, behavior:ZvrResizable, component:IZvrComponent, delta:Point = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_delta = delta;
			_component = component;
			_behavior = behavior;
		} 
		
		public override function clone():Event 
		{ 
			return new ZvrResizeBehaviorEvent(type, _behavior, _component, _delta, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ZvrResizeBehaviorEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get behavior():ZvrResizable 
		{
			return _behavior;
		}
		
		public function get component():IZvrComponent 
		{
			return _component;
		}
		
		public function get delta():Point 
		{
			return _delta;
		}
		
		
	}
	
}