package zvr.zvrGUI.events 
{
	import flash.events.Event;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrScrollerEvent extends Event 
	{
		
		public function ZvrScrollerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ZvrScrollerEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ZvrScrollerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}