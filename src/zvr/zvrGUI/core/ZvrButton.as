package zvr.zvrGUI.core 
{

	import zvr.zvrGUI.behaviors.ZvrBehaviors;
	import zvr.zvrGUI.behaviors.ZvrButtonBehavior;
	import zvr.zvrGUI.behaviors.ZvrDisable;
	import zvr.zvrGUI.behaviors.ZvrDragable;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrButton extends ZvrDisabledContainer
	{
		protected var _buttonBehavior:ZvrButtonBehavior;
		
		public function ZvrButton(skin:Class) 
		{
			super(skin);
				
			_buttonBehavior = new ZvrButtonBehavior();
			_behaviors.addBehavior(_buttonBehavior);
			
			_states.add(ZvrStates.NORMAL);
		}
		
		override protected function defineStates():void 
		{
			_states.define(ZvrStates.NORMAL);
			_states.define(ZvrStates.DOWN);
			_states.define(ZvrStates.OVER);
			_states.define(ZvrStates.FOCUSED);
		}
		
/*		private function stateChange(e:ZvrStateChangeEvent):void 
		{
			if (e.newStates.indexOf(ZvrStates.ENALBLED) != -1) _buttonBehavior.enabled = true;
			if (e.newStates.indexOf(ZvrStates.DISABLED) != -1) _buttonBehavior.enabled = false;
		}*/
		
	}

}

	
	
	
	
	
	