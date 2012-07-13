package zvr.zvrKeyboard 
{
	import flash.events.Event;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrKeyboardEvent extends Event 
	{
		
		public function ZvrKeyboardEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new ZvrKeyboardEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ZvrKeyboardEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}