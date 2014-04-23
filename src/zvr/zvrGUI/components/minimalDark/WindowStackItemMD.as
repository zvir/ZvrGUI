package zvr.zvrGUI.components.minimalDark 
{
	import zvr.zvrGUI.core.ZvrContainer;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.zvrMinimalDark.PanelMDSkin;
	import zvr.zvrGUI.skins.zvrMinimalDarkFonts.MDFonts;
	import zvr.zvrGUI.skins.ZvrStyles;
	
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class WindowStackItemMD extends PanelMD 
	{
		
		public var title:WindowTitleMD;
		
		public function WindowStackItemMD() 
		{
			super();
			
			title = new WindowTitleMD();
			title.delegateStates = this;
			title.combineWithDelegateStates = true;
			title.autoSize = ZvrAutoSize.CONTENT;
			title.titleLabel.labelAutoSize = true;
			title.titleLabel.cutLabel = false;
			title.titleLabel.setStyle(ZvrStyles.LABEL_FONT, MDFonts.Stan0763);
		}
		
	}

}