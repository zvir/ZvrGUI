package zvr.zvrGUI.events 
{
	import flash.events.Event;
	import flash.geom.Point;
	import zvr.zvrGUI.behaviors.IZvrDragable;
	import zvr.zvrGUI.behaviors.ZvrDragable;
	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.core.ZvrComponent;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrDragBehaviorEvent extends Event 
	{
		
		public static const DRAG 			:String = "drag";
		public static const DRAGGING 		:String = "dragging";
		public static const START_DRAG 		:String = "startDrag";
		public static const STOP_DRAG 		:String = "stopDrag";
		
		private var _behavior:IZvrDragable;
		private var _component:IZvrComponent;
		private var _delta:Point;

		
		public function ZvrDragBehaviorEvent(type:String, behavior:IZvrDragable, component:IZvrComponent, delta:Point = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{ 
			super(type, bubbles, cancelable);
			_delta = delta;
			_component = component;
			_behavior = behavior;
		} 
		
		public override function clone():Event 
		{ 
			return new ZvrDragBehaviorEvent(type, _behavior, _component, _delta, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ZvrDragBehaviorEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get behavior():IZvrDragable 
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