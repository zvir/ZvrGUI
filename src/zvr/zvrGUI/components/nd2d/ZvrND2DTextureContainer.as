package zvr.zvrGUI.components.nd2d 
{
	import de.nulldesign.nd2d.display.Sprite2D;
	import de.nulldesign.nd2d.materials.texture.ASpriteSheetBase;
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	import zvr.zvrGUI.skins.nd2d.ZvrND2DStyles;
	import zvr.zvrGUI.skins.nd2d.ZvrND2DTextureSkin;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DTextureContainer extends ZvrND2DContainer 
	{
		
		public function ZvrND2DTextureContainer(t:Texture2D, s:ASpriteSheetBase= null, f:String = null) 
		{
			super(ZvrND2DTextureSkin, ZvrND2DBody);
			
			if (s)
			{
				setStyle(ZvrND2DStyles.BACKGROUND_SHEET, [t, s, f]);
			}
			else
			{
				setStyle(ZvrND2DStyles.BACKGROUND, t);
			}
		}
		
		public function get sprite():Sprite2D
		{
			return ZvrND2DTextureSkin(skin).sprite;
		}
		
	}

}