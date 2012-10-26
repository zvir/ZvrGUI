package zvr.zvrGUI.skins.zvrMinimalDark
{
	import flash.display.Sprite;
	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.zvrGUI.skins.base.ZvrFlashSkin;
	import zvr.zvrGUI.skins.base.ZvrSkin;

	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */

	public class TestSkin extends ZvrSkin
	{

		public function TestSkin(component:IZvrComponent, registration:Function)
		{
			super(component, registration);
		}


		override protected function registerStyles():void
		{
			registerStyle(ZvrStyles.BG_COLOR, drawBackground);
		}


		override protected function setStyles():void
		{
			setStyle(ZvrStyles.BG_COLOR, 0xff0000);
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
			sprite.graphics.beginFill(getStyle(ZvrStyles.BG_COLOR), 0.5);
			sprite.graphics.drawRect(0, 0, componentWidth, componentHeight);
		}

		private function get sprite():Sprite
		{
			return _body as Sprite;
		}

	}

}