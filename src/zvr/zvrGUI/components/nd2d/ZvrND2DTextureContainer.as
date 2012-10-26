package zvr.zvrGUI.components.nd2d 
{
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	import zvr.zvrGUI.skins.nd2d.ZvrND2DStyles;
	import zvr.zvrGUI.skins.nd2d.ZvrND2DTextureSkin;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DTextureContainer extends ZvrND2DContainer 
	{
		
		public function ZvrND2DTextureContainer(t:Texture2D) 
		{
			super(ZvrND2DTextureSkin, ZvrND2DBody);
			setStyle(ZvrND2DStyles.BACKGROUND, t);
		}
		
	}

}