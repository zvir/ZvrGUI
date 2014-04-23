package zvr.zvrGUI.components.g2d 
{
	import com.genome2d.textures.GTexture;
	import zvr.zvrGUI.skins.g2d.ZvrG2DSpriteSkin;
	import zvr.zvrGUI.skins.g2d.ZvrG2DStyles;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrG2DSprite extends ZvrG2DComponent
	{
		
		
		public function ZvrG2DSprite(texture:GTexture = null) 
		{
			super(ZvrG2DSpriteSkin, ZvrG2DBody)
			
			if (texture)
			{
				setStyle(ZvrG2DStyles.TEXTURE, texture);
			}
			
		}
		
		public function get autoSizeToTexture():Boolean 
		{
			return ZvrG2DSpriteSkin(_skin).autoSizeToTexture;
		}
		
		public function set autoSizeToTexture(value:Boolean):void 
		{
			ZvrG2DSpriteSkin(_skin).autoSizeToTexture = value;
		}
		
	}

}