package zvr.zvrGUI.components.nd2d 
{
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	import zvr.zvrGUI.skins.nd2d.ZvrND2DSimpleTextureSkin;
	import zvr.zvrGUI.skins.nd2d.ZvrND2DStyles;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DTextureComponent extends ZvrND2DComponent
	{
		
		public function ZvrND2DTextureComponent(t:Texture2D) 
		{
			super(ZvrND2DSimpleTextureSkin, ZvrND2DSprite2DBody);
			setStyle(ZvrND2DStyles.BACKGROUND, t);
		}
		
	}

}