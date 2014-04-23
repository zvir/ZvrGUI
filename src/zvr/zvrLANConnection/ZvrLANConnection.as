package zvr.zvrLANConnection 
{
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.GroupSpecifier;
	import flash.net.NetConnection;
	import flash.net.NetGroup;
	import flash.net.NetStream;
	/**
	 * ...
	 * @author Zvir
	 */
	[Event(name="connected", 	type="zvr.zvrLANConnection.ZvrLANConnectionEvent")] 
	[Event(name="ready", 		type="zvr.zvrLANConnection.ZvrLANConnectionEvent")] 
	[Event(name="message", 		type="zvr.zvrLANConnection.ZvrLANConnectionEvent")] 
	
	public class ZvrLANConnection extends EventDispatcher
	{
		
		
		private var netConn:NetConnection;
		private var group:NetGroup;
		private var _port:int;
		private var _groupName:String;
		
		private var _connected:Boolean;
		private var _ready:Boolean;
		private var netStream:NetStream;
		
		public function ZvrLANConnection() 
		{
			
		}
		
		public function init(port:int, group:String):void
		{
			_groupName = group;
			_port = port;
			netConn = new NetConnection()
			netConn.addEventListener(NetStatusEvent.NET_STATUS, netHandler);
			netConn.connect("rtmfp:");
		}
		
		private function netHandler(e:NetStatusEvent):void 
		{
			switch(e.info.code)
            {
                case "NetConnection.Connect.Success":
                    setupGroup();
					_connected = true;
					dispatchEvent(new ZvrLANConnectionEvent(ZvrLANConnectionEvent.CONNECTED));
                    break;
                case "NetGroup.Connect.Success":
				   _ready = true;
				   dispatchEvent(new ZvrLANConnectionEvent(ZvrLANConnectionEvent.READY));
                    break;
                case "NetGroup.Posting.Notify":
					dispatchEvent(new ZvrLANConnectionEvent(ZvrLANConnectionEvent.MESSAGE, e.info.message as IZvrLANMessage));
                    break;
				case "NetGroup.SendTo.Notify":
					dispatchEvent(new ZvrLANConnectionEvent(ZvrLANConnectionEvent.MESSAGE, e.info.message as IZvrLANMessage));
                    break;	
					
            }
		}
		
		private function setupGroup():void
        {
            var groupspec:GroupSpecifier = new GroupSpecifier(_groupName);
			
            groupspec.postingEnabled = true;
			groupspec.routingEnabled = true;
            groupspec.ipMulticastMemberUpdatesEnabled = true;
			groupspec.multicastEnabled = true;
			
            groupspec.addIPMulticastAddress("225.225.0.1:" + _port.toString());
			
            group = new NetGroup(netConn, groupspec.groupspecWithAuthorizations());
			
            group.addEventListener(NetStatusEvent.NET_STATUS, netHandler);
			
        }
		
		public function send(message:IZvrLANMessage):void
		{
			message.id = new Date().time;
			group.sendToAllNeighbors(message);
		}
		
		public function get ready():Boolean 
		{
			return _ready;
		}
		
		public function get connected():Boolean 
		{
			return _connected;
		}
		
		public function close():void
		{
			group.close();
			netConn.close();
		}
		
		public function dispose():void
		{
			if (group)
			{
				group.close();
				group.removeEventListener(NetStatusEvent.NET_STATUS, netHandler);
				group = null;
			}
			
			if (netConn)
			{
				netConn.close();
				netConn.removeEventListener(NetStatusEvent.NET_STATUS, netHandler);
				netConn = null;
			}
			
		}
	}

}