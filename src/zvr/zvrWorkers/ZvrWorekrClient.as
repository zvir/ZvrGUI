package zvr.zvrWorkers 
{
	import flash.events.Event;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrWorekrClient extends ZvrActionProxy
	{
		protected var commander:MessageChannel;
		protected var orderer:MessageChannel;
		
		public function ZvrWorekrClient(local:Class, remote:Class) 
		{
			super(local, remote);
			
			if (!Worker.isSupported || Worker.current.isPrimordial) return;
			
			commander = Worker.current.getSharedProperty("commanderChannel") as MessageChannel;
			commander.addEventListener(Event.CHANNEL_MESSAGE, commandMessage);
			
			orderer = Worker.current.getSharedProperty("orderChannel") as MessageChannel;
			
			orderer.send(["initialized"]);
			
		}
		
		private function commandMessage(e:Event):void 
		{
			var d:* = commander.receive();
			command(d);
			
			try
			{
				if (!(d is Array)) return;
				callIncoming(d[0], d[1]);
			}
			catch (err:Error)
			{
				error(err);
			}
		}
		
		override protected function send(outgoingName:String, args:Object):void 
		{
			orderer && orderer.send([outgoingName, args]);
		}
		
		protected function command(d:*):void
		{
			// TO BE OVERWRITTEN
		}
		
		protected function error(e:Error):void
		{
			// TO BE OVERWRITTEN
		}
		protected function started():void 
		{
			// TO BE OVERWRITTEN
		}
		
		protected function terminated():void 
		{
			// TO BE OVERWRITTEN
		}
	}

}