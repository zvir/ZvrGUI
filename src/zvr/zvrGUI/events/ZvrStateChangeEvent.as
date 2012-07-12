package zvr.zvrGUI.events 
{
	import flash.events.Event;
	import zvr.zvrGUI.core.ZvrComponent;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrStateChangeEvent extends Event 
	{
		public static const CHANGE:String = "stateChange";
		
		private var _component:ZvrComponent;
		private var _newStates:Array;
		private var _currentStates:Array;
		private var _removedStates:Array;
		
		public function ZvrStateChangeEvent(type:String, component:ZvrComponent, newStates:Array, removedStates:Array, currentStates:Array, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_removedStates = removedStates == null ? [] : removedStates;
			_currentStates = currentStates;
			_newStates = newStates == null ? [] : newStates;
			_component = component;
			
		} 
		
		public function isRemoved(state:String):Boolean
		{
			return _removedStates.indexOf(state) != -1;
		}
		
		public function isNew(state:String):Boolean
		{
			return _newStates.indexOf(state) != -1;
		}
		
		public function isCurrent(state:String):Boolean
		{
			return _currentStates.indexOf(state) != -1;
		}
		
		public override function clone():Event 
		{ 
			return new ZvrStateChangeEvent(type, _component, _newStates, _removedStates, currentStates, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ZvrStateChangeEvent", "type",  "_component", "newState", "currentStates", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get component():ZvrComponent 
		{
			return _component;
		}
		
		public function get newStates():Array 
		{
			return _newStates;
		}
		
		public function get currentStates():Array 
		{
			return _currentStates;
		}
		
		public function get removedStates():Array 
		{
			return _removedStates;
		}
		
	}
	
}