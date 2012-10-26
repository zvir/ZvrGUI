package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import flash.display.CapsStyle;
	import flash.display.Sprite;
	import zvr.zvrGUI.components.minimalDark.WindowMD;
	import zvr.zvrGUI.components.minimalDark.WindowStackMD;
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
	
	public class WindowStackMDSkin extends ZvrSkin 
	{
		
		public function WindowStackMDSkin(component:ZvrComponent, registration:Function) 
		{
			super(component, registration);
		}
		
		override protected function setStyles():void 
		{
			registerStyle(ZvrStyles.FR_COLOR, drawBackground);
			
			setStyle(ZvrStyles.FR_COLOR, ColorsMD.c3, ZvrStates.NORMAL);
			setStyle(ZvrStyles.FR_COLOR, ColorsMD.c2, ZvrStates.OVER);
			setStyle(ZvrStyles.FR_COLOR, ColorsMD.c2,ZvrStates.HILIGHT);
			
		}
		
		override protected function create():void
		{
			_body = new ZvrFlashSkin();
		}
		
		override protected function updateSize():void 
		{
			drawBackground();
		}
		
		protected function drawBackground():void 
		{
			sprite.graphics.clear();
			
			var stack:WindowStackMD = _component as WindowStackMD;
			
			if (stack.viewsNum == 0) return;
			sprite.graphics.lineStyle(1, getStyle(ZvrStyles.FR_COLOR), 1, false, "normal", CapsStyle.NONE);
			var w:Number = Math.min(stack.tabs.contentRect.width, stack.tabs.bounds.width);
			sprite.graphics.moveTo(w-1.5, 14.5);
			sprite.graphics.lineTo(componentWidth - 1, 14.5);
		}
		
		private function get sprite():Sprite
		{
			return Sprite(_body);
		}
		
	}

}