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
	public class ZvrMainWorker extends ZvrActionSender
	{
		private var _worker:Worker;
		//private var commands:Dictionary;
		private var commander:MessageChannel;
		
		public function ZvrMainWorker(swf:ByteArray, giveAppPrivileges:Boolean = false) 
		{
			//commands = new Dictionary();
			
			_worker = WorkerDomain.current.createWorker(swf, true);
			
			commander = Worker.current.createMessageChannel(_worker);
			
			worker.setSharedProperty("commenderChannel", commander);
			worker.addEventListener(Event.WORKER_STATE, workerStateChange);
			
			//init();
			
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
		/*
		private function init():void
		{
			var methods:XMLList = describeType(getClass(this)).factory.method;
			
			for each ( var method:XML in methods )
			{
				addOreder(method.@name, this[method.@name]);
			}
			
		}
		
		private function addOreder(commanderName:String, command:Function):void
		{
			commands[command] = commanderName;	
		}*/
		
		
		protected function started():void 
		{
			
		}
		
		protected function terminated():void 
		{
			
		}
		/*
		protected function call(args:Object):void
		{
			var commandName:String = commands[args.callee];
			commandName && commander && commander.send([commandName, args]);
		}*/
		
		public function get worker():Worker 
		{
			return _worker;
		}
	}

}