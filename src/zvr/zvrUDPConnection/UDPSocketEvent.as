package zvr.zvrUDPConnection 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class UDPSocketEvent extends Event 
	{
		private var _data:*;
		
		
		public static const UDP_CONECTED:String = "udpConected";
		public static const DATA_RECIVED:String = "dataRecived";
		public static const DATA_SEND:String = "dataSend";
		
		public function UDPSocketEvent(type:String, data:*= null, bubbles:Boolean = false, cancelable:Boolean = false)
		{ 
			super(type, bubbles, cancelable);
			_data = data;
		} 
		
		public override function clone():Event 
		{ 
			return new UDPSocketEvent(type, _data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("UDPSocketEvent", "type", "data", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get data():* 
		{
			return _data;
		}
		
		public function set data(value:*):void 
		{
			_data = value;
		}
		
	}
	
}