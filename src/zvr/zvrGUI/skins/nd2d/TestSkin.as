package zvr.zvrGUI.skins.nd2d 
{
	import de.nulldesign.nd2d.display.Sprite2D;
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	import flash.display.BitmapData;

	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	/**
	 * ...
	 * @author Zvir
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
			var t:Texture2D = Texture2D.textureFromBitmapData(new BitmapData(200, 200, false, 0xFFFFFF));
			
			_body = new ZvrND2DSkin(t);
			
			drawBackground();
		}
		
		override protected function updateSize():void
		{
			drawBackground();
		}
		
		private function drawBackground():void
		{
			sprite.width = componentWidth;
			sprite.height = componentHeight;
			
			sprite.x = componentWidth * 0.5;
			sprite.y = componentHeight * 0.5;
			
			sprite.tint = getStyle(ZvrStyles.BG_COLOR);
		}
		
		private function get sprite():Sprite2D
		{
			return _body as Sprite2D;
		}
		
	}

}