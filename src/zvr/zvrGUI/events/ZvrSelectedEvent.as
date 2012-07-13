package zvr.zvrGUI.events 
{
	import flash.events.Event;
	import zvr.zvrGUI.core.ZvrComponent;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrSelectedEvent extends Event 
	{
		private var _component:ZvrComponent;
		private var _selected:Boolean;
		
		public static const SELECTED_CHANGE:String = "selectedChange";
		
		public function ZvrSelectedEvent(type:String, component:ZvrComponent, selected:Boolean, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
			_selected = selected;
			_component = component;
		} 
		
		public override function clone():Event 
		{ 
			return new ZvrSelectedEvent(type, _component, _selected, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ZvrSelectedEvent", "type", "component", "selected", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get component():ZvrComponent 
		{
			return _component;
		}
		
		public function get selected():Boolean 
		{
			return _selected;
		}
		
	}
	
}