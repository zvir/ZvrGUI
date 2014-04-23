package zvr.zvrGUI.components.minimalDark 
{
	import zvr.zvrGUI.core.ZvrGroup;
	import zvr.zvrGUI.skins.zvrMinimalDark.ColorsMD;
	import zvr.zvrGUI.skins.zvrMinimalDark.LabelMDSkin;
	import zvr.zvrGUI.skins.zvrMinimalDarkFonts.MDFonts;
	import zvr.zvrGUI.skins.ZvrStyles;
	/**
	 * ...
	 * @author Zvir
	 */
	public class PropertyLabelMD extends ZvrGroup
	{
		
		private var _valueName			:LabelMD = new LabelMD();
		private var _value				:LabelMD = new LabelMD();
		
		public function PropertyLabelMD() 
		{
			
			minWidth = 250;
			minHeight = 15;
			height = 15;
			
			_valueName.right = 175;
			_value.width = 160;
			_value.right = 0;
			_value.minWidth = 170;
			_value.height = 15;
			
			LabelMDSkin(_value.skin).textField.selectable = true;
			
			_value.setStyle(ZvrStyles.LABEL_FONT, MDFonts.Stan0763);
			_value.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c1);	
			_valueName.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c1);
			
			addChild(_value);
			addChild(_valueName);
			
		}
		
		public function get valueName():LabelMD 
		{
			return _valueName;
		}
		
		public function get value():LabelMD 
		{
			return _value;
		}
		
	}

}