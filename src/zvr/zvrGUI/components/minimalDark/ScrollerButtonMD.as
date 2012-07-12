package zvr.zvrGUI.components.minimalDark 
{
	import zvr.zvrGUI.core.ZvrButton;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.zvrGUI.skins.zvrMinimalDark.ColorsMD;
	import zvr.zvrGUI.skins.zvrMinimalDark.ScrollerButtonMDSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ScrollerButtonMD extends ZvrButton
	{
		
		public function ScrollerButtonMD() 
		{
			super(ScrollerButtonMDSkin);
			tabEnabled = false;
			minHeight = 3;
			minWidth = 3;
			width = 3;
			height = 3;
			
		}
		
	}

}