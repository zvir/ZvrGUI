package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import flash.display.CapsStyle;
	import flash.display.Sprite;
	import zvr.zvrGUI.components.minimalDark.ResizeButtonMD;
	import zvr.zvrGUI.components.minimalDark.SimpleButtonMD;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.skins.base.ZvrFlashSkin;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
	
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ResizeButtonMDSkin extends ZvrSkin 
	{
		
		public function ResizeButtonMDSkin(resizeButton:ResizeButtonMD, registration:Function) 
		{
			super(resizeButton, registration);
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
		}
		
		override protected function setStyles():void
		{	
			setStyle(ZvrStyles.BG_COLOR, ColorsMD.c3, ZvrStates.NORMAL);
			setStyle(ZvrStyles.BG_COLOR, ColorsMD.c1, ZvrStates.OVER);
			setStyle(ZvrStyles.BG_COLOR, ColorsMD.c0, [ZvrStates.OVER, ZvrStates.DOWN] );
		}
		
		private function drawBackground():void 
		{
			sprite.graphics.clear();
			
			sprite.graphics.lineStyle(1.3, getStyle(ZvrStyles.BG_COLOR), 1, false, "normal", CapsStyle.NONE);
			
			sprite.graphics.moveTo(4, 1);
			sprite.graphics.lineTo(1, 4);
			
			sprite.graphics.moveTo(9, 3);
			sprite.graphics.lineTo(3, 9);
			
			sprite.graphics.lineStyle(1, 0, 0);
			sprite.graphics.beginFill(0, 0);
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