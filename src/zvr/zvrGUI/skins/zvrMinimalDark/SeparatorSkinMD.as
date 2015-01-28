package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import flash.display.Sprite;
	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.skins.base.ZvrFlashSkin;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class SeparatorSkinMD extends ZvrSkin 
	{
		
		public function SeparatorSkinMD(component:IZvrComponent, registration:Function)
		{
			super(component, registration);
		}


		override protected function registerStyles():void
		{
			registerStyle(ZvrStyles.BG_COLOR, drawBackground);
			registerStyle(ZvrStyles.BG_ALPHA, drawBackground);
		}
		
		override protected function setStyles():void
		{
			setStyle(ZvrStyles.BG_COLOR, ColorsMD.c2);
			setStyle(ZvrStyles.BG_ALPHA, 1);
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
		}

		private function get sprite():Sprite
		{
			return _body as Sprite;
		}
		
	}

}