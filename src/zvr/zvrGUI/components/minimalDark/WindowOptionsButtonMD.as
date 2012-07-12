package zvr.zvrGUI.components.minimalDark 
{
	import flash.display.BitmapData;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrBitmap;
	import zvr.zvrGUI.core.ZvrButton;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	import zvr.zvrGUI.skins.zvrMinimalDark.WindowOptionsButtonMDSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class WindowOptionsButtonMD extends ZvrButton 
	{
		
		//public var label:LabelMD;
		public var icon:ZvrBitmap;
		
		public function WindowOptionsButtonMD(iconBitmap:BitmapData) 
		{
			
			//label = new LabelMD();
			tabEnabled = false;
			icon = new ZvrBitmap();
			
			super(WindowOptionsButtonMDSkin);	
			autoSize = ZvrAutoSize.CONTENT;
			
			//label.delegateStates = this;
			//label.labelAutoSize = true;
			//addChild(label);
			
			//label.text = "WTF"
			
			icon.bitmap = iconBitmap;
			icon.delegateStates = this;
			icon.setStyle(ZvrStyles.COLOR_ALPHA, 1);
			addChild(icon);
			
			minHeight = 7;
			minWidth = 7;
		}
		
		override protected function defineStates():void 
		{
			super.defineStates();
			_states.define(ZvrStates.HILIGHT);
		}
		
	}

}