package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import flash.display.CapsStyle;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import zvr.zvrGUI.components.minimalDark.WindowTitleMD;
	import zvr.zvrGUI.core.ZvrBitmap;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.skins.base.ZvrFlashSkin;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
	
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class WindowTitleMDSkin extends ZvrSkin 
	{
		
		private var _matrix:Matrix = new Matrix();
		
		public function WindowTitleMDSkin(windowTitle:WindowTitleMD, registration:Function) 
		{
			super(windowTitle, registration);
		}
		
		override protected function create():void 
		{
			_body = new ZvrFlashSkin();
		}
		
		override protected function registerStyles():void 
		{
			registerStyle(ZvrStyles.BG_COLOR, drawBackground);
			registerStyle(ZvrStyles.FR_COLOR, drawBackground);
			registerStyle(ZvrStyles.LABEL_COLOR, windowTitle.titleLabel.getStylesRegistration(ZvrStyles.LABEL_COLOR));
			registerStyle(ZvrStyles.ICON, windowTitle.icon.getStylesRegistration(ZvrStyles.BITMAP));
			registerStyle(ZvrStyles.COLOR, windowTitle.icon.getStylesRegistration(ZvrStyles.COLOR));
		}
		
		override protected function setStyles():void 
		{	
			setStyle(ZvrStyles.BG_COLOR, TextureFillsMD.getBitmapData(TextureFillsMD.TITLE_NORMAL), ZvrStates.NORMAL);
			setStyle(ZvrStyles.BG_COLOR, TextureFillsMD.getBitmapData(TextureFillsMD.TITLE_OVER), ZvrStates.HILIGHT);
			setStyle(ZvrStyles.BG_COLOR, TextureFillsMD.getBitmapData(TextureFillsMD.TITLE_SELECTED), ZvrStates.FOCUSED);
			
			setStyle(ZvrStyles.FR_COLOR, ColorsMD.c3, ZvrStates.NORMAL);
			setStyle(ZvrStyles.FR_COLOR, ColorsMD.c2, ZvrStates.HILIGHT);
			setStyle(ZvrStyles.FR_COLOR, ColorsMD.c1, ZvrStates.FOCUSED);
			
			setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c2);
			setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c2, ZvrStates.NORMAL);
			setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c1, ZvrStates.HILIGHT);
			setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c1, ZvrStates.FOCUSED);
			
			setStyle(ZvrStyles.COLOR, ColorsMD.c2);
			setStyle(ZvrStyles.COLOR, ColorsMD.c2, ZvrStates.NORMAL);
			setStyle(ZvrStyles.COLOR, ColorsMD.c0, ZvrStates.HILIGHT);
			setStyle(ZvrStyles.COLOR, ColorsMD.c0, ZvrStates.FOCUSED);
		}
		
		override protected function updateSize():void 
		{
			drawBackground();
		}
		
		private function drawBackground():void 
		{
			var v:* = getStyle(ZvrStyles.BG_COLOR)
			
			sprite.graphics.clear();
			
			if (v) 
			{
				
				sprite.graphics.beginBitmapFill(v, _matrix);
				sprite.graphics.lineStyle(0, 0, 0);
				
				sprite.graphics.moveTo(0, 0);
				sprite.graphics.lineTo(componentWidth - componentHeight, 0);
				
				sprite.graphics.lineStyle(1, getStyle(ZvrStyles.FR_COLOR), 1, false, "normal", CapsStyle.NONE);
				sprite.graphics.lineTo(componentWidth, componentHeight);
				sprite.graphics.lineStyle(0, 0, 0);
				sprite.graphics.lineTo(0, componentHeight);
				sprite.graphics.lineTo(0, 0);
				
				sprite.graphics.endFill();
				
			}
			
		}
		
		private function get sprite():Sprite
		{
			return Sprite(_body);
		}
		
		private function get windowTitle():WindowTitleMD
		{
			return WindowTitleMD(_component);
		}
		
	}

}