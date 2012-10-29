package zvr.zvrGUI.components.nd2d 
{
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	import zvr.zvrGUI.skins.nd2d.ZvrND2DBitmapSkin;
	import zvr.zvrGUI.skins.nd2d.ZvrND2DStyles;
	import zvr.zvrGUI.skins.ZvrStyles;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DBitmap extends ZvrND2DComponent
	{
		
		public function ZvrND2DBitmap() 
		{
			super(ZvrND2DBitmapSkin, ZvrND2DBody);
			minHeight = 0;
			minWidth = 0;
		}
		
		public function get texture():Texture2D
		{
			return getStyle(ZvrND2DStyles.TEXTURE);
		}
		
		public function set texture(value:Texture2D):void
		{
			setStyle(ZvrND2DStyles.TEXTURE, value);
		}
		
		public function get scaleMode():String 
		{
			return getStyle(ZvrStyles.AUTO_SIZE);
		}
		
		public function set scaleMode(value:String):void 
		{
			setStyle(ZvrStyles.AUTO_SIZE, value);
		}
		
	}

}