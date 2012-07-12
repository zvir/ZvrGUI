package zvr.zvrGUI.skins.base 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrTextureFills 
	{
		
		
		[Embed(source = '../../../../../assets/masks/pink.png')]
		private static const Pink:Class
		private static const PinkBitmap:Bitmap = new Pink();
		
		[Embed(source = '../../../../../assets/masks/green.png')]
		private static const Green:Class
		private static const GreenBitmap:Bitmap = new Green();
		
		[Embed(source = '../../../../../assets/masks/blue.png')]
		private static const Blue:Class
		private static const BlueBitmap:Bitmap = new Blue();
		
		[Embed(source = '../../../../../assets/masks/red.png')]
		private static const Red:Class
		private static const RedBitmap:Bitmap = new Red();
		
		public static const PINK			: String = "Pink";
		public static const GREEN			: String = "Green";
		public static const BLUE			: String = "Blue";
		public static const RED				: String = "Red";
		
		
		private static const texturies:Object =
		{
			Pink			: PinkBitmap,
			Green			: GreenBitmap,
			Blue			: BlueBitmap,
			Red				: RedBitmap
			
		}                               
		
		public static function getBitmapData(texture:String, clone:Boolean = false):BitmapData
		{                               
			return clone ? Bitmap(texturies[texture]).bitmapData.clone() : Bitmap(texturies[texture]).bitmapData;
		}
		
	}

}





















