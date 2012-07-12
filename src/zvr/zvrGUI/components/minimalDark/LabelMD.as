package zvr.zvrGUI.components.minimalDark 
{
	import flash.text.TextFormatAlign;
	import zvr.zvrGUI.core.ZvrLabel;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.zvrMinimalDark.ColorsMD;
	import zvr.zvrGUI.skins.zvrMinimalDark.LabelMDSkin;
	import zvr.zvrGUI.skins.zvrMinimalDarkFonts.MDFonts;
	import zvr.zvrGUI.skins.ZvrStyles;
	
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class LabelMD extends ZvrLabel 
	{
		
		public function LabelMD(skin:Class = null) 
		{
			super(skin ? skin : LabelMDSkin);
		}
		
		public function set labelAutoSize(value:Boolean):void 
		{
			LabelMDSkin(_skin).autoSize = value;
		}
		
		public function get labelAutoSize():Boolean 
		{
			return LabelMDSkin(_skin).autoSize;
		}
		
		public function set multiline(value:Boolean):void 
		{
			LabelMDSkin(_skin).multiline = value;
		}
		
		public function get multiline():Boolean 
		{
			return LabelMDSkin(_skin).multiline;
		}
		
		public function set align(value:String):void 
		{
			setStyle(ZvrStyles.LABEL_ALIGN, value);
		}
		
		public function get align():String 
		{
			return getStyle(ZvrStyles.LABEL_ALIGN);
		}
		
		public function set cutLabel(value:Boolean):void
		{
			LabelMDSkin(_skin).cutLabel = value;
		}
		
		public function get cutLabel():Boolean
		{
			return LabelMDSkin(_skin).cutLabel;
		}
	}

}