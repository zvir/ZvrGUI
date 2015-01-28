package zvr.zvrWorkers 
{
	import flash.events.Event;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.system.WorkerDomain;
	import flash.system.WorkerState;
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	import utils.type.getClass;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrWorkerHost extends ZvrActionProxy
	{
		private var worker:Worker;
		private var commander:MessageChannel;
		private var orderer:MessageChannel;
		
		public function ZvrWorkerHost(local:Class, remote:Class, swf:ByteArray) 
		{
			super(local, remote);
			
			worker = WorkerDomain.current.createWorker(swf, true);
			
			commander = Worker.current.createMessageChannel(worker);
			worker.setSharedProperty("commanderChannel", commander);
			
			orderer = worker.createMessageChannel(Worker.current);
			orderer.addEventListener(Event.CHANNEL_MESSAGE, ordererMessage)
			worker.setSharedProperty("orderChannel", orderer);
			
			worker.addEventListener(Event.WORKER_STATE, workerStateChange);
			worker.start();
		}
		
		override protected function send(commandName:String, args:Object):void 
		{
			commander && commander.send([commandName, args]);
		}
		
		private function workerStateChange(e:Event):void 
		{
			switch (worker.state) 
			{
				case  WorkerState.RUNNING: started(); break;
				case  WorkerState.TERMINATED: terminated(); break;
			}
		}
		
		private function ordererMessage(e:Event):void 
		{
			
			var d:* = orderer.receive();
			
			command(d);
			
			/*try
			{*/
				if (d is Array && d.length == 1 && d[0] == "initialized")
				{
					initialized();
				}
				else
				{
					callIncoming(d[0], d[1]);
				}
			/*}
			catch (err:Error)
			{
				throw err;
				error(err);
			}*/
		}
		
		protected function initialized():void 
		{
			// TO BE OVERWRITTEN
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
		
		public function terminate():void
		{
			worker.terminate();	
		}
		
		public function dispose():void
		{
			if (worker) 
			{
				if (worker.state != WorkerState.TERMINATED)
				{
					worker.terminate();
					worker.removeEventListener(Event.WORKER_STATE, workerStateChange);
				}
			}
			
			if (orderer) 
			{
				orderer.removeEventListener(Event.CHANNEL_MESSAGE, ordererMessage)
			}
			
			commander = null;
			orderer = null;
			worker = null;
			
		}
		
	}

}