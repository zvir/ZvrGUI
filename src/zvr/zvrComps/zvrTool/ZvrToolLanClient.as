package zvr.zvrComps.zvrTool 
{
	import zvr.zvrLANConnection.ZvrLANConnection;
	import zvr.zvrLANConnection.ZvrLANConnectionEvent;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrToolLanClient 
	{
		private var lan:ZvrLANConnection;
		
		public function ZvrToolLanClient() 
		{
			lan = new ZvrLANConnection();
			lan.addEventListener(ZvrLANConnectionEvent.READY, ready);
			lan.addEventListener(ZvrLANConnectionEvent.MESSAGE, message);
			lan.init(30003, "zvrTool");
		}
		
		private function ready(e:ZvrLANConnectionEvent):void 
		{
			
		}
		
		private function message(e:ZvrLANConnectionEvent):void 
		{
			if (e.message is ZvrToolLANMessage)
			{
				var m:ZvrToolLANMessage = e.message as ZvrToolLANMessage;
				if (m.trContent)
				{
					tr(m.trContent);
				}
			}
		}
		
		public function sendTR(counter:uint, s:String):void
		{
			var m:ZvrToolLANMessage = new ZvrToolLANMessage();
			m.trContent = s;
			
			lan.ready && lan.send(m);
		}
	}

}