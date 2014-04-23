package zvr.zvrWorkers 
{
	import flash.events.Event;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.utils.describeType;
	import utils.type.getClass;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrMainHost extends ZvrActionReciver
	{
		protected var orderer:MessageChannel;
		private var _worker:Worker;
		
		public function ZvrMainHost(worker:Worker) 
		{
			super();
			_worker = worker;
			orderer = _worker.createMessageChannel(Worker.current);
			orderer.addEventListener(Event.CHANNEL_MESSAGE, ordererMessage)
			_worker.setSharedProperty("orderChannel", orderer);
		}
		
		private function ordererMessage(e:Event):void 
		{
			
			var d:* = orderer.receive();
			
			command(d);
			
			try
			{
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