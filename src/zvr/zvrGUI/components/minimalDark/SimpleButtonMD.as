package zvr.zvrGUI.components.minimalDark 
{
	import zvr.zvrGUI.core.ZvrButton;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.zvrGUI.skins.zvrMinimalDark.SimpleButtonMDSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class SimpleButtonMD extends ZvrButton
	{
		
		public function SimpleButtonMD() 
		{
			super(SimpleButtonMDSkin);
			width = 15;
			height = 15;
			//mouseChildren = false;
		}
		
	}

}