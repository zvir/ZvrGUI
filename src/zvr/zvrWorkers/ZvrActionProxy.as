package zvr.zvrWorkers 
{
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	import utils.type.getClass;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrActionProxy 
	{
		private var incomings:Object;
		private var outgoings:Dictionary;
		
		public function ZvrActionProxy(local:Class, remote:Class) 
		{
			incomings = { };
			
			var methods:XMLList;
			var method:XML;
			
			methods = describeType(getClass(local)).factory.method;
			
			for each (method in methods)
			{
				addIncoming(method.@name, this[method.@name]);
			}
			
			outgoings = new Dictionary();
			
			methods = describeType(getClass(remote)).factory.method;
			
			for each (method in methods)
			{
				addOutgoing(method.@name, this[method.@name]);
			}
			
		}
		
		protected function addIncoming(incomingName:String, incoming:Function):void
		{
			incomings[incomingName] = incoming;
		}
		
		protected function callIncoming(incomingName:String, args:Array):void
		{
			if (incomings[incomingName] == undefined) return;
			
			incomings[incomingName].apply(null, args);
		}
		
		private function addOutgoing(outgoingName:String, outgoing:Function):void
		{
			outgoings[outgoing] = outgoingName;	
		}
		
		protected function call(args:Object):void
		{
			var outgoingName:String = outgoings[args.callee];
			outgoingName && send(outgoingName, args);
		}
		
		protected function send(outgoingName:String, args:Object):void 
		{
			// TO BE OVERWRITTEN
		}
		
	}

}