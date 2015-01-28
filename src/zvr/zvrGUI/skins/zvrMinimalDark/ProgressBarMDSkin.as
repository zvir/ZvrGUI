package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import flash.display.Sprite;
	import zvr.zvrGUI.components.minimalDark.ProgressBarMD;
	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.skins.base.ZvrFlashSkin;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ProgressBarMDSkin extends ZvrSkin
	{
		
		public function ProgressBarMDSkin(component:IZvrComponent, registration:Function)
		{
			super(component, registration);
		}


		override protected function registerStyles():void
		{
			registerStyle(ZvrStyles.BG_COLOR, drawBackground);
			registerStyle(ZvrStyles.FG_COLOR, drawBackground);
			
			registerStyle(ZvrStyles.BG_ALPHA, drawBackground);
			registerStyle(ZvrStyles.FG_ALPHA, drawBackground);
			
			registerStyle("progress", drawBackground);
		}


		override protected function setStyles():void
		{
			setStyle(ZvrStyles.BG_COLOR, ColorsMD.c5);
			setStyle(ZvrStyles.FG_COLOR, ColorsMD.c1);
			
			setStyle(ZvrStyles.BG_ALPHA, 0.8);
			setStyle(ZvrStyles.FG_ALPHA, 0.8);
			setStyle("progress", 1);
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

		private function drawBackground():void
		{
			sprite.graphics.clear();
			
			sprite.graphics.beginFill(getStyle(ZvrStyles.BG_COLOR), getStyle(ZvrStyles.BG_ALPHA));
			sprite.graphics.drawRect(0, 0, componentWidth, componentHeight);
			sprite.graphics.endFill();
			
			trace(getStyle(ZvrStyles.FG_COLOR), getStyle(ZvrStyles.FG_ALPHA));
			
			sprite.graphics.beginFill(getStyle(ZvrStyles.FG_COLOR), getStyle(ZvrStyles.FG_ALPHA));
			sprite.graphics.drawRect(0, 0, componentWidth * getStyle("progress"), componentHeight);
			sprite.graphics.endFill();
		}

		private function get sprite():Sprite
		{
			return _body as Sprite;
		}
		
	}

}