package zvr.zvrWorkers 
{
	import flash.events.Event;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrWorker extends ZvrActionReciver
	{
		
		protected var commender:MessageChannel;
		
		public function ZvrWorker() 
		{
			super();
			
			if (!Worker.isSupported || Worker.current.isPrimordial) return;
			
			commender = Worker.current.getSharedProperty("commenderChannel") as MessageChannel;
			commender.addEventListener(Event.CHANNEL_MESSAGE, commandMessage);
			
		}
		
		private function commandMessage(e:Event):void 
		{
			
			command("commandMessage");
			
			var d:* = commender.receive();
			
			command(d);
			
			try
			{
				if (!(d is Array)) return;
				callAction(d[0], d[1]);
			}
			catch (err:Error)
			{
				error(err);
			}
		}
		
		protected function command(d:*):void
		{
			
		}
		
		protected function error(e:Error):void
		{
			
		}
		
	}

}