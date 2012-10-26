package zvr.zvrGUI.core 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import zvr.zvrGUI.skins.base.ZvrBitmapSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrBitmap extends ZvrComponent 
	{

		private var _scaleMode:Boolean = true;
		
		public function ZvrBitmap() 
		{
			super(ZvrBitmapSkin);
			minHeight = 0;
			minWidth = 0;
		}
		
		public function get bitmapData():BitmapData
		{
			return getStyle(ZvrStyles.BITMAP);
		}
		
		public function get bitmap():Bitmap
		{
			return ZvrBitmapSkin(_skin).bitmap;
		}
		
		public function set bitmapData(value:BitmapData):void
		{
			setStyle(ZvrStyles.BITMAP, value);
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