package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import flash.events.FocusEvent;
	import org.osflash.signals.Signal;
	import zvr.zvrGUI.components.minimalDark.InputMD;
	import zvr.zvrGUI.components.minimalDark.LabelMD;
	import zvr.zvrGUI.core.IZvrVStringComponent;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrGroup;
	import zvr.zvrGUI.layouts.ZvrAlignment;
	import zvr.zvrGUI.layouts.ZvrComplexLayout;
	import zvr.zvrGUI.layouts.ZvrHorizontalAlignment;
	import zvr.zvrGUI.layouts.ZvrVerticalAlignment;
	import zvr.zvrKeyboard.ZvrKey;
	import zvr.zvrKeyboard.ZvrKeyboard;
	/**
	 * ...
	 * @author Zvir
	 */
	public class InputLabelMD extends ZvrGroup implements IZvrVStringComponent
	{
		private var _change:Signal = new Signal(InputLabelMD, String);
		
		public var label:LabelMD = new LabelMD();
		public var input:InputMD = new InputMD();
		
		private var temp:String;
		
		
		public function InputLabelMD() 
		{
			
			autoSize = ZvrAutoSize.CONTENT_WIDTH;
			
			//contentPadding.padding = 10;
			height = 20;
			
			super.setLayout(ZvrComplexLayout);
			buttonLayout.gap = 2;
			buttonLayout.alignment = ZvrAlignment.HORIZONTAL;
			buttonLayout.horizontalAlign = ZvrHorizontalAlignment.LEFT;
			buttonLayout.verticalAlign = ZvrVerticalAlignment.MIDDLE;
			
			addChild(label);
			addChild(input);
			
			label.delegateStates = input;
			
			InputMDSkin(input.skin).textField.addEventListener(FocusEvent.FOCUS_IN, focusIn);

			//input.labelAutoSize = false;
		}
		
		private function focusIn(e:FocusEvent):void 
		{
			temp = input.text;
			InputMDSkin(input.skin).textField.addEventListener(FocusEvent.FOCUS_OUT, focusOut);
			ZvrKeyboard.ENTER.addReleasedCallback(checkChange);
		}
		
		private function checkChange():void 
		{
			//if (temp != input.text)
			//{
				_change.dispatch(this, value);
			//}
		}
		
		private function focusOut(e:FocusEvent):void 
		{
			InputMDSkin(input.skin).textField.removeEventListener(FocusEvent.FOCUS_OUT, focusOut);
			ZvrKeyboard.ENTER.removeReleasedCallback(checkChange);
			checkChange();
		}
		
		/* INTERFACE zvr.zvrGUI.core.IZvrVStringComponent */
		
		public function get change():Signal 
		{
			return _change;
		}
		
		public function set value(value:String):void 
		{
			input.text = value;
		}
		
		public function get value():String 
		{
			return input.text;
		}
		
		public function get buttonLayout():ZvrComplexLayout
		{
			return layout as ZvrComplexLayout;
		}
	}

}