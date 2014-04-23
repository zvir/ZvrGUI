package clv.gui.core.states 
{
	import clv.gui.core.IComponent;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class StateSignal 
	{
		public var removed:Array;
		public var added:Array;
		public var component:IComponent;
		public var current:Array;
		
		public function StateSignal(component:IComponent, added:Array, removed:Array, current:Array) 
		{
			this.removed = removed;
			this.added = added;
			this.component = component;
			this.current = current;
		}
		
	}

}