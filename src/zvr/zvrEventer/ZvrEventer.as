package zvr.zvrEventer 
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrEventer implements IEventDispatcher
	{
		
		private var _listnersStrong:Dictionary;
		private var _listnersWeak:Dictionary;
		
		
		
		public function ZvrEventer() 
		{
			_listnersStrong = new Dictionary();
			_listnersWeak = new Dictionary(true);
		}
		
		public function add(type:String, listener:Function):void
		{
			
		}
		
		public function addOnce(type:String, listener:Function):void
		{
			
		}
		
		
		/* INTERFACE flash.events.IEventDispatcher */
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			
		}
		
		public function remove(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			
		}
		
		public function dispatch(event:ZvrEvent):Boolean 
		{
			
		}
		
		public function hasEventListener(type:String):Boolean 
		{
			
		}
		
		public function willTrigger(type:String):Boolean 
		{
			
		}
		
		
		
	}

}