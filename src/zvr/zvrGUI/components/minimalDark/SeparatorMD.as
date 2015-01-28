package zvr.zvrGUI.components.minimalDark 
{
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.skins.zvrMinimalDark.SeparatorSkinMD;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class SeparatorMD extends ZvrComponent
	{
		
		public function SeparatorMD() 
		{
			super(SeparatorSkinMD);
			
			minHeight = 1;
			minWidth = 1;
			
			width = 1;
			height = 1;
		}
		
	}

}