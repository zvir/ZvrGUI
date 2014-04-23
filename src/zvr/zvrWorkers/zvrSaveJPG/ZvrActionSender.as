package zvr.zvrWorkers 
{
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	import utils.type.getClass;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrActionSender 
	{
		
		private var actions:Dictionary;
		
		public function ZvrActionSender() 
		{
			actions = new Dictionary();
			
			var methods:XMLList = describeType(getClass(this)).factory.method;
			
			for each ( var method:XML in methods )
			{
				addAction(method.@name, this[method.@name]);
			}
			
		}
		
		private function addAction(actionName:String, action:Function):void
		{
			actions[action] = actionName;	
		}
		
		protected function call(args:Object):void
		{
			var actionName:String = actions[args.callee];
			actionName && send(actionName, args);
		}
		
		protected function send(actionName:String, args:Object):void 
		{
			
		}
		
	}

}