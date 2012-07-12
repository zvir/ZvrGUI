package zvr.zvrGUI.components.minimalDark 
{
	import zvr.zvrGUI.behaviors.ZvrSelectable;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.skins.zvrMinimalDark.ToggleButtonMDSkin;
	/**
	 * ...
	 * @author Zvir
	 */
	
	[Event(name="userInput",type="zvr.zvrGUI.events.ZvrEvent")]
	
	public class ToggleButtonMD extends ButtonMD
	{
		
		protected var _selectableBehavior:ZvrSelectable
		
		public function ToggleButtonMD() 
		{
			super(ToggleButtonMDSkin);
			_selectableBehavior = new ZvrSelectable();
			behaviors.addBehavior(_selectableBehavior);
		}
		
		override protected function defineStates():void 
		{
			super.defineStates();
			_states.define(ZvrStates.SELECTED);
		}
		
		public function set selected(v:Boolean):void
		{
			if (v)
				addState(ZvrStates.SELECTED);
			else
				removeState(ZvrStates.SELECTED);
		}
		
		public function get selected():Boolean
		{
			return checkState(ZvrStates.SELECTED);
		}
		
	}

}