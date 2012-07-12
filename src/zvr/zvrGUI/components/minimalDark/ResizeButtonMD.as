package zvr.zvrGUI.components.minimalDark 
{
	import zvr.zvrGUI.core.ZvrButton;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.zvrGUI.skins.zvrMinimalDark.ColorsMD;
	import zvr.zvrGUI.skins.zvrMinimalDark.ResizeButtonMDSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
	
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ResizeButtonMD extends ZvrButton 
	{
		
		public function ResizeButtonMD() 
		{
			super(ResizeButtonMDSkin);
			tabEnabled = false;
			width = 10;
			height = 10;
		}
		
		
		
	}

}