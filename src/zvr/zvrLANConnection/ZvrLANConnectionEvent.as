package zvr.zvrLANConnection 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrLANConnectionEvent extends Event 
	{
		static public const CONNECTED	:String = "connected";
		static public const READY		:String = "ready";
		static public const MESSAGE		:String = "message";
		
		public var message:IZvrLANMessage
		
		public function ZvrLANConnectionEvent(type:String, message:IZvrLANMessage = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.message = message;
		} 
		
		public override function clone():Event 
		{ 
			return new ZvrLANConnectionEvent(type, message, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ZvrLANConnectionEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}