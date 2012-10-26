package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import flash.display.Sprite;
	import zvr.zvrGUI.components.minimalDark.SimpleButtonMD;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.skins.base.ZvrFlashSkin;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class SimpleButtonMDSkin extends ZvrSkin
	{
		
		public function SimpleButtonMDSkin(button:SimpleButtonMD, registration:Function) 
		{
			super(button, registration);
		}
		
		override protected function create():void
		{
			_body = new ZvrFlashSkin();
			drawBackground();
		}
		
		override protected function updateSize():void
		{
			drawBackground();
		}
		
		override protected function registerStyles():void
		{
			registerStyle(ZvrStyles.BG_COLOR, drawBackground);
			registerStyle(ZvrStyles.FR_TOP_COLOR, drawBackground);
			registerStyle(ZvrStyles.BG_ALPHA, drawBackground);
			registerStyle(ZvrStyles.FR_ALPHA, drawBackground);
		}
		
		override protected function setStyles():void
		{	
			setStyle(ZvrStyles.BG_COLOR, 0x008427, ZvrStates.NORMAL);
			setStyle(ZvrStyles.BG_COLOR, 0x00AE34, ZvrStates.OVER);
			setStyle(ZvrStyles.BG_COLOR, 0xCCFFDB, [ZvrStates.DOWN, ZvrStates.OVER]);
			
			setStyle(ZvrStyles.FR_TOP_COLOR, 0x847000, ZvrStates.NORMAL);
			setStyle(ZvrStyles.FR_TOP_COLOR, 0xFFF433, ZvrStates.OVER);
			setStyle(ZvrStyles.FR_TOP_COLOR, 0x0DC9FF, ZvrStates.FOCUSED);
			setStyle(ZvrStyles.FR_TOP_COLOR, 0x5B5900, [ZvrStates.DOWN, ZvrStates.OVER]);
			
			setStyle(ZvrStyles.BG_ALPHA, 0.4);
			setStyle(ZvrStyles.FR_ALPHA, 0.1);
			
			setStyle(ZvrStyles.BG_ALPHA, 0.1, ZvrStates.DISABLED);
			setStyle(ZvrStyles.FR_ALPHA, 0.1, ZvrStates.DISABLED);
			
		}
		
		private function drawBackground():void 
		{
			//trace(getStyle(ZvrStyles.BG_COLOR), getStyle(ZvrStyles.BG_ALPHA), getStyle(ZvrStyles.FR_COLOR), getStyle(ZvrStyles.FR_ALPHA));
			
			sprite.graphics.clear();
			sprite.graphics.lineStyle(1, getStyle(ZvrStyles.FR_TOP_COLOR), getStyle(ZvrStyles.FR_ALPHA));
			sprite.graphics.beginFill(getStyle(ZvrStyles.BG_COLOR), getStyle(ZvrStyles.BG_ALPHA));
			sprite.graphics.drawRect(0, 0, componentWidth, componentHeight);
		}
		
		private function get sprite():Sprite
		{
			return _body as Sprite;
		}
		
		private function get button():SimpleButtonMD
		{
			return _component as SimpleButtonMD;
		}
		
		
	}

}