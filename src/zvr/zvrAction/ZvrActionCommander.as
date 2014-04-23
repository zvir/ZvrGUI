package zvr.zvrAction 
{
	import adobe.utils.CustomActions;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author ...
	 */
	public class ZvrActionCommander implements IZvrActionCommander
	{
		
		protected var actions:Dictionary;
		
		public function ZvrActionCommander() 
		{
			actions = new Dictionary();
		}
		
		public function addAction(action:ZvrAction, event:ZvrCommand):void
		{
			action.initialize();
			
			var a:Array = action.getTypes();
			
			for (var i:int = 0; i < a.length; i++) 
			{
				add(action, event, a[i]);
			}
		}
		
		private function add(action:ZvrAction, event:ZvrCommand, eventType:String):void
		{
			if (actions[event] == undefined)
			{
				actions[event] = {};
			}
			
			var o:Object = actions[event];
			
			if (o[eventType] == undefined)
			{
				o[eventType] = [];
			}
			
			var a:Array = o[eventType];
			
			if (a.indexOf(action) == -1)
			{
				a.push(action);
			}
			
			event.manager = this;
			
		}
		
		internal function eventExec(event:ZvrCommand, eventType:String, args:Array):void
		{
			if (actions[event] == undefined) return
			
			var a:Array = actions[event][eventType];
			
			if (!a) return;
			
			for (var i:int = 0; i < a.length; i++) 
			{
				ZvrAction(a[i]).exec(eventType, args);
			}
		}
		
	}

}