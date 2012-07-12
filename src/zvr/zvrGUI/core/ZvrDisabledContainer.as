package zvr.zvrGUI.core 
{
	import zvr.zvrGUI.behaviors.ZvrDisable;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrDisabledContainer extends ZvrContainer implements IZvrInteractive
	{
		
		protected var _disableBehavior:ZvrDisable;
		
		public function ZvrDisabledContainer(skinClass:Class) 
		{
			
			super(skinClass);
			
			_disableBehavior = new ZvrDisable();
			_behaviors.addBehavior(_disableBehavior);
		}
		
		override protected function defineStates():void 
		{
			_states.define(ZvrStates.ENALBLED);
			_states.define(ZvrStates.DISABLED);
		}
		
		public function set enabled(value:Boolean):void 
		{
			_disableBehavior.enabledValue = value;
		}
		
		public function get enabled():Boolean 
		{
			return _disableBehavior.enabledValue;
		}
		
		
	}

}