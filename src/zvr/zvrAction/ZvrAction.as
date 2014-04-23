package zvr.zvrAction 
{
	/**
	 * ...
	 * @author ...
	 */
	public class ZvrAction 
	{
		
		public var enabled:Boolean = true;
		
		private var actions:Object;
		
		public function ZvrAction() 
		{
			actions = { };
		}
		
		internal function initialize():void 
		{
			init();
		}
		
		protected function  init():void
		{
			
		}
		
		internal function getTypes():Array
		{
			var a:Array = [];
			
			for (var name:String in actions) 
			{
				a.push(name);
			}
			
			return a;
		}
		
		protected function addAction(eventType:String, action:Function):void
		{
			actions[eventType] = action;
		}
		
		internal function exec(eventType:String, args:Array):void
		{
			if (actions[eventType] == undefined) return;
			actions[eventType].apply(this, args);
		}
		
	}

}