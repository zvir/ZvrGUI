package zvr.zvrGUI.skins.zvrMinimalDark
{
	import flash.display.Sprite;
	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.zvrGUI.skins.base.ZvrFlashSkin;
	import zvr.zvrGUI.skins.base.ZvrSkin;

	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */

	public class BackgroundSkinMD extends ZvrSkin
	{

		public function BackgroundSkinMD(component:IZvrComponent, registration:Function)
		{
			super(component, registration);
		}


		override protected function registerStyles():void
		{
			registerStyle(ZvrStyles.BG_COLOR, drawBackground);
		}


		override protected function setStyles():void
		{
			setStyle(ZvrStyles.BG_COLOR, TextureFillsMD.getBitmapData(TextureFillsMD.PANEL_NORMAL_FILL_PATERN));
			setStyle(ZvrStyles.BG_COLOR, TextureFillsMD.getBitmapData(TextureFillsMD.PANEL_OVER_FILL_PATERN), ZvrStates.HILIGHT);
			setStyle(ZvrStyles.BG_COLOR, TextureFillsMD.getBitmapData(TextureFillsMD.PANEL_NORMAL_FILL_PATERN), ZvrStates.FOCUSED);
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
			var b1:* = getStyle(ZvrStyles.BG_COLOR)
			
			sprite.graphics.clear();
			
			if (b1) 
			{
				sprite.graphics.beginBitmapFill(b1);
				sprite.graphics.drawRect(0, 0, componentWidth, componentHeight);
				sprite.graphics.endFill();
			}
		}

		private function get sprite():Sprite
		{
			return _body as Sprite;
		}

	}

}