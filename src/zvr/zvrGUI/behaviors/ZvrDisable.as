package zvr.zvrGUI.behaviors 
{
	import zvr.zvrGUI.core.ZvrStates;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrDisable extends ZvrBehavior 
	{

		public static const NAME:String = "Disable";
		
		private var _enabled:Boolean = true;
		
		public function ZvrDisable() 
		{
			super(NAME);
		}
		
		public function set enabledValue(value:Boolean):void 
		{
			if (_enabled == value) return;
			
			_enabled = value;
			
			if (_enabled) 
			{
				component.addState(ZvrStates.ENALBLED)
				component.removeState(ZvrStates.DISABLED);
				enableBehavior(component.behaviors.getBehavior(ZvrRollOverHilight.NAME));
				enableBehavior(component.behaviors.getBehavior(ZvrButtonBehavior.NAME));
			}
			else
			{
				component.addState(ZvrStates.DISABLED);
				component.removeState(ZvrStates.ENALBLED);
				disableBehavior(component.behaviors.getBehavior(ZvrRollOverHilight.NAME));
				disableBehavior(component.behaviors.getBehavior(ZvrButtonBehavior.NAME));
			}
		}
		
		public function get enabledValue():Boolean 
		{
			return _enabled;
		}
		
		private function enableBehavior(b:ZvrBehavior):void
		{
			if (b) b.enabled = true;
		}
		
		private function disableBehavior(b:ZvrBehavior):void
		{
			if (b) b.enabled = false;
		}
		
	}

}