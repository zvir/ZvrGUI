package zvr.zvrGUI.events 
{
	import flash.events.Event;
	import zvr.zvrGUI.core.ZvrWindow;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrWindowEvent extends Event 
	{
		
		public static const CLOSE 			:String = "close";
		public static const MINIMALIZE 		:String = "minimalize";
		public static const RESTORE 		:String = "restore";
		public static const MAXIMILIZE 		:String = "maximilize";
		
		private var _window:ZvrWindow;
		
		public function ZvrWindowEvent(type:String, window:ZvrWindow, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_window = window;
		} 
		
		public override function clone():Event 
		{ 
			return new ZvrWindowEvent(type, _window, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ZvrWindowEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get window():ZvrWindow 
		{
			return _window;
		}
		
	}
	
}