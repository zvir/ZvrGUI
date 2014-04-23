package zvr.zvrGUI.components.nd2d 
{
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	import zvr.zvrGUI.skins.nd2d.ZvrND2DFileBitmapSkin;
	import zvr.zvrGUI.skins.nd2d.ZvrND2DStyles;
	import zvr.zvrGUI.skins.ZvrStyles;
	/**
	 * ...
	 * @author Zvir
	 */
	
	[Event(name = "ready", type = "zvr.zvrND2D.DynamicFileTextureEvent")]
	[Event(name = "loading", type = "zvr.zvrND2D.DynamicFileTextureEvent")]
	[Event(name = "progress", type = "zvr.zvrND2D.DynamiFileTextureEvent")]
	 
	public class ZvrND2DFileBitmap extends ZvrND2DComponent
	{
		
		public function ZvrND2DFileBitmap() 
		{
			super(ZvrND2DFileBitmapSkin, ZvrND2DBody);
			minHeight = 0;
			minWidth = 0;
		}
		
		public function get filePath():String
		{
			return getStyle(ZvrND2DStyles.FILE_PATH);
		}
		
		public function set filePath(value:String):void
		{
			setStyle(ZvrND2DStyles.FILE_PATH, value);
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