package zvr.zvrGUI.components.minimalDark 
{
	import zvr.zvrGUI.core.ZvrDataContainer;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.zvrMinimalDark.DataContainerMDSkin;
	import zvr.zvrGUI.skins.zvrMinimalDark.TestPanelSkin;
	
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class DataContainerMD extends ZvrDataContainer 
	{
		
		public function DataContainerMD() 
		{
			super(ZvrSkin);
			minWidth = 10;
			minHeight = 10;
			
		}
		
	}

}