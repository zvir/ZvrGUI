package zvr.zvrUDPConnection
{
	import flash.events.DatagramSocketDataEvent;
	import flash.events.EventDispatcher;
	import flash.net.DatagramSocket;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Zvir
	 */
	
	
	[Event(name = "udpConected", type = "zvr.zvrUDPConnection.UDPSocketEvent")]
	
	[Event(name = "dataRecived", type = "zvr.zvrUDPConnection.UDPSocketEvent")]
	
	[Event(name = "dataSend", type = "zvr.zvrUDPConnection.UDPSocketEvent")]
	
	
	public class UDPSocket extends EventDispatcher
	{
		
		private var datagramSocket:DatagramSocket;
		
		private var _localPort:String;
		private var _localIP:String;
		private var _targetIP:String;
		private var _targetPort:String;
		
		public var reportLog:Boolean = true;
		
		public function UDPSocket()
		{
			datagramSocket = new DatagramSocket();
		}
		
		public function init(targetIP:String, targetPort:String, localIP:String, localPort:String):void
		{
			_targetPort = targetPort;
			_targetIP = targetIP;
			_localIP = localIP;
			_localPort = localPort;
			
			if (datagramSocket.bound)
			{
				datagramSocket.close();
				datagramSocket.removeEventListener(DatagramSocketDataEvent.DATA, dataReceived);
				datagramSocket = new DatagramSocket();
			}
			
			datagramSocket.bind(parseInt(_localPort), _localIP);
			datagramSocket.addEventListener(DatagramSocketDataEvent.DATA, dataReceived);
			datagramSocket.receive();
			
			//reportLog && tr("bind to: " + datagramSocket.localAddress + ":" + datagramSocket.localPort);
			
			dispatchUDPEvent(UDPSocketEvent.UDP_CONECTED);
			
			
		}
		
		private function dataReceived(event:DatagramSocketDataEvent):void
		{
			//Read the data from the datagram
			
			var response:String = event.data.readUTFBytes(event.data.bytesAvailable);
			
			//reportLog && tr("Received from " + event.srcAddress + ":" + event.srcPort + "> " + response);
			
			event.data.position = 0;
			
			dispatchUDPEvent(UDPSocketEvent.DATA_RECIVED, event.data);
		}
		
		public function sendMessage(message:String, targetIP:String = null, targetPort:String = null):void
		{
			var data:ByteArray = new ByteArray();
			data.writeUTFBytes(message);
			sendData(data, targetIP, targetPort);
		}
		
		public function sendData(data:ByteArray, targetIP:String = null, targetPort:String = null):void
		{
			//Create a message in a ByteArray
			
			if (!targetIP) targetIP = _targetIP;
			if (!targetPort) targetPort = _targetPort;
			
			try
			{
				datagramSocket.send(data, 0, 0, targetIP, parseInt(targetPort));
				
				//reportLog && tr("Sent message to " + targetIP + ":" + targetPort, data);
				
				dispatchUDPEvent(UDPSocketEvent.DATA_SEND);
				
			}
			catch (error:Error)
			{
				//reportLog && tr(error.message);
			}
		}
		
		
		
		private function dispatchUDPEvent(type:String, data:* = null):void
		{
			dispatchEvent(new UDPSocketEvent(type, data));
		}
		
	
	}

}