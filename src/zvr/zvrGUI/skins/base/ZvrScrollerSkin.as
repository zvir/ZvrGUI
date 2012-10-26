package zvr.zvrGUI.skins.base 
{
	import flash.display.Sprite;
	import zvr.zvrGUI.core.ZvrComponent;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrScrollerSkin extends ZvrSkin
	{
		
		
		public function ZvrScrollerSkin(component:ZvrComponent, registration:Function) 
		{
			super(component, registration);
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
			sprite.graphics.beginFill(0x000000, 0);
			sprite.graphics.drawRect(0, 0, componentWidth, componentHeight);
		}
		
		private function get sprite():Sprite
		{
			return _body as Sprite;
		}
		
		
	}

}