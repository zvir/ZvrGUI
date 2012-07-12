package zvr.zvrGUI.events 
{
	import flash.events.Event;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrListEvent extends Event 
	{
		
		public function ZvrListEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ZvrListEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("zvrListEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}