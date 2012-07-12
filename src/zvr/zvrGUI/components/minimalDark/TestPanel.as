package zvr.zvrGUI.components.minimalDark 
{
	import zvr.zvrGUI.core.ZvrPanel;
	import zvr.zvrGUI.skins.zvrMinimalDark.TestPanelSkin;
	
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class TestPanel extends ZvrPanel 
	{
		
		public function TestPanel() 
		{
			super(TestPanelSkin);
			minWidth = 10;
			minHeight = 10;
		}
		
	}

}