package zvr.zvrData 
{
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrPixelsData 
	{
		public var pixels:ByteArray;
		public var width:int;
		public var height:int;
		
		public function ZvrPixelsData() 
		{
			
		}
		
		public function setData(pixels:ByteArray, width:int, height:int):void
		{
			this.height = height;
			this.width = width;
			this.pixels = pixels;
		}
		
		public static function fromBitmapData(bitmapData:BitmapData):ZvrPixelsData
		{
			var d:ZvrPixelsData = new ZvrPixelsData();
			var b:ByteArray = new ByteArray();
			bitmapData.copyPixelsToByteArray(bitmapData.rect, b);
			d.setData(b, bitmapData.width, bitmapData.height);
			return d;
		}
		
		public static function toBitmapData(data:ZvrPixelsData):BitmapData
		{
			var b:BitmapData = new BitmapData(data.width, data.height, true, 0);
			data.pixels.position = 0;
			b.setPixels(b.rect, data.pixels);
			return b;
		}
		
	}

}