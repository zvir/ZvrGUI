package clv.gui.core.behaviors 
{
	import clv.gui.core.IComponent;
	import flash.utils.Dictionary;
	import utils.type.getClass;
	import utils.type.getName;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class Behaviors 
	{
		private var _component:IComponent;
		private var _behaviors:Dictionary = new Dictionary();
		
		public function Behaviors(component:IComponent)
		{
			_component = component;
		}
		
		public function dispose():void
		{
			
			for (var name:String in _behaviors) 
			{
				removeBehavior(_behaviors[name]);
			}
			
			_component = null;
			_behaviors = null;
		}
		
		public function addBehavior(behavior:Behavior):void
		{
			/*if (!behavior.isCompatible(_component.skin)) 
			{
				trace("Behavior", behavior.name,"("+getName(getClass(behavior))+")", "is not compatible, check _availbleBehaviors in skin:", getName(getClass(_component.skin)));
				return;
			}*/
			
			if (_behaviors[behavior.name]) return;
			
			behavior.component = _component as IComponent;
			behavior.enabled = true;
			_behaviors[behavior.name] = behavior;
			
		}
		
		public function removeBehavior(behavior:Behavior):void
		{
			if (!_behaviors[behavior.name]) return;
			behavior.destroy();
			_behaviors[behavior.name] == undefined;
		}
		
		public function getBehavior(behaviorName:String):Behavior
		{
			return _behaviors[behaviorName];
		}
		
	}

}