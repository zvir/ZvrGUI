package zvr.zvrGUI.skins.nd2d 
{
	import de.nulldesign.nd2d.display.Sprite2D;
	import de.nulldesign.nd2d.materials.Sprite2DMaterial;
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DTextureSkin extends ZvrSkin 
	{
		
		public function ZvrND2DTextureSkin(component:IZvrComponent, registration:Function) 
		{
			super(component, registration);
		}
		
		override protected function registerStyles():void 
		{
			registerStyle(ZvrND2DStyles.BACKGROUND, updateBackgroud);
		}
		
		override protected function create():void 
		{
			_body = new ZvrND2DSkin(getStyle(ZvrND2DStyles.BACKGROUND));
		}
		
		private function updateBackgroud():void 
		{
			if (!_body) return;
			
			var t:Texture2D = getStyle(ZvrND2DStyles.BACKGROUND);
			
			if (!sprite.texture)
			{
				sprite.setMaterial(new Sprite2DMaterial());
				sprite.setTexture(t);
			}
			else
			{
				sprite.texture = t;
			}
			
			sprite.x = sprite.texture.bitmapWidth * 0.5;
			sprite.y = sprite.texture.bitmapHeight * 0.5;
		}
		
		private function get sprite():Sprite2D
		{
			return Sprite2D(_body);
		}
		
		
	}

}