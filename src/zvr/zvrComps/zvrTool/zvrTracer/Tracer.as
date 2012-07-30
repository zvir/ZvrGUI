package zvr.zvrComps.zvrTool.zvrTracer 
{
	import flash.utils.getTimer;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class Tracer
	{
		
		public static const emptyTracerItem:ZvrTraceMessage = new ZvrTraceMessage();
		
		private static var _tracer:ZvrTracer;
		public static var notifyCounter:int = 0;
		public static var notifyLastTime:Number = 0;
		public static var messages:Object = new Object();
		public static var vec:Array = new Array;
		
		public static function trc(id:int, key:String, senderType:String, senderName:String, time:int, timeDelta:int, message:String, values:Array = null):ZvrTraceMessage
		{
			if (!_tracer) return null;
			
			var m:ZvrTraceMessage;
			var newMessage:Boolean = true;
			
			if (messages[key] != undefined) 
			{
				m = messages[key];
				newMessage = false;
			}
			else
			{
				m = new ZvrTraceMessage();
				m.setContent(id, key, senderType, senderName, time, timeDelta, message, values);
				vec.push(m);
			}
			
			if (newMessage) 
			{
				if (tracer) tracer.addMessage(m);
			}
			
			if (key != "") 
			{
				messages[key] = m;
				m.setContent(id, m.key, senderType, senderName, time, timeDelta, message, values);
				if (tracer) tracer.itemUpdated(m);
			}
			
			Tracer.notifyCounter++;
			Tracer.notifyLastTime = getTimer();
			
			return m;
		}
		
		static public function get tracer():ZvrTracer 
		{
			return _tracer;
		}
		
		static public function set tracer(value:ZvrTracer):void 
		{
			_tracer = value;
			for (var i:int = 0; i < vec.length; i++) 
			{
				_tracer.addMessage(vec[i]);
			}
		}
	}
}