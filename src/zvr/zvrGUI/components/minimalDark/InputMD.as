package zvr.zvrGUI.components.minimalDark 
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import org.osflash.signals.Signal;
	import zvr.zvrGUI.behaviors.ZvrFocusable;
	import zvr.zvrGUI.core.ZvrInput;
	import zvr.zvrGUI.core.ZvrLabel;
	import zvr.zvrGUI.core.ZvrLabelChangeKind;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.events.ZvrLabelEvent;
	import zvr.zvrGUI.skins.zvrMinimalDark.InputMDSkin;
	import zvr.zvrKeyboard.ZvrKeyboard;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class InputMD extends LabelMD
	{
		
		
		public const textInput:Signal = new Signal(String);
		
		private var _change:Signal = new Signal(LabelMD, String);
		
		private var temp:String;

		public function InputMD(skinClass:Class = null) 
		{
			super(skinClass ? skinClass : InputMDSkin);
			
			InputMDSkin(skin).textField.addEventListener(Event.CHANGE, textChange);
			
			InputMDSkin(skin).textField.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			
			behaviors.addBehavior(new ZvrFocusable());
			
		}
		
		private function focusIn(e:FocusEvent):void 
		{
			temp = text;
			InputMDSkin(skin).textField.addEventListener(FocusEvent.FOCUS_OUT, focusOut);
			ZvrKeyboard.ENTER.addReleasedCallback(checkChange);
		}
		
		private function checkChange():void 
		{
			//if (temp != input.text)
			//{
				_change.dispatch(this,text);
			//}
		}
		
		private function focusOut(e:FocusEvent):void 
		{
			InputMDSkin(skin).textField.removeEventListener(FocusEvent.FOCUS_OUT, focusOut);
			ZvrKeyboard.ENTER.removeReleasedCallback(checkChange);
			checkChange();
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
			
			if (stage && stage.focus == InputMDSkin(skin).textField)
			{
				textInput.dispatch(InputMDSkin(skin).textField.text);
			}
			
		}
		
		public function get textField():TextField 
		{
			return InputMDSkin(skin).textField;
		}
		
		public function get change():Signal 
		{
			return _change;
		}
		
		
		
	}

}