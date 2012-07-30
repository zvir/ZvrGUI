package zvr.zvrComps.zvrTool.zvrTracer 
{
	import flash.events.EventDispatcher;
	import zvr.zvrTools.ZvrTime;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	[Event (name="change",    type="zvr.zvrComps.zvrTool.zvrTracer.ZvrTracerMessageEvent")]
	 
	public class ZvrTraceMessage extends EventDispatcher
	{
		
		private var _id				:int;
		private var _key			:String;
		private var _senderType		:String;
		private var _senderName		:String;
		private var _time			:int;
		private var _timeDelta		:int;
		private var _message		:String;
		private var _values			:Array;
		
		public function ZvrTraceMessage()
		{
			
		}
		
		public function setContent(id:int, key:String, senderType:String, senderName:String, time:int, timeDelta:int, message:String, values:Array = null):void
		{
			_id				= id;		
			_key		    = key;
			_senderType	    = senderType;
			_senderName	    = senderName;	 
			_time		    = time; 
			_timeDelta	    = timeDelta;
			_message	    = message; 
			if (values && values.length > 0) _values = values;	
			_dispach();
		}
		
		public function get id():int 
		{
			return _id;
		}
		
		public function get key():String 
		{
			return _key;
		}
		
		public function get senderType():String 
		{
			return _senderType;
		}
		
		public function get senderName():String 
		{
			return _senderName;
		}
		
		public function get time():int 
		{
			return _time;
		}
		
		public function get timeDelta():int 
		{
			return _timeDelta;
		}
		
		public function get message():String 
		{
			return _message;
		}
		
		public function set message(value:String):void 
		{
			_message = value;
		}
		
		public function get values():Array 
		{
			return _values;
		}
		
		public function get stringValues():String
		{
			var v:String = "";
			if (values == null) return v;
			for (var i:int = 0; i < values.length; i++) v = v + values[i] + " " ;
			return v;
		}
		
		public function set values(value:Array):void 
		{
			_dispach();
			_values = value;
		}
		
		override public function toString():String
		{
			
			var t:Object = ZvrTime.milisecontsToTime(time);
			var ts:String = t.minutes+":"+t.seconds+"."+t.miliseconds;
			
			return 	spacer(_id, 4) +" " + 
					spacer(_senderType +" (" + _senderName + ") ", 50, ".") + " "+
					spacer(_message + " " + stringValues, 100, ".") + " " + 
					ts + " " + timeDelta;
			
		}
		
		private function _dispach():void
		{
			dispatchEvent(new ZvrTracerMessageEvent(ZvrTracerMessageEvent.CHANGE, this));
		}
		
		private function spacer(s:*, length:int, fill:String = " "):String
		{
			var t:String = String(s);
			
			
			for (var i:int = t.length; i < length; i = i + fill.length) 
			{
				t = t + fill;
			}
			
			t = t.substr(0, length);
			
			return t;
		}
		
	}

}