package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import zvr.zvrGUI.components.minimalDark.InputMD;
	import zvr.zvrGUI.components.minimalDark.LabelMD;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrGroup;
	import zvr.zvrGUI.layouts.ZvrAlignment;
	import zvr.zvrGUI.layouts.ZvrButtonLayout;
	import zvr.zvrGUI.layouts.ZvrHorizontalAlignment;
	import zvr.zvrGUI.layouts.ZvrVerticalAlignment;
	/**
	 * ...
	 * @author Zvir
	 */
	public class InputLabelMD extends ZvrGroup
	{
		
		public var label:LabelMD = new LabelMD();
		public var input:InputMD = new InputMD();
		
		
		
		public function InputLabelMD() 
		{
			
			autoSize = ZvrAutoSize.CONTENT_WIDTH;
			
			//contentPadding.padding = 10;
			height = 20;
			
			super.setLayout(ZvrButtonLayout);
			buttonLayout.gap = 2;
			buttonLayout.alignment = ZvrAlignment.HORIZONTAL;
			buttonLayout.horizontalAlign = ZvrHorizontalAlignment.LEFT;
			buttonLayout.verticalAlign = ZvrVerticalAlignment.MIDDLE;
			
			addChild(label);
			addChild(input);
			
			label.delegateStates = input;
			

			//input.labelAutoSize = false;
		}
		
		public function get buttonLayout():ZvrButtonLayout
		{
			return layout as ZvrButtonLayout;
		}
	}

}