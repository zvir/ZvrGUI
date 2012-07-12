package zvr.zvrComps.zvrTool.zvrTracer 
{
	import flash.events.Event;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrTracerMessageEvent extends Event 
	{
		private var _message:ZvrTraceMessage;
		
		public static const CHANGE:String = "change";
		
		public function ZvrTracerMessageEvent(type:String, message:ZvrTraceMessage, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_message = message;
		} 
		
		public override function clone():Event 
		{ 
			return new ZvrTracerMessageEvent(type, _message, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ZvrTracerMessageEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get message():ZvrTraceMessage 
		{
			return _message;
		}
		
	}
	
}