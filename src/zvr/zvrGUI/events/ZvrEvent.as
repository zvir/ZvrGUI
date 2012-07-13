package zvr.zvrGUI.events 
{
	import flash.events.Event;
	import zvr.zvrGUI.core.ZvrComponent;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrEvent extends Event 
	{
		private var _component:ZvrComponent;
		
		public static const USER_INPUT:String = "userInput";
		
		public function ZvrEvent(type:String, component:ZvrComponent, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_component = component;
			
		} 
		
		public override function clone():Event 
		{ 
			return new ZvrEvent(type, _component, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ZvrEvent", "type", "component", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get component():ZvrComponent 
		{
			return _component;
		}
		
	}
	
}