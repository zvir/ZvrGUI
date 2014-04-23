package zvr.zvrWorkers 
{
	import flash.utils.describeType;
	import utils.type.getClass;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrActionReciver 
	{
		private var actions:Object;
		
		public function ZvrActionReciver() 
		{
			actions = { };
			
			var methods:XMLList = describeType(getClass(this)).factory.method;
			
			for each ( var method:XML in methods )
			{
				addAction(method.@name, this[method.@name]);
			}
			
		}
		
		protected function addAction(actionName:String, action:Function):void
		{
			actions[actionName] = action;
		}
		
		protected function callAction(actionName:String, args:Array):void
		{
			if (actions[actionName] == undefined) return;
			
			actions[actionName].apply(null, args);
		}
	}

}