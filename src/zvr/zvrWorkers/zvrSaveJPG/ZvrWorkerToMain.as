package zvr.zvrWorkers 
{
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	import utils.type.getClass;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrWorkerToMain extends Object
	{
		private var orderer:MessageChannel;
		private var orders:Dictionary;
		
		
		
		public function ZvrWorkerToMain() 
		{
			orders = new Dictionary();
		
			if (!Worker.isSupported || Worker.current.isPrimordial) return;
			
			orderer = Worker.current.getSharedProperty("orderChannel") as MessageChannel;
			
			init();
		}
		
		private function init():void
		{
			var methods:XMLList = describeType(getClass(this)).factory.method;
			
			for each ( var method:XML in methods )
			{
				addOreder(method.@name, this[method.@name]);
			}
			
		}
		
		private function addOreder(orderName:String, order:Function):void
		{
			orders[order] = orderName;	
		}
		
		protected function call(args:Object):void
		{
			var orderName:String = orders[args.callee];
			
			orderName && orderer && orderer.send([orderName, args]);
		}
		
	}

}