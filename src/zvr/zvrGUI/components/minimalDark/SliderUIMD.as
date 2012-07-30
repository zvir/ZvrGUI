package zvr.zvrGUI.components.minimalDark 
{
	import flash.text.TextField;
	import zvr.zvrGUI.core.ZvrGroup;
	import zvr.zvrGUI.events.ZvrSliderEvent;
	import zvr.zvrGUI.skins.zvrMinimalDark.ColorsMD;
	import zvr.zvrGUI.skins.zvrMinimalDark.LabelMDSkin;
	import zvr.zvrGUI.skins.zvrMinimalDarkFonts.MDFonts;
	import zvr.zvrGUI.skins.ZvrStyles;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class SliderUIMD extends ZvrGroup 
	{
		
		public var slider:SliderMD;
		public var value:LabelMD;
		
		public var title:LabelMD;
		
		public function SliderUIMD() 
		{
			
			minWidth = 100;
			minHeight = 20;
			
			slider = new SliderMD();
			value = new LabelMD();
			title = new LabelMD();
			slider.left = 0;
			slider.right = 0;
			slider.top = 8;
			slider.bottom = 0;
			title.top = -6;
			title.left = -2;
			//value.labelAutoSize = false;
			value.width = 35;
			
			value.setStyle(ZvrStyles.LABEL_FONT, MDFonts.Uni05);
			value.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c2);
			
			title.setStyle(ZvrStyles.LABEL_FONT, MDFonts.Uni05);
			title.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c2);
			
			title.text = "Slider";
			
			value.right = 0;
			value.top = -6;
			
			addChild(value);
			addChild(slider);
			addChild(title);
			
			slider.addEventListener(ZvrSliderEvent.POSITION_CHANGED, updateValue);
			slider.addEventListener(ZvrSliderEvent.RANGE_CHANGED, updateValue);
			slider.addEventListener(ZvrSliderEvent.DYNAMIC_RANGE_CHANGED, updateValue);
			updateValue(null);
		}
		
		private function updateValue(e:ZvrSliderEvent):void 
		{
			if (slider.dynamicRange)
			{
				value.text = String(slider.rangeBegin).substr(0, 6) + " : "  + String(slider.rangeEnd).substr(0, 6);
			}
			else
			{
				value.text = String(slider.position).substr(0, 6);
			}
			
		}
		
	}

}