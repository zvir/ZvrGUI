package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import flash.display.Sprite;
	import zvr.zvrGUI.components.minimalDark.WindowOptionsButtonMD;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.skins.base.ZvrFlashSkin;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class WindowOptionsButtonMDSkin extends ZvrSkin 
	{
		
		public function WindowOptionsButtonMDSkin(component:ZvrComponent, registration:Function) 
		{
			super(component, registration);
		}
		
		override protected function create():void 
		{
			_body = new ZvrFlashSkin();
		}
		
		override protected function registerStyles():void 
		{
			//registerStyle(ZvrStyles.LABEL_COLOR, button.label.skin.getStylesRegistration(ZvrStyles.LABEL_COLOR));
			registerStyle(ZvrStyles.COLOR, button.icon.skin.getStylesRegistration(ZvrStyles.COLOR));
		}
		
		override protected function setStyles():void 
		{
			/*setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c2, ZvrStates.NORMAL);
			setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c0, [ZvrStates.NORMAL, ZvrStates.HILIGHT, ZvrStates.OVER]);
			setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c1, [ZvrStates.HILIGHT, ZvrStates.DOWN, ZvrStates.OVER]);
			setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c3, [ZvrStates.NORMAL, ZvrStates.HILIGHT, ZvrStates.DOWN]);
			setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c1, [ZvrStates.NORMAL, ZvrStates.HILIGHT]);
			*/
			
			setStyle(ZvrStyles.COLOR, ColorsMD.c2, ZvrStates.NORMAL);
			setStyle(ZvrStyles.COLOR, ColorsMD.c0, [ZvrStates.NORMAL, ZvrStates.HILIGHT, ZvrStates.OVER]);
			setStyle(ZvrStyles.COLOR, ColorsMD.c1, [ZvrStates.HILIGHT, ZvrStates.DOWN, ZvrStates.OVER]);
			setStyle(ZvrStyles.COLOR, ColorsMD.c3, [ZvrStates.NORMAL, ZvrStates.HILIGHT, ZvrStates.DOWN]);
			setStyle(ZvrStyles.COLOR, ColorsMD.c1, [ZvrStates.NORMAL, ZvrStates.HILIGHT]);
			
		}
		
		private function get button():WindowOptionsButtonMD
		{
			return _component as WindowOptionsButtonMD;
		}
		
	}

}