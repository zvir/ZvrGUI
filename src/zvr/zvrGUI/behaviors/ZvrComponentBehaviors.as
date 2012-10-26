package zvr.zvrGUI.behaviors 
{
	import flash.utils.Dictionary;
	import utils.type.getClass;
	import utils.type.getName;

	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.core.ZvrComponent;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrComponentBehaviors 
	{
		
		private var _component:IZvrComponent;
		private var _behaviors:Dictionary = new Dictionary();
		
		public function ZvrComponentBehaviors(component:IZvrComponent)
		{
			_component = component;
		}
		
		public function addBehavior(behavior:ZvrBehavior):void
		{
			if (!behavior.isCompatible(_component.skin)) 
			{
				trace("Behavior", behavior.name,"("+getName(getClass(behavior))+")", "is not compatible, check _availbleBehaviors in skin:", getName(getClass(_component.skin)));
				return;
			}
			
			if (_behaviors[behavior.name]) return;
			
			behavior.component = _component as ZvrComponent;
			behavior.enabled = true;
			_behaviors[behavior.name] = behavior;
			
		}
		
		public function removeBehavior(behavior:ZvrBehavior):void
		{
			if (!_behaviors[behavior.name]) return;
			behavior.destroy();
			_behaviors[behavior.name] == undefined;
		}
		
		public function getBehavior(behaviorName:String):ZvrBehavior
		{
			return _behaviors[behaviorName];
		}
		
	}

}