package zvr.zvrGUI.components.minimalDark 
{
	import flash.events.Event;
	import zvr.zvrGUI.behaviors.ZvrFocusable;
	import zvr.zvrGUI.core.ZvrInput;
	import zvr.zvrGUI.core.ZvrLabel;
	import zvr.zvrGUI.core.ZvrLabelChangeKind;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.events.ZvrLabelEvent;
	import zvr.zvrGUI.skins.zvrMinimalDark.InputMDSkin;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class InputMD extends LabelMD
	{
		
		
		public function InputMD() 
		{
			super(InputMDSkin);
			
			InputMDSkin(skin).textField.addEventListener(Event.CHANGE, textChange);
			
			behaviors.addBehavior(new ZvrFocusable());
			
		}
		
		override protected function defineStates():void 
		{
			super.defineStates();
			_states.define(ZvrStates.FOCUSED);
		}
		
		private function textChange(e:Event):void 
		{
			_text = InputMDSkin(skin).textField.text;
			_dispatchEvent(ZvrLabelEvent.TEXT_CHANGE, ZvrLabelChangeKind.INPUT, _text);
		}
		
	}

}