package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import zvr.zvrGUI.components.minimalDark.ButtonMD;
	import zvr.zvrGUI.components.minimalDark.ToggleButtonMD;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.skins.ZvrStyles;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ToggleButtonMDSkin extends ButtonMDSkin
	{
		
		public function ToggleButtonMDSkin(button:ToggleButtonMD, registration:Function) 
		{
			super(button, registration);
		}
		
		override protected function setStyles():void
		{	
			super.setStyles();
			
			setStyle(ZvrStyles.FR_BOTTOM_COLOR, ColorsMD.c3, [ZvrStates.NORMAL, ZvrStates.SELECTED]);
			setStyle(ZvrStyles.FR_BOTTOM_COLOR, ColorsMD.c2, [ZvrStates.OVER, ZvrStates.SELECTED]);
			
			setStyle(ZvrStyles.FR_TOP_COLOR, ColorsMD.c5, [ZvrStates.NORMAL, ZvrStates.SELECTED]);
			setStyle(ZvrStyles.FR_TOP_COLOR, ColorsMD.c5, [ZvrStates.OVER, ZvrStates.SELECTED]);
			
			setStyle(ZvrStyles.FR_TOP_WEIGHT, 2, [ZvrStates.NORMAL, ZvrStates.SELECTED]);
			setStyle(ZvrStyles.FR_BOTTOM_WEIGHT, 1, [ZvrStates.NORMAL, ZvrStates.SELECTED]);
			
		}
		
	}

}